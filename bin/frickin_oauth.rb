require 'oauth'
require 'httparty'
require 'hmac-sha1'

EXCHANGE_URI = "https://api.linkedin.com/uas/oauth/accessToken"
MY_PROFILE_URI = "http://api.linkedin.com/v1/people/~"

OAUTH_HEADER_KEY = "Authorization"
OAUTH_VERSION = "1.0"

API_KEY = "77hbzaeoi6qcng"
SECRET_KEY = "rZmdHiNNHsxjNgpl"
ACCESS_TOKEN = "fbUzzWE6bmHKPLoDvtuRjLEEM1FnzOIHAlGI"
MEMBER_ID = "iqOlIpZP93"

SIGN_METHOD = "HMAC-SHA1"

def make_oauth_header_value str
  "OAuth #{str}"
end

def sign(key, base_string)
  digest = OpenSSL::Digest::Digest.new('sha1')
  hmac = OpenSSL::HMAC.digest(digest, key, base_string)
  Base64.encode64(hmac).chomp.gsub(/\n/, '')
end

def make_nonce
  rand(10 ** 30).to_s.rjust(30,'0')
end

def oauth_header
  hmac2 = Base64.encode64((HMAC::SHA1.new('secret_key') << 'signature').digest).strip


  oauth_params = {
    oauth_consumer_key: API_KEY,
    oauth_token: ACCESS_TOKEN,
    oauth_signature_method: SIGN_METHOD,
    oauth_signature: sign(SECRET_KEY, ACCESS_TOKEN + MEMBER_ID),
    oauth_timestamp: Time.now.strftime("%s"),
    oauth_version: OAUTH_VERSION,
    oauth_nonce: make_nonce
  }

  oauth_header_params = oauth_params.collect {|k, v| "#{k}=\"#{v}\"" }.join(", ")

  make_oauth_header_value(oauth_header_params)
end

def oauth_exchange_request
  headers = {
    OAUTH_HEADER_KEY => oauth_header
  }

  puts headers.inspect

  HTTParty.post(EXCHANGE_URI, query: oauth_params)
end

def profile_request
  headers = {
    OAUTH_HEADER_KEY => oauth_header
  }

  puts headers.inspect

  HTTParty.get(MY_PROFILE_URI,
    headers: headers,
    verbose: true,
    logger: "httparty",
    log_level: "warn",
    log_format: "apache"
  )
end

def lib_profile_request
  configuration = { :site => 'https://api.linkedin.com',
                    :authorize_path =>   'https://www.linkedin.com/uas/oauth/authenticate',
                    :request_token_path => 'https://api.linkedin.com/uas/oauth/requestToken',
                    :access_token_path => 'https://api.linkedin.com/uas/oauth/accessToken' }


  oauth = OAuth::Consumer.new(API_KEY, SECRET_KEY, configuration)

  request_token = OAuth::RequestToken.new(oauth, ACCESS_TOKEN, SECRET_KEY)

  new_token = request_token.get_access_token(:oauth_verifier => ACCESS_TOKEN + SECRET_KEY)
end

puts lib_profile_request.inspect
