#!/bin/sh
openssl genrsa -out server.pem 2048
openssl req -new -key server.pem -out server.csr
openssl x509 -req -days 3365 -in server.csr -signkey server.pem -out server.crt

openssl x509 -noout -fingerprint -sha1 -inform pem -in server.crt |sed -e 's=:==g'