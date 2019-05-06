# Modify and distribute this file through version control. Any
# changes you make locally will be overwritten otherwise.

# Consider using ssh-keyscan to gather keys for this list.

# hostname:22
hostname.example.com,192.168.0.17 ssh-rsa publickeygoeshere
hostname.example.com,192.168.0.17 ecdsa-sha2-nistp256 publickeygoeshere
hostname.example.com,192.168.0.17 ssh-ed25519 publickeygoeshere
