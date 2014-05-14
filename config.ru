# This file is used by Rack-based servers to start the application.

require 'openssl'
require 'webrick'
require 'webrick/https'

require ::File.expand_path('../config/environment',  __FILE__)

Rack::Handler::WEBrick.run Rails.application, {
  SSLEnable: true,
  SSLPrivateKey: OpenSSL::PKey::RSA.new(
    File.open('certs/server.key').read
  ),
  SSLCertificate: OpenSSL::X509::Certificate.new(
    File.open('certs/server.crt').read
  )
}
