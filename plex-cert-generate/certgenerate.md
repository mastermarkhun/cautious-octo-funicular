# https://gist.github.com/srilankanchurro/fa3fdeb5cf10ebb251aa88338b8b37db

<<<<<<< HEAD
<<<<<<< HEAD
smbclient -L //192.168.X.X
=======
smbclient -L //192.168.200.225
>>>>>>> parent of fdf6a9d... Update certgenerate.md

sudo mkdir /mnt/appdata

sudo mount -t cifs -o username=serverUserName //192.168.200.225/appdata /mnt/appdata/

cd /mnt/appdata/letsencrypt/keys/letsencrypt

sudo openssl pkcs12 -export -out ~/certificate.pfx \
=======
openssl pkcs12 -export -out ~/certificate.pfx \
>>>>>>> parent of 6e4bebf... Update certgenerate.md
    -inkey privkey.pem \
    -in cert.pem \
    -certfile chain.pem

mv ~/certificate.pfx /mnt/appdata/PlexMediaServer/data