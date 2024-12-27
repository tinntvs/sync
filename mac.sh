#!/bin/bash
prompt_credentials() {
    read -p "Enter the domain username: " domainuser
    read -sp "Enter the domain user password: " domainuserpassword
    echo
    read -sp "Enter the local admin username: " localadmin
    echo
    read -sp "Enter the local admin password: " localadminpassword
    echo
}
secure_token_operations()
{
    operation=$1
    sudo sysadminctl -${operation} $domainuser -password $domainuserpassword -adminUser $localadmin -adminPassword $localadminpassword >> "/tmp/${operation}.log"
    if [ $? -eq 0 ]; then
        echo "Secure token operation '${operation}' successful for $domainuser."
    else
        echo "Failed to perform secure token operation '${operation}'. Showing the logs:"
        echo "================================================================"
        cat "/tmp/${operation}.log"
        exit 1
}
prompt_credentials
secure_token_operations "secureTokenOff"
secure_token_operations "secureTokenOn"
echo "Secure token operations completed successfully. Restart your device and select 'CREATE A NEW KEYCHAIN' option."
