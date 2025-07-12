#!/bin/bash

# Create SSL directory if it doesn't exist
mkdir -p nginx/ssl

# Remove old certificates if they exist
rm -f nginx/ssl/localhost.key nginx/ssl/localhost.crt nginx/ssl/localhost.csr

# Generate private key
openssl genrsa -out nginx/ssl/localhost.key 2048

# Create a config file for the certificate
cat > nginx/ssl/localhost.conf <<EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
req_extensions = v3_req

[dn]
C=US
ST=State
L=City
O=Organization
OU=OrgUnit
CN=localhost

[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
DNS.2 = *.localhost
IP.1 = 127.0.0.1
IP.2 = ::1
EOF

# Generate certificate signing request
openssl req -new -key nginx/ssl/localhost.key -out nginx/ssl/localhost.csr -config nginx/ssl/localhost.conf

# Generate self-signed certificate with proper extensions
openssl x509 -req -days 365 -in nginx/ssl/localhost.csr -signkey nginx/ssl/localhost.key -out nginx/ssl/localhost.crt -extensions v3_req -extfile nginx/ssl/localhost.conf

# Clean up temporary files
rm nginx/ssl/localhost.csr nginx/ssl/localhost.conf

# Set proper permissions
chmod 600 nginx/ssl/localhost.key
chmod 644 nginx/ssl/localhost.crt

echo "SSL certificates generated successfully!"
echo "Certificate: nginx/ssl/localhost.crt"
echo "Private Key: nginx/ssl/localhost.key"

# Verify the certificate
echo ""
echo "Certificate verification:"
openssl x509 -in nginx/ssl/localhost.crt -text -noout | grep -A 3 "Subject Alternative Name"
