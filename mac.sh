#!/bin/bash
    read -p "Enter the domain username: " domainuser
    read -sp "Enter the domain user password: " domainuserpassword
    echo
    read -sp "Enter the local admin username: " localadmin
    echo
    read -sp "Enter the local admin password: " localadminpassword
    echo
    sudo sysadminctl -secureTokenOff $domainuser -password $domainuserpassword -adminUser $localadmin -adminPassword $localadminpassword
    if [ $? -eq 0 ]; then
        echo "Turned Off"
        sudo sysadminctl -secureTokenOn $domainuser -password $domainuserpassword -adminUser $localadmin -adminPassword $localadminpassword
    else
        echo "Failed"
        exit 1
