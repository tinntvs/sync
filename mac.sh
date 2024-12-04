#!/bin/bash
# Prompt for domain user and passwords
read -p "Enter the domain username: " domainuser
read -sp "Enter the domain user password: " domainuserpassword
echo
read -p "Enter the local admin username: " localadmin
echo
read -sp "Enter the local admin password: " localadminpassword
echo

#Disabling Secure Token
sudo sysadminctl -secureTokenOff $domainuser -password $domainuserpassword -adminUser $localadmin -adminPassword $localadminpassword >> /tmp/disable.log
if [ $? -eq 0 ]; then
    echo "Secure token is disabled for $domainuser - enabling the Secure Token."
    #Enable Secure Token
    sudo sysadminctl -secureTokenOn $domainuser -password $domainuserpassword -adminUser $localadmin -adminPassword $localadminpassword  >> /tmp/enable.log
    if [ $? -eq 0 ]; then
        echo "Secure token is enabled for $domainuser - Let's restart your device and select  CREATE A NEW KEYCHAIN - option"
    else
        echo "Failed - Showing the logs"
        echo "================================================================"
        cat /tmp/enable.log
        exit 1
    fi
else
    echo "Failed to disable secure token."
    echo "================================================================"
    cat /tmp/disable.log
    exit 1
fi
