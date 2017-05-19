# Frequently used OpenSSL commands
A collection of OpenSSL command and scripts that I often use.

### split cert bundles (CA/Certificate Chain files) into individual certs
produces certificate-chain.{0..}.pem

```
awk 'BEGIN {c=0;} /BEGIN CERT/{c++} { print > "certificate-chain." c ".pem"}' < certificate-chain.crt
```

alternatively, the following will produce bar{nn} files

```
csplit -k -f bar -z test-server-psn-ca.crt '/END CERTIFICATE/+1' {*}
```

### verify that private key (.KEY) matches with the cert (.CRT)
```
openssl rsa -noout -modulus -in server.key | openssl md5
openssl x509 -noout -modulus -in server.crt | openssl md5
```

### Generate unencrypted version of a PKCS8 encrypted private key
generates file named "unencrypted.key"

```
openssl x509 -in encrypted.pem -out unencrypted.key -passin pass:password123
```
