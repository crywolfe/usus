### Set Up the WEBrick SSL Server on LocalHost

Out of the box, Rails with WEBrick server does not provide an easy solution to build an SSL server using HTTPS for development purposes on localhost.

With WEBrick as the default development server, one cannot just configure Rails to enable SSL, because WEBrick must be invoked with SSL support turned on.  This means that modifying `config.ru` is necessary.

WEBrick is a Rack-based server.  The `config.ru` file is used by Rack-based servers to start the application.

Running an HTTPS WEBrick server on `https://localhost:8080` is not difficult and can be accomplished as described below.  

Open the `config.ru` file which is located in the root directory of the Rails application.  

Delete the line containing `run Rails.application`.

Insert the following code at the top of the config.ru file above all default `require` code.  This new code implements the enabling of SSL and also provides the SSL certificate name.  This tells WEBrick to boot up with SSL support.


```
require 'openssl' # Implements the Secure Sockets Layer protocols.
require 'webrick' # Configures WEBrick.
require 'webrick/https' # Configures WEBrick as an HTTPS server.
```

The application is now ready to create the HTTPS server.  To do so, one needs to take two steps.
(1) enable SSL, and
(2) provide an SSL certificate name.

Both of those steps are accomplished by inserting the code found below.  The below described code needs to be inserted below all the `require` lines.  It is replacing the `run Rails.application`. It specifically implements the enabling of SSL and also provides the SSL certificate name.

```
Rack::Handler::WEBrick.run Rails.application, {
  SSLEnable: true,
  SSLPrivateKey: OpenSSL::PKey::RSA.new(
    File.open('certs/server.key').read
  ),
  SSLCertificate: OpenSSL::X509::Certificate.new(
    File.open('certs/server.crt').read
  )
}
```
The `certs/server.key` and `certs/server.crt` files need to be created.  Both files refer to keys and certificates the developer creates on their local environments.

Create the certs directory inside the root directory of the application using the standard `mkdir certs` command.

Once a certs directory is created then run the following commands.
```
cd certs
ssh-keygen -f server.key
openssl req -new -key server.key -out request.csr
openssl x509 -req -days 365 -in request.csr -signkey server.key -out server.crt
```
Note that when running both `openssl` commands, other security related questions will be asked.  Follow the prompts accordingly.

Open the `Gemfile`.  Add the following code to the gemfile.

```
gem 'rack'
gem 'webrick'
```

In the terminal run bundle to ensure the Rails application recognizes the needed gems.
`$ bundle`

It is time to start the HTTPS server.
Type `rails s`.

When done, the similar output to the output below should be expected.

```
=> Booting WEBrick
=> Rails 4.1.0 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Notice: server is listening on all interfaces (0.0.0.0). Consider using 127.0.0.1 (--binding option)
=> Ctrl-C to shutdown server
[2014-05-31 16:42:53] INFO  WEBrick 1.3.1
[2014-05-31 16:42:53] INFO  ruby 2.1.0 (2013-12-25) [x86_64-darwin13.0]
[2014-05-31 16:42:53] INFO
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 10118111599302972979 (0x8c6ac0e43a369633)
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=us, ST=ny, L=ny, O=ga, OU=ga, CN=ga/emailAddress=name@email.com
        Validity
            Not Before: May 14 14:57:39 2014 GMT
            Not After : May 14 14:57:39 2015 GMT
        Subject: C=us, ST=ny, L=ny, O=ga, OU=ga, CN=ga/emailAddress=name@email.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:c0:6c:7c:2d:b3:b0:f3:ac:d6:de:84:eb:ea:59:
                    7d:86:d7:f9:47:64:cc:57:e8:84:d7:df:a9:21:43:
                    ...
                    25:81
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha1WithRSAEncryption
         4e:88:c9:7d:a8:0e:77:54:34:94:00:57:23:64:a3:bc:1d:40:
         ...
         24:5b:06:6f
[2014-05-31 16:42:53] INFO  WEBrick::HTTPServer#start: pid=2443 port=8080
```
If the above output shows up, a successful HTTPS server has been created on port 8080.

###Stopping the Rails WEBrick SSL Server

Be aware that `ctrl-c` might not be enough to kill the process, so it may be necessary to stop the process manually through the `ps` or `kill` commands.

For example, one can run the following commands to kill the process.

`ps aux | grep ruby`

This chained command will provide an output similar to the following.
`$           2443   0.0  1.5  2578296 123204 s000  T     4:42PM   0:02.98 $/.rbenv/versions/2.1.0/bin/ruby bin/rails s`

The first number "2443" is the process id number.  `kill -9 [PID]` will shutdown the server.  In the example, `kill -9 2443` will shutdown the server.
