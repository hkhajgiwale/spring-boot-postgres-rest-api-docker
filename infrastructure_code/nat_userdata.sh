#!/bin/bash
sysctl kernel.hostname=${host_name}
sed -i "s/HOSTNAME=localhost.localdomain/HOSTNAME=${host_name}/g" /etc/sysconfig/network
echo "127.0.1.1 ${host_name}" | tee -a /etc/hosts

yum update -y

