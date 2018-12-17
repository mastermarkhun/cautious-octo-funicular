# https://gist.github.com/srilankanchurro/fa3fdeb5cf10ebb251aa88338b8b37db

openssl pkcs12 -export -out ~/certificate.pfx \
    -inkey privkey.pem \
    -in cert.pem \
    -certfile chain.pem

mv ~/certificate.pfx /mnt/appdata/PlexMediaServer/data