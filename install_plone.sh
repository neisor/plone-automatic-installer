#!/bin/bash
# Check if Python3 installed has a correct version for Plone
python3_version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')
echo "Your Python3 version is: $python3_version"
if [[ "$python3_version" =~ "3.6." ]] || [[ "$python3_version" =~ "3.7." ]]
    then
        echo -e "You have the correct version of Python3 installed\n"
else
    echo "Plone need Python3 version 3.6 or 3.7 -> your installed Python3 version is not supported."
    echo "Exiting..."
    exit
fi   

# Install dependencies
echo "I will need your superuser password for installing dependencies"
echo "Do you want me to install the dependencies for you? (yes/no):"
read option_selected
if [ $option_selected == "Yes" ] || [ $option_selected == "yes" ] || [ $option_selected == "y" ] || [ $option_selected == "Y" ]
    then
        echo "You will be prompted for your password if you are not running this installation script with a superuser already."
        sudo apt install python3-venv -y
        sudo apt install python3-pip -y
else echo "Not installing any dependencies - if you do not have them installed, the installation may possibly fail."
fi

echo "Preparing folders"
rm -rf /home/neisor/PloneNewTest
rm -rf plone_installation
mkdir plone_installation
cd plone_installation
echo $(pwd)

echo "Downloading Plone"
wget --no-check-certificate https://launchpad.net/plone/5.2/5.2.4/+download/Plone-5.2.4-UnifiedInstaller-1.0.tgz

echo "Extracting downloaded .tgz file"
tar -xf Plone-5.2.4-UnifiedInstaller-1.0.tgz
cd Plone-5.2.4-UnifiedInstaller-1.0

echo "Installing Plone"
echo $(ls)
./install.sh standalone --target="/home/neisor/PloneNewTest" --with-python=/usr/bin/python3 --password="admin"

echo "Starting Plone"
/home/neisor/PloneNewTest/zinstance/bin/plonectl start

echo "Done!"
