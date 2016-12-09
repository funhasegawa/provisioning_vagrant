#!/bin/bash

# puppetlabsは一時的に
rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
if ! [ `which ansible`]; then
  yum -y update
  yum -y install epel-release
  yum -y install ansible
fi

sed -i -e 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config
echo "UserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config""
mkdir ~/.ssh
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
mkdir /home/vagrant/.ssh
ssh-keyscan -H github.com >> /home/vagrant/.ssh/known_hosts
chown -R vagrant:vagrant /home/vagrant/.ssh
yum -y install git
git clone git@github.com:funhasegawa/ansible-lamp.git /home/vagrant/ansible-lamp
chown -R vagrant:vagrant /home/vagrant/ansible-lamp
cd /home/vagrant/ansible-lamp && \
  git config user.name { YOUR_GITHUB_NAME } && \
  git config user.email { YOUR_GITHUB_EMAIL  }
echo 'alias ll="ls -l"' >> /home/vagrant/.bashrc
echo 'alias la="ls -la"' >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc
