# wmgraph Microsoft Graph convenience library

This library aids with the Microsoft graph API for Office 365 business.
It uses certificates for the OAuth 2.0 client credentials flow to authenticate a daemon application registered in Azure AD.
This makes it suitable to be used in console applications.

## Configuration

as described in [A simple Python daemon console application calling Microsoft Graph with its own identity, client certificate variation](https://github.com/Azure-Samples/ms-identity-python-daemon/tree/master/2-Call-MsGraph-WithCertificate)

* Register an application in Azure AD
* Prepare a config.json and certificates for a MS Application
* Upload the server.crt to AAD

see [Client Credentials for AzureAD msal](https://github.com/AzureAD/microsoft-authentication-library-for-python/wiki/Client-Credentials)

### Create Certificates:

```
#!/bin/sh
openssl genrsa -out server.pem 2048
openssl req -new -key server.pem -out server.csr
openssl x509 -req -days 365 -in server.csr -signkey server.pem -out server.crt
openssl x509 -noout -fingerprint -sha1 -inform pem -in server.crt |sed -e 's=:==g' > server.fpr
```


### config.json:

```
{
    "authority": "https://login.microsoftonline.com/TENANT_ID",
    "client_id": "CLIENT_ID",
    "scope": [ "https://graph.microsoft.com/.default" ],
    "thumbprint": "SRERVER.CRT.FINGERPRINT",
    "private_key_file": "PATH_TO_CERTS(can be relative)/server.pem",
    "endpoint": "https://graph.microsoft.com/v1.0"
}
```

## Usage

### import

```python3
from wmgraph.api import MgraphApi
from wmgraph.api.exceptions import MgraphApiError
```

### connect

```python3
api = MgraphApi(params='./config.json')
```

### use

`userdata = api.get_user(args.user_id)`

or
```python3
for user in api.list_users():
    print(user)`
```

## Development requirements

twine
wheel
