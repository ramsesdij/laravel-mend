#!/bin/bash

#/
#--------------------------------------------------------------------------
# Install Laravel Mend
#--------------------------------------------------------------------------
#
# This script will install the necessary requirements to run laravel mend.
#
#/

mv laravel-mend-master/.mend /etc/.mend
echo "alias mend='sh /etc/.mend/mend'" >> /etc/bash.bashrc

PASS=$(openssl rand -base64 32)
useradd -G sudo -d /home/mend -p $PASS -m mend

# Make password optional
echo 'mend ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

if [ ! -d /etc/.mend/tmp ]; then
  sudo mkdir /etc/.mend/tmp
fi

# Store password
sudo echo $PASS > /etc/.mend/tmp/pass

sudo chown -R mend:mend /etc/.mend/tmp

# Add aliases to PATH
echo "alias mend='sh /etc/.mend/mend'" >> /home/mend/.bashrc
echo "export PATH=~/.composer/vendor/bin:\$PATH" >> /home/mend/.bashrc

echo "Successfully installed Laravel MEND! Happy mending https://www.mend-digital.nl/";

# Cleanup time
rm -rf laravel-mend-master
su - mend
