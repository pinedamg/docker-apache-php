#!/bin/bash
if grep -q '#sendmailhostadded' /etc/hosts; then
   exit
fi
#!/bin/bash
sed -e "1s/^.*$/127.0.0.1 localhost localhost.localdomain $HOSTNAME/g" /etc/hosts > hosts
# with sed -i, it actually performs a rename of /etc/hosts, but docker does not
# allow that, so we have to use a temp file and copy it to overwrite /etc/hosts
cp hosts /etc/hosts
rm hosts
cat /etc/hosts
echo "#sendmailhostadded" >> /etc/hosts
service sendmail reload