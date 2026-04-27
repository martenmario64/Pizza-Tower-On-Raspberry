#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_FOLDER="$SCRIPT_DIR"
REQUIRED_VER=6
#Install Script For Pizza Tower - Performance Test

if [ "$1" != "--in-terminal" ]; then
    lxterminal -e "bash -c '$0 --in-terminal; exec bash'"
    exit
fi

echo Installing "Pizza Tower - Performance Test..."
echo This Project Would Have Not Been Possible
echo Without The Great People At Pi-Apps!
echo Support Botspot!

DIRECTORY="$HOME/.martenapps/pizzatowermm64demo/"

if [ -d "$DIRECTORY" ]; then
	echo "Packages Installed, Moving On."
else
	if [ ! -d "$HOME/pi-apps" ]; then
		wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash
	fi
	~/pi-apps/manage install "Box86"
	~/pi-apps/manage install "More Ram"
	if [ ! -f "/usr/local/bin/wine" ]; then
		~/pi-apps/manage install "Wine (x64)"
	fi
	sudo apt install xdelta3 -y
fi

echo "Now Installing Pizza Tower Performance Test..."

mkdir ~/.martenapps
mkdir ~/.martenapps/pizzatowermm64demo/
cd ~/.martenapps/pizzatowermm64demo/
rm eggpatch.xdelta
rm PT_Eggplantv15_3.zip
wget https://archive.org/download/pt-eggplant/PT_Eggplantv15_3.zip
wget https://github.com/martenmario64/Pizza-Tower-On-Raspberry/raw/refs/heads/main/demofiles/eggpatch.xdelta
unzip PT_Eggplantv15_3.zip -d ~/.martenapps/pizzatowermm64demo/Game/
xdelta3 -n -d -s ~/.martenapps/pizzatowermm64demo/Game/data.win ~/.martenapps/pizzatowermm64demo/eggpatch.xdelta ~/.martenapps/pizzatowermm64demo/data.win
rm ~/.martenapps/pizzatowermm64demo/Game/data.win
mv ~/.martenapps/pizzatowermm64demo/data.win ~/.martenapps/pizzatowermm64demo/Game/
cd ~/.martenapps/pizzatowermm64demo/
wget https://github.com/martenmario64/Pizza-Tower-On-Raspberry/raw/refs/heads/main/demofiles/runner.sh
sudo chmod +x runner.sh
mv ~/.martenapps/pizzatowermm64demo/runner.sh ~/.martenapps/pizzatowermm64demo/Game/runner.sh
cd Game/
cp runner.sh ~/Desktop/PizzaTowerPerformance.sh
cd $SCRIPT_DIR

echo "Finished! Go To The Desktop And Find "PizzaTowerPerformance.sh"!"
echo "Press Any Button To Close."
read button
exit 0
