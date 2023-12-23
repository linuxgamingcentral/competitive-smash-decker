#!/bin/bash

clear

echo -e "Competitive Smash Decker - script by Linux Gaming Central\n"

title="Competitive Smash Decker"

# Removes unhelpful GTK warnings
zen_nospam() {
  zenity 2> >(grep -v 'Gtk' >&2) "$@"
}

# zenity functions
error() {
	e=$1
	zen_nospam --error --title="$title" --width=500 --height=100 --text "$1"
}

info() {
	i=$1
	zen_nospam --info --title "$title" --width 400 --height 75 --text "$1"
}

progress_bar() {
	t=$1
	zen_nospam --title "$title" --text "$1" --progress --pulsate --auto-close --auto-kill --width=300 --height=100

	if [ "$?" != 0 ]; then
		echo -e "\nUser canceled.\n"
	fi
}

question() {
	q=$1
	zen_nospam --question --title="$title" --width=300 height=200 --text="$1"
}

text_info() {
	title=$1
	filename=$2
	zen_nospam --text-info --width=500 --height=500 --title="$1" --filename="$2"
}

# menus
main_menu() {
	zen_nospam --width 700 --height 350 --list --radiolist --multiple --title "$title"\
	--column ""\
	--column "Option"\
	--column="Description"\
	FALSE Remix "Smash 64 Remix with additional characters"\
	FALSE Slippi "Super Smash Bros. Melee with online multiplayer"\
	FALSE Project+ "A continuation of Project M that turns SSBB into a more competitive game"\
	FALSE PMEX "Project+ with a plethora of additional characters"\
	FALSE HDR "Smash Ultimate with competitive mechanics"\
	FALSE Overclock "Overclock your GCC adapter (root password required)"\
	TRUE Exit "Exit this script"
}

smash64_remix_menu() {
	zen_nospam --width 700 --height 350 --list --radiolist --multiple --title "$title"\
	--column ""\
	--column "Option"\
	--column="Description"\
	FALSE Download "Download Smash 64 Remix patch and patch the ROM"\
	FALSE Changelog "View patch notes"\
	FALSE Play "Play Smash 64 Remix"\
	TRUE Exit "Exit this submenu"
}

slippi_menu() {
	zen_nospam --width 700 --height 350 --list --radiolist --multiple --title "$title"\
	--column ""\
	--column "Option"\
	--column="Description"\
	FALSE Launcher "Download or update the Slippi Launcher"\
	FALSE Launch_Launcher "Launch Slippi Launcher"\
	FALSE Slippi "Launch and/or configure Slippi (without launcher)"\
	FALSE Mods "Get mods"\
	TRUE Exit "Exit this submenu"
}

mods_menu() {
	zen_nospam --width 700 --height 350 --list --radiolist --multiple --title "$title"\
	--column ""\
	--column "Option"\
	--column="Description"\
	FALSE Animelee "Get Animelee (your web browser will open)"\
	FALSE Diet "Get Diet Melee (your web browser will open)"\
	FALSE Other "Get other mods (your web browser will open)"\
	TRUE Exit "Exit this submenu"
}

# functions
get_sudo_password() {
	sudo_password=$(zen_nospam --password --title="$title")
	if [[ ${?} != 0 || -z ${sudo_password} ]]; then
		echo -e "User canceled.\n"
	elif ! sudo -kSp '' [ 1 ] <<<${sudo_password} 2>/dev/null; then
		echo -e "User entered wrong password.\n"
		error "Wrong password."
	else
		echo -e "Password entered, let's proceed...\n"
	fi
}

patch_iso() {
	# this is just temporary code for now and isn't currently used in the script
	if ! [ -f $HOME/Emulation/roms/gamecube/ssbm.iso ]; then
		error "SSBM ISO not found. Please place it in $HOME/Emulation/roms/gamecube/ and name it to ssbm.iso"
	else
	(
		echo -e "Downloading patch...\n"
		wget https://download2287.mediafire.com/uzd4l18ou6hgtVelarOGjJPKZg_QxAPUVMoZiZp-QcolWub8GdRC0YqtpBP4pcCJMp-kee8IUfLKf20sdhBWMNRF75yiq8z5TXMYn20bmbmUUcetRyFPzh3RLYhPOpLXE8FdtpLCCIx-yv_oMYyVXzfodH5M6eOMxoc42Snu9bEm/2ztqob93nrug8yg/ANIMELEE+-+COMPLETE+EDITION+-+PATCH+1.0.zip
		
		echo -e "Extracting...\n"
		unzip -o ANIMELEE+-+COMPLETE+EDITION+-+PATCH+1.0.zip
		cd ANIMELEE\ -\ COMPLETE\ EDITION/
							
		echo -e "Patching...\n"
		xdelta3 -d -f -s $HOME/Emulation/roms/gamecube/ssbm.iso "ANIMELEE - COMPLETE EDITION.xdelta" $HOME/Emulation/roms/gamecube/animelee.iso

		echo -e "Removing unneccesary files...\n"
		cd $HOME/Applications
		rm ANIMELEE+-+COMPLETE+EDITION+-+PATCH+1.0.zip
		rm -rf ANIMELEE\ -\ COMPLETE\ EDITION/
		) | progress_bar "Patching, please wait..."
		info "SSBM has been patched!"
	fi
}


overclock () {
	rm -rf gcadapter-oc-kmod

	# Clone repo and change into the directory
	git clone https://github.com/hannesmann/gcadapter-oc-kmod.git
	cd gcadapter-oc-kmod

	# Make the module
	make

	# Install it
	sudo insmod gcadapter_oc.ko

	# Persist across reboots
	sudo mkdir -p "/usr/lib/modules/$(uname -r)/extra"
	sudo cp gcadapter_oc.ko "/usr/lib/modules/$(uname -r)/extra"
	sudo depmod
	echo "gcadapter_oc" | sudo tee /etc/modules-load.d/gcadapter_oc.conf
}

undo_overclock() {
	cd gcadapter-oc-kmod/
	sudo rmmod gcadapter_oc.ko
	make clean
	sudo rm /usr/lib/modules/$(uname -r)/extra/gcadapter_oc.ko
	sudo rm /etc/modules-load.d/gcadapter_oc.conf
}

# Check if GitHub is reachable
if ! curl -Is https://github.com | head -1 | grep 200 > /dev/null
then
    echo "GitHub appears to be unreachable, you may not be connected to the Internet."
    exit 1
fi

cd $HOME
mkdir -p Emulation
mkdir -p Emulation/roms
mkdir -p Emulation/roms/n64
mkdir -p Emulation/roms/gamecube
mkdir -p Emulation/roms/wii
mkdir -p Emulation/roms/switch

mkdir -p Applications
cd Applications

# Main menu
while true; do
Choice=$(main_menu)
	if [ $? -eq 1 ] || [ "$Choice" == "Exit" ]; then
		
		echo Goodbye!
		exit

	elif [ "$Choice" == "Remix" ]; then
		
		while true; do
		Choice=$(smash64_remix_menu)
			if [ $? -eq 1 ] || [ "$Choice" == "Exit" ]; then
				break
			
			elif [ "$Choice" == "Download" ]; then
				#check to see if ROM exists
				if ! [ -f $HOME/Emulation/roms/n64/smash64.z64 ]; then
					error "ROM not found. Please put it in $HOME/Emulation/roms/n64/ and name it to smash64.z64"
				else
					curl -L $(curl -s https://api.github.com/repos/JSsixtyfour/smashremix/releases/latest | grep "browser_download_url" | cut -d '"' -f 4) -o smashremix.zip
					unzip -o smashremix.zip
					chmod +x smashremix*/.ezpatch/bin/linux/ucon64 smashremix*/.ezpatch/bin/linux/xdelta3 smashremix*/.ezpatch/scripts/unix.sh
					bash smashremix*/.ezpatch/scripts/unix.sh $HOME/Emulation/roms/n64/smash64.z64
					mv smashremix*/output/smashremix*.z64 $HOME/Emulation/roms/n64/
					info "Smash 64 Remix ROM has been moved over to $HOME/Emulation/roms/n64/."
					rm smashremix.zip
				fi
			
			elif [ "$Choice" == "Changelog" ]; then
				cd smashremix*/
				
				if [ -f *\ Patch\ Notes.txt ]; then
					mv *\ Patch\ Notes.txt patch_notes.txt
				fi
				
				text_info "Smash 64 Remix Patch Notes" "patch_notes.txt"
				
				cd $HOME/Applications
			
			elif [ "$Choice" == "Play" ]; then
				# install the Mupen64 GUI flatpak if it isn't detected
				if ! [ -d $HOME/.var/app/com.github.Rosalie241.RMG ]; then
					flatpak install flathub com.github.Rosalie241.RMG -y
				fi
				
				# just run the emulator itself for now, can't figure out how to get the ROM to launch directly
				flatpak run com.github.Rosalie241.RMG
			fi
		done
	
	elif [ "$Choice" == "Slippi" ]; then
		
		while true; do
		Choice=$(slippi_menu)
		
			if [ $? -eq 1 ] || [ "$Choice" == "Exit" ]; then
				break
			
			elif [ "$Choice" == "Launcher" ]; then
				mkdir -p Slippi-Launcher
				
				DOWNLOAD_URL=$(curl -s https://api.github.com/repos/project-slippi/slippi-launcher/releases/latest \
        				| grep "browser_download_url" \
			        	| grep AppImage \
			        	| cut -d '"' -f 4)
				curl -L "$DOWNLOAD_URL" -o Slippi-Launcher/Slippi-Launcher.AppImage
				
				chmod +x Slippi-Launcher/Slippi-Launcher.AppImage
				info "Slippi Launcher downloaded/updated!"
			
			elif [ "$Choice" == "Launch_Launcher" ]; then
				if ! [ -f Slippi-Launcher/Slippi-Launcher.AppImage ]; then
					error "Slippi Launcher AppImage not found."
				else
					./Slippi-Launcher/Slippi-Launcher.AppImage
				fi
			
			elif [ "$Choice" == "Slippi" ]; then
				if ! [ -f "$HOME/.config/Slippi Launcher/netplay/Slippi_Online-x86_64.AppImage" ]; then
					error "Slippi AppImage not found."
				else
					"$HOME/.config/Slippi Launcher/netplay/./Slippi_Online-x86_64.AppImage"
				fi				
			
			elif [ "$Choice" == "Mods" ]; then
				while true; do
				Choice=$(mods_menu)
					
					if [ $? -eq 1 ] || [ "$Choice" == "Exit" ]; then
						break
					
					elif [ "$Choice" == "Animelee" ]; then
						# Mediafire files are sketchy, users will just have to go to the webpage for now
						xdg-open https://animelee.xyz
					
					elif [ "$Choice" == "Diet" ]; then
						xdg-open https://diet.melee.tv/
					
					elif [ "$Choice" == "Other" ]; then
						xdg-open https://ssbmtextures.com
					
					fi
				done
			fi
		done
	
	elif [ "$Choice" == "Overclock" ]; then
		
		if [ -f "/usr/lib/modules/$(uname -r)/extra/gcadapter_oc.ko" ]; then
			if ( question "Overclocking module already exists. Would you like to uninstall?" ); then
			yes |
				get_sudo_password
				(
				if [ $USER == "deck" ]; then
					sudo -Sp '' steamos-readonly disable <<<${sudo_password}
					undo_overclock
					sudo steamos-readonly enable
				else
					undo_overclock <<<${sudo_password}
				fi
				) | progress_bar "Uninstalling, please wait..."

				info "Uninstallation complete!"
			fi
		else
			get_sudo_password
			(
			if [ $USER == "deck" ]; then
				# Disable the filesystem until we're done
				sudo -Sp '' steamos-readonly disable <<<${sudo_password}
				
				# Get pacman keys
				sudo pacman-key --init
				sudo pacman-key --populate archlinux holo

				# Install kernel headers and dev tools
				sudo pacman -S --needed --noconfirm base-devel "$(cat /usr/lib/modules/$(uname -r)/pkgbase)-headers"
				
				overclock

				# Lock the filesystem back up
				sudo steamos-readonly enable
			else
				overclock <<<${sudo_password}
			fi
			) | progress_bar "Overclocking GCC adapter, please wait..."

			info "Installation complete!"
		fi

# end of program
	fi # end of main menu
done
