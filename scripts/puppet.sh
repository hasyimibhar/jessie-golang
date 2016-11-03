#!/bin/bash

mkdir /tmp/puppet
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb -P /tmp/puppet
dpkg -i /tmp/puppet/puppetlabs-release-pc1-jessie.deb
rm -rf /tmp/puppet

apt-get update
apt-get -y install puppet-agent
