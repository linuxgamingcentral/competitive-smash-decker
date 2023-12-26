# Competitive Smash Decker
The goal of this project is to be the ultimate Swiss army knife for all things *Smash* on Steam Deck/Linux. Easily download and install Smash 64 Remix, Slippi, Project+, Project M EX Remix, and HewDraw Remix. You can also overclock your GameCube controller adapter, provided that you have a sudo password.

That being said, there will still need to be a little bit of legwork needed on your part -- at least during the initial couple of steps -- which is detailed below.

## What Currently Works
- [Smash 64 Remix](https://github.com/JSsixtyfour/smashremix)
  - download the latest patch and apply it to the ROM
  - view changelog
  - run Mupen64 GUI
  - can't launch the ROM directly through the launcher; you'll just need to add it via Steam ROM Manager
- [Slippi](https://github.com/project-slippi/slippi-launcher)
  - download/update/play Slippi Launcher
  - configure Dolphin settings without launcher
  - manual downloading and patching of Animelee and Diet Melee
- [Project+](https://projectplusgame.com/)
  - download and extract the latest patch
  - configure Project+
  - automatic configuration of SD card path, default ISO, and launcher directory
  - offline and netplay support
- [Project M EX Remix](https://linuxgamingcentral.com/posts/how-to-setup-project-m-ex-on-deck/)
  - currently requires you to manually download the mod and manually setting your paths (textures are automatically copied though)
  - configure Project+
  - offline and netplay support
  - can optionally view my [guide](https://linuxgamingcentral.com/posts/how-to-setup-project-m-ex-on-deck/) if the need arises
- [Smash Ultimate HDR](https://github.com/HDR-Development/HDR-Releases)
  - download and install the latest HDR patch
  - allow user to download the Ryujinx LDN build
  - configure Ryujinx settings
  - launch HDR directly with or without netplay
- overclocking the GCC adapter
  - if the overclock module already exists you have the option to uninstall

## How to Use
This repository does NOT contain any copyrighted assets. You must provide your own legally-dumped copies of your ROMs/ISOs.

### 1. Install Emulators
Please run [EmuDeck](https://www.emudeck.com/) first to get the necessary emulators installed. Emulators you'll want to install, if they're not installed already, include:
- Mupen64 (N64)
- Ryujinx (Switch)

Alternatively you can install them with:

```
flatpak install flathub com.github.Rosalie241.RMG
flatpak install flathub org.ryujinx.Ryujinx
```

Slippi and Project+/PMEX Remix already come with their own AppImage.

After that run both the Mupen64 and Ryujinx emulators at least once to generate the configuration files.

### 2. Copy ROMs
Place your legally-dumped ROMs/ISOs in:
- Smash 64: `~/Emulation/roms/n64/smash64.z64`
- Slippi: `~/Emulation/roms/gamecube/ssbm.iso`
- Project+/PMEX Remix: `~/Emulation/roms/wii/ssbb.iso`
- HDR: `~/Emulation/roms/switch/ssbu.nsp`

### 3. Additional steps for HDR
Next, if you're planning on playing HDR, you'll also need to do the following:
- copy `prod.keys` to `~/.config/Ryujinx/system/`
- install your dumped Switch FW with Ryujinx
- dump your save data, DLC, and updates and install these with Ryujinx
- you may need to re-apply these steps if you're using the Ryujinx LDN build

### 4. Run the Script
Now you're ready to run the script. If you're on Steam Deck, download the [desktop file](https://raw.githubusercontent.com/linuxgamingcentral/competitive-smash-decker/main/competitive-smash-decker.desktop) (right-click, save link as) and save it to your desktop. Double-click or tap the file to download and run the script.

Other distros can run the script with:

`curl -L https://raw.githubusercontent.com/linuxgamingcentral/competitive-smash-decker/main/competitive-smash-decker.sh | sh`

Smash 64 Remix and HDR can be added as non-Steam shortcuts with Steam ROM Manager -- included with EmuDeck. Slippi, Project+, and PMEX Remix will need to be manually added to Steam at the moment.

## Things to be Aware of
While this script tries to make things as simple as possible for the end-user, there are some parts of the script where there will need to be manual intervention. As an example, some mods are uploaded in some sketchy places (Mediafire, Google Drive, etc.). As a result, it makes downloading these mods through the terminal a bit of a pain. Patching your Melee ISO with Animelee or Diet Melee will currently require you to manually download the mod and apply the patch yourself. Downloading PMEX Remix will require you to open up the download link in your web browser. If I get the developers' permission I might just upload these mods to my own server to make downloading/patching mods a bit easier.

Another thing to be mindful of is, since PMEX Remix uses Project+ as the base, you'll need to keep changing your SD card path if you switch between Project+ and PMEX Remix.

## To-Do
- add the ability to seamlessly patch Melee with Animelee and other mods
- add the ability to seamlessly download and extract PMEX Remix
- allow users to add Slippi, Project+, and PMEX Remix as non-Steam shortcuts
