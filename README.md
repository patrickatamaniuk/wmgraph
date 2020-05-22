# wmgraph Microsoft Graph convenience library

This library aids with the Microsoft graph API for Office 365 business

## Configuration

as described in [A simple Python daemon console application calling Microsoft Graph with its own identity, client certificate variation](https://github.com/Azure-Samples/ms-identity-python-daemon/tree/master/2-Call-MsGraph-WithCertificate)

Register an application in Azure AD

Prepare a config.json and certificates for a MS Application

config.json

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

Create Certificates:
call this script with a path to the certificates:

```
#!/bin/sh
PATH_TO_CERTS = $1
mkdir -p $PATH_TO_CERTS
cd $PATH_TO_CERTS
openssl genrsa -out server.pem 2048
openssl req -new -key server.pem -out server.csr
openssl x509 -req -days 3365 -in server.csr -signkey server.pem -out server.crt
openssl x509 -noout -fingerprint -sha1 -inform pem -in server.crt |sed -e 's=:==g' > server.fpr
```

## Usage

### import

```python3
from wmgraph.api import MgraphApi
from wmgraph.api.exceptions import MgraphApiError
```

### connect

```python3
self.args = parser.parse_args()
paramsfile = os.path.join(self.args.configdir, 'config.json')
self.api = MgraphApi(params=paramsfile, args=self.args)
```

### use

`userdata = self.api.get_user(args.user_id)`

`for user in self.api.list_users(): print(user)`

## Development requirements

twine
wheel
