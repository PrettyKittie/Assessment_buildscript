#!/bin/bash

#update and upgrade.....................done
#install tools/dependencies from repo...done
#wget tools from websites
#install each website tool
#clone git repos........................done
#install each git tool

######im retarded. this is *probably* not necessary. verify during testing
##Bloodhound requires nvm.  installing nvm requires the terminal is
##closed and re-opened.  adjust the script to run in 2 stages:
###stage one installs nvm, and prompts the user to close/reopen cli.
###stage 2 completes remaining install steps.
###script should ask the user whichstage to run when the script launches
######i mixed up nvm with npm.

#####
##should probably sudo su before running this script
#####

sudo apt update
sudo apt full-upgrade -y

#install lolcat, terminator, git, and various dependencies
#git will be required for the rest of build
sudo apt install lolcat terminator git nodejs npm python3-pip

#install bloodhound
#requires nodejs and nvm
#https://github.com/BloodHoundAD/BloodHound/wiki/Building-BloodHound-from-source
#cd /opt
##this installs nvm.  it can probably be skipped
##test the script without it
##curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
git clone https://github.com/BloodHoundAD/BloodHound.git
cd /opt/BloodHound
sudo mkdir /opt/BloodHound/node_modules/electron
sudo npm install #fails.  but why??  :'(
npm run linuxbuild

#install bloodhound tools
git clone https://github.com/BloodHoundAD/BloodHound-Tools.git

#install sharphound
git clone https://github.com/BloodHoundAD/SharpHound.git

#install impacket .......done
#...impacket is included with kali, but not as functional as installing from repo
#note, some dependencies may need to be added.  test this:
#For Kerberos support you will need pyasn1 package
#For cryptographic operations you will need pycryptodomex package
#For some examples you will need pyOpenSSL (rdp_check.py) and ldap3 (ntlmrelayx.py)
#For ntlmrelayx.py you will also need ldapdomaindump, flask and ldap3
cd /opt
git clone https://github.com/SecureAuthCorp/impacket.git
cd /opt/impacket
sudo pip3 install .

install responder
cd /opt
git clone https://github.com/Spiderlabs/Responder.git

#install multi-relay
#...included as part of responder

#install egress-assess ........done
cd /opt
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git
cd /opt/Egress-Assess/setup
sudo ./setup.sh

#install powerup
#...now part of the powershell empire power tools
##powershell empire power tools is now deprecated
##powerview and powertools are not part of the powersploit repository
#cd /opt
#git clone https://github.com/PowerShellEmpire/PowerTools.git

#install powershell empire
cd /opt
git clone https://github.com/EmpireProject/Empire.git

#install powersploit
#included in kali in /usr/share/windows-resources/powersploit
##is the kali version up to date?
cd /opt
git clone https://github.com/PowerShellMafia/PowerSploit.git

#install covenant (the new coolness thats replacing empire)....done
#requires dotnet sdk
#https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-2.2.207-linux-x64-binaries
##install will have issues with the path for dotnet.  tweak this.
cd /opt
wget https://download.visualstudio.microsoft.com/download/pr/022d9abf-35f0-4fd5-8d1c-86056df76e89/477f1ebb70f314054129a9f51e9ec8ec/dotnet-sdk-2.2.207-linux-x64.tar.gz
sudo mkdir -p $HOME/dotnet
sudo tar zxf dotnet-sdk-2.2.207-linux-x64.tar.gz -C $HOME/dotnet
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet
git clone --recurse-submodules https://github.com/cobbr/Covenant.git
cd /opt/Covenant/Covenant
dotnet build
dotnet run

#install silent trinity (requires iron python)
##pipenv install fails...fix it.
cd /opt
git clone https://github.com/byt3bl33d3r/SILENTTRINITY.git
cd /opt/SILENTTRINITY
sudo pip3 install --user pipenv && pipenv install && pipenv shell
sudo python st.py

#install iron python

#install haproxy
wget......??????
