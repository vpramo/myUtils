#!/bin/bash
#Add keys from google docs and common.yaml from Puppet-rjil and compare with current keys

#Add keys from common.yaml
curl -s "https://raw.githubusercontent.com/JioCloud/puppet-rjil/master/hiera/data/secrets/common.yaml" | grep -o ssh-rsa.*, | tr -d [\",\',\,] > ssh-keys

#Add keys from Google docs
curl -s "https://docs.google.com/spreadsheets/d/17d_4wls-7Tq_uo9VMiRY_0lF3MeAsaxrWcOMx2jCz70/export?gid=0&format=csv" | grep -o ssh-rsa >> ssh-keys

#get keys from Jump Host
scp ubuntu@49.40.64.85:/home/ubuntu/.ssh/authorized_keys ./

#sort compare and get unique keys

sort -u authorized_keys ssh-keys | uniq -u > ssh_keys_deploy


#push keys to Jump Host

scp ssh_keys_deploy ubuntu@49.40.64.85:/home/ubuntu/.ssh/authorized_keys

#remove temp files
rm ssh-keys
rm authorized_keys
rm ssh_keys_deploy

