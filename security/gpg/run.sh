mkdir -p tmp/u1 tmp/u2

gpg --homedir tmp/u1  --gen-key
gpg --homedir tmp/u2  --gen-key

gpg --homedir tmp/u1 --export user1 > tmp/u1.pubkey
gpg --homedir tmp/u2 --export user2 > tmp/u2.pubkey

gpg --homedir tmp/u2 --import tmp/u1.pubkey
gpg --list-keys


