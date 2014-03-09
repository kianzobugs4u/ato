# WELCOME TO SQUID BUGS4U
######################
http_port 80
via off
# ACCESS CONTROLS
######################
#Recommended minimum configuration:
acl manager proto cache_object
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
# local networks.
acl localnet src 10.0.0.0/8 # RFC1918 possible internal network
acl localnet src 172.16.0.0/12 # RFC1918 possible internal network
acl localnet src 192.168.0.0/16 # RFC1918 possible internal network
acl SSL_ports port 21 22 25 53 109 143 443 554 563 993 21976
acl Safe_ports port 53 80 136 137 182
acl Safe_ports port 22 25 70 210 280
acl Safe_ports port 143 443 554 563 993
acl Safe_ports port 1025-65535
acl Safe_ports port 8000-8090
acl Safe_ports port 67-68
acl Safe_ports port 123 465 488 587 591 777 6667
acl Safe_ports port 9000-9091
acl Safe_ports port 110 119 995 2030 2401 3306 3690 6881 8443 8843
acl CONNECT method CONNECT
acl Only_hosts dstdomain
acl Only_ports port 443 22 143 110 69 666
http_access allow Only_hosts Only_ports
#
#Recommended minimum configuration:
######################
## Only allow cachemgr access from localhost
http_access allow manager localhost
http_access deny manager
##
http_access allow localhost
http_access allow localnet
http_access deny to_localhost
http_access allow CONNECT !SSL_ports
http_access allow CONNECT !SSL_ports
http_access allow
## protocols allowed
acl Safe_proto proto HTTP SSL
http_access deny !Safe_proto
##
## disable multicast icp
miss_access allow all
ident_lookup_access deny all
# Leave coredumps in the first cache dir
access_log /var/log/squid/access.log
cache_log /var/log/squid/cache.log
cache_access_log none
cache_store_log none
#
hierarchy_stoplist cgi-bin ?
acl apache rep_header Server ^Apache
ipcache_size 8192
ipcache_low 90
ipcache_high 95
#cache_dir null /tmp
cache_mem 16 MB
cache_dir ufs /var/spool/squid/cache0 1000 16 256
cache_dir ufs /var/spool/squid/cache1 1000 16 256
cache_dir ufs /var/spool/squid/cache2 1000 16 256
cache_dir ufs /var/spool/squid/cache3 1000 16 256
deny_info ::0 all
# Add any of your own refresh_pattern entries above these.
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
visible_hostname bugs4u
