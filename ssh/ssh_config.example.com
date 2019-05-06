# Modify and distribute this file through version control. Any
# changes you make locally will be overwritten otherwise.

# See `man ssh_config` for details and examples.

# See also
# https://www.cyberciti.biz/faq/create-ssh-config-file-on-linux-unix/
# and
# http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/

# Global options
AddKeysToAgent ask
CanonicalizeHostname yes
CanonicalizeFallbackLocal no
CanonicalDomains example.com
StrictHostKeyChecking ask
VerifyHostKeyDNS ask

# ForwardAgent may be useful on proxies and some hosts.
# HostName specifies which host to actually log into.
# Also check out LocalCommand, PermitLocalCommand, ProxyCommand,
#   ProxyJump, RemoteCommand

# Per-host options. Use "Host" or "Match" to describe each host.

# Apply these options to example.com's hosts:
Host *.example.com 192.168.0.0/24
  StrictHostKeyChecking yes
  UserKnownHostsFile ~/.ssh/known_hosts.example.com
