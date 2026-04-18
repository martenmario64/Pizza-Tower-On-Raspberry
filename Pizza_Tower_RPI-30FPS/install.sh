#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_FOLDER="$SCRIPT_DIR"
REQUIRED_VER=5
#Install Script For Pizza Tower - Pi Edition

if [ "$1" != "--in-terminal" ]; then
    lxterminal -e "bash -c '$0 --in-terminal; exec bash'"
    exit
fi

echo Installing "Pizza Tower - Pi Edition (Professional)..."
echo This Project Would Have Not Been Possible
echo Without The Great People At Pi-Apps!
echo Support Botspot!

DIRECTORY="$HOME/.martenapps/pizzatower30/"

if [ -f "$HOME/.martenapps/pizzatower30/Game/runner.sh" ]; then
	INSTALLED_VER=$(grep -iPo '(?<=VERSION=)\d+' "$HOME/.martenapps/pizzatower30/Game/runner.sh")
else
	INSTALLED_VER=0
fi

if [ "$INSTALLED_VER" -lt "$REQUIRED_VER" ]; then
	echo "Deleting Files For New Install..."
	rm -r "$HOME/.martenapps/pizzatower30/"
fi

if [ -d "$DIRECTORY" ]; then
	echo "Packages Installed, Moving On."
else
	if [ ! -d "$HOME/pi-apps" ]; then
		wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash
	fi
	~/pi-apps/manage install "Box86"
	~/pi-apps/manage install "Wine (x64)"
	sudo apt install xdelta3 -y
fi

echo "NOTE: You Will Need A Vaild Copy Of Pizza Tower For This Next Step. (V1.1.28)"
echo "Now Installing 30 And 45 FPS Versions..."

rm -r ~/.martenapps/pizzatower30/
rm -r ~/.martenapps/pizzatower/
mkdir ~/.martenapps/
mkdir ~/.martenapps/pizzatower/
mkdir ~/.martenapps/pizzatower30/
xdelta3 -n -d -s $DATA_FOLDER/Game/data.win $DATA_FOLDER/files/Regular.xdelta ~/.martenapps/pizzatower30/data.win
cp -r $DATA_FOLDER/Game/ ~/.martenapps/pizzatower30/
cp $DATA_FOLDER/files/runner.sh ~/.martenapps/pizzatower30/Game/runner.sh
rm ~/.martenapps/pizzatower30/Game/data.win
mv ~/.martenapps/pizzatower30/data.win ~/.martenapps/pizzatower30/Game/
rm ~/.martenapps/pizzatower30/Game/PUT\ STEAM\ GAME\ HERE.txt
rm ~/.martenapps/pizzatower30/Game/Steamworks_x64.dll
xdelta3 -n -d -s $DATA_FOLDER/Game/data.win $DATA_FOLDER/.files/Professional.xdelta ~/.martenapps/pizzatower/data.win
cp -r $DATA_FOLDER/Game/ ~/.martenapps/pizzatower/
cp $DATA_FOLDER/.files/runner.sh ~/.martenapps/pizzatower/Game/runner.sh
rm ~/.martenapps/pizzatower/Game/data.win
mv ~/.martenapps/pizzatower/data.win ~/.martenapps/pizzatower/Game/
rm ~/.martenapps/pizzatower/Game/PUT\ STEAM\ GAME\ HERE.txt
rm ~/.martenapps/pizzatower/Game/Steamworks_x64.dll
cp $DATA_FOLDER/files/runner.sh ~/Desktop/PizzaTower.sh

echo "Finished! Go To The Desktop And Find "PizzaTower.sh"!"
echo "Press Any Button To Close."
read button
exit 0
