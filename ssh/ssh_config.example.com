# See `man ssh_config` for details and examples.

# How to connect to bastion...
Host bastion*.example.com remote.example.com
  ForwardAgent yes

# Proxy example.com hosts through bastion...
Host example.com *.example.com !bastion*.example.com !remote.example.com
  ProxyCommand ssh bastion.example.com nc %h %p
  ForwardAgent no

# Log in as admin on test deploy app consoles.
Host *.example.ion
  User admin
  Port 12121
  ProxyCommand ssh bastion.example.com nc %h %p
  ForwardAgent no
  UserKnownHostsFile /dev/null

# Log in as root on .lab hosts.
Host *.example.lab
  User root
