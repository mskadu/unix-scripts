# My frequently used OpenSSL commands
A collection of OpenSSL command and scripts that I often use. Worth pointing out
that most of these are based on ingenious examples found across the forums and
blog posts. I am just arranging them here in a order that works for me.

## Examining Certificates/ Keys

### Common Extensions
* .crt = most commonly used for Certificate
* .key = usually private (but some times) key of PKCS8 encoding. Mostly encrypted

### View details of a server certificate
All details
```
openssl x509 -in certificate.crt -noout -text | less
```

view specific details (E.g. subject/ issuer/ start-dates)
```
openssl x509 -in certificate.crt -noout -subject -issuer -dates
```

View details a DER encoded certificate (Default: PEM)
```
openssl x509 -in certificate.crt -inform der -noout -subject -issuer -dates
```
### View details of a KEY (PKCS8)

When the key is unencrypted
```
openssl rsa -in myunecrypted.key -noout -text
openssl rsa -in myunecrypted.key -noout -modulus
```

When the key is encrypted with the password 'password123'
```
openssl rsa -in myunecrypted.key -noout -text -passin pass:password123
openssl rsa -in myunecrypted.key -noout -modulus -passin pass:password123
```
### verify that a private key (.KEY) matches with a cert (.CRT)
```
openssl rsa -noout -modulus -in server.key | openssl md5
openssl x509 -noout -modulus -in server.crt | openssl md5
```


## Manipulating Certificates

### Certificate/ CA bundles - split into individual certs
produces certificate-chain.{0..}.pem
```
awk 'BEGIN {c=0;} /BEGIN CERT/{c++} { print > "certificate-chain." c ".pem"}' < certificate-chain.crt
```

alternatively, the following will produce bar{nn} files
```
csplit -k -f bar -z test-server-psn-ca.crt '/END CERTIFICATE/+1' {*}
```

### Generate unencrypted version of a PKCS8 encrypted private key
generates file named "unencrypted.key"

```
openssl x509 -in encrypted.pem -out unencrypted.key -passin pass:password123
```

## Permanently useful references
* [HOWTO: DER vs. CRT vs. CER vs. PEM Certificates and How To Convert Them](http://info.ssl.com/article.aspx?id=12149)
