#!/bin/bash
# Check if Python installed has a correct version for Plone



# Install dependencies
echo "I will need your superuser password for installing dependencies"
echo "Do you want me to install the dependencies for you? (yes/no):"
read option_selected
if [[ $option_selected == "Yes" ] || [ $option_selected == "yes" ] || [ $option_selected == "y" ] || [ $option_selected == "Y" ]]
    then
        echo "You will be prompted for your password if you are not running this installation script with a superuser already."
        sudo apt install python3-venv -y
        sudo apt install python3-pip -y
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

#echo "Installing needed packages"
#sudo apt install python3-venv -y

echo "Installing Plone"
echo $(ls)
./install.sh standalone --target="/home/neisor/PloneNewTest" --with-python=/usr/bin/python3 --password="admin"

echo "Starting Plone"
/home/neisor/PloneNewTest/zinstance/bin/plonectl start

echo "Done!"
