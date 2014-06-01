### Setting Up the SSL Server

Out of the box, WEBrick does not provide the developer with an SSL server.

Running an https WEBrick server on `https://localhost:3000` can be accomplished as described below.  

The following code needs to inserted into the `config.ru` file located in the root of the Rails application.

The `config.ru` file is used by Rack-based servers, of which WEBrick is one, to start the application.



```
# Need to require openssl, webrick and webrick, https

require 'openssl'
require 'webrick'
require 'webrick/https'

require ::File.expand_path('../config/environment',  __FILE__)
```



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

The `certs/server.key` and `certs/server.crt` refers to keys and certificates the developer creates on their local environments.

The certs folder should be created in the root directory of the application.

Once a certs directory is created then run the following commands.

`cd certs`
`ssh-keygen -f server.key`
`openssl req -new -key server.key -out request.csr`
`openssl x509 -req -days 365 -in request.csr -signkey server.key -out server.crt`

More information can be found here.
http://houseofding.com/2008/11/generate-a-self-signed-ssl-certificate-for-local-development-on-a-mac/

Now it is time to start the server.

`rails s`

```
$ rails s
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
                    f4:ff:74:8d:c0:e3:40:45:97:3f:f1:f6:f3:a5:fb:
                    f9:0c:f3:d1:7c:a1:91:e8:10:1a:04:02:0c:ad:18:
                    f2:b2:bd:4d:79:a3:d0:ab:51:5a:d4:c8:4d:5a:e7:
                    d2:18:85:dd:d5:50:7b:a0:42:e4:66:a4:5a:df:31:
                    c8:f6:34:a9:9b:bb:55:4d:f6:f1:6e:b9:f2:4e:e8:
                    db:8d:2b:21:1c:7c:42:f5:73:24:eb:db:cb:ff:65:
                    5b:18:ed:e6:b9:fa:a1:45:51:9e:02:a8:62:bc:91:
                    8a:bd:02:64:ba:4f:6c:2e:68:8a:75:36:ae:2e:2d:
                    c2:7d:d3:a9:fd:24:2a:4d:08:73:ac:85:37:37:50:
                    dd:b0:2e:ec:09:c4:be:e7:4c:ab:3e:92:8e:a4:e6:
                    1f:45:4e:a9:ae:e6:48:29:21:49:d4:db:00:6c:fc:
                    ac:43:b0:a2:ac:64:b3:9c:88:6e:cb:cf:b4:ee:da:
                    11:84:ad:05:9b:35:4d:95:89:48:d7:06:10:d8:a7:
                    b4:08:54:53:c9:5e:dd:9b:78:d9:fd:c4:b1:2d:6a:
                    19:8f:48:7b:f8:98:e2:37:23:0c:95:89:04:55:35:
                    25:81
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha1WithRSAEncryption
         4e:88:c9:7d:a8:0e:77:54:34:94:00:57:23:64:a3:bc:1d:40:
         76:98:3d:fb:30:a5:44:28:dc:ff:2b:93:dc:e3:5d:e1:e5:97:
         7b:4b:f9:44:f5:84:18:45:4d:ba:e1:48:00:41:92:96:b0:71:
         08:0b:bd:1d:a6:23:a2:c8:b7:0a:e5:eb:b5:4f:7a:ab:ea:50:
         bf:48:e7:de:aa:6a:1c:ec:82:46:ad:e4:ea:59:35:dd:26:71:
         da:e9:9a:91:31:1a:31:ee:85:06:df:5a:3f:04:63:3f:7b:8e:
         84:3b:c7:2c:e2:c1:1c:aa:04:e7:69:c5:a3:a4:75:12:e0:21:
         78:d9:f4:19:37:9e:d3:1c:70:13:0e:2a:58:5e:81:67:15:c3:
         09:26:7d:dc:0d:18:9b:4b:fc:e1:c1:ce:fc:67:eb:31:bf:57:
         81:e7:3c:38:87:47:9d:a3:c4:ea:d3:0c:67:06:14:bd:1e:46:
         10:93:da:1a:b9:0c:a7:01:1a:c0:ac:65:be:fb:7c:00:99:be:
         73:0e:55:dd:8e:87:ad:f9:29:ff:45:4f:8f:24:1d:1f:80:1a:
         72:ba:f2:17:21:3f:18:42:69:9c:88:3b:35:6c:1b:d5:60:08:
         fa:be:de:b0:c0:83:ce:3b:39:92:7a:9f:65:1d:4c:4e:71:44:
         24:5b:06:6f
[2014-05-31 16:42:53] INFO  WEBrick::HTTPServer#start: pid=2443 port=8080
```

###Stopping the Rails WEBrick SSL Server

Stopping the server requires additional commands.

`ps aux | grep ruby`

This chained command will provide an output similar to the following.
`$           2443   0.0  1.5  2578296 123204 s000  T     4:42PM   0:02.98 $/.rbenv/versions/2.1.0/bin/ruby bin/rails s`

The first number "2443" is called the process id number.  `kill -9 [PID]` will shutdown the server.

Since the PID is "2443" `kill -9 2443` will shut it down.
