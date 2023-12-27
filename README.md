# Competitive Smash Decker
The goal of this project is to be the ultimate Swiss army knife for all things *Smash* on Steam Deck/Linux. Easily download, update, and install Smash 64 Remix, Slippi, Project+, Lylat, Project M EX Remix, and HewDraw Remix. You can also overclock your GameCube controller adapter, provided that you have a sudo password.

That being said, there will still need to be a little bit of legwork needed on your part -- at least during the initial couple of steps -- which is detailed below.

![Steam Deck](https://i.imgur.com/xELGiPb.jpg)

## What Currently Works
- [Smash 64 Remix](https://github.com/JSsixtyfour/smashremix)
  - download the latest patch and apply it to the ROM
  - view changelog
  - run Mupen64 GUI
- [Slippi](https://github.com/project-slippi/slippi-launcher)
  - download/update/play Slippi Launcher
  - configure Dolphin settings without launcher
  - download and patch latest Akaneia build
  - manual downloading and patching of Animelee and Diet Melee (for the time being)
- [Project+](https://projectplusgame.com/)
  - download and extract the latest patch
  - configure or play Project+
- [Lylat](https://lylat.gg/)
  - online multiplayer support for both Akaneia (via Slippi) and Project+ (via Brawlback)
- [Project M EX Remix](https://linuxgamingcentral.com/posts/how-to-setup-project-m-ex-on-deck/)
  - currently downloads and extracts 0.95 DX from my server
  - configure and play Project+/PMEX Remix
- [Smash Ultimate HDR](https://github.com/HDR-Development/HDR-Releases)
  - download the latest HDR patch and install them for both Ryujinx and Yuzu
  - configure Ryujinx and Yuzu settings
  - download and install 100% save file, legacy discovery (to allow ARCropolis to properly load HDR), and Wi-Fi fix (for Yuzu)
  - launch HDR directly with either Ryujinx or Yuzu
- overclocking the GCC adapter
  - if the overclock module already exists you have the option to uninstall
  
![Script main menu](https://i.imgur.com/pQ8YHov.png)

## How to Use
This repository does NOT contain any copyrighted assets. You must provide your own legally-dumped copies of your ROMs/ISOs.

### 1. Install Emulators
Please run [EmuDeck](https://www.emudeck.com/) first to get the necessary emulators installed. Emulators you'll want to install, if they're not installed already, include:
- Mupen64 (N64)
- Ryujinx (Switch)
- Yuzu (Switch)

Slippi, Lylat, and Project+/PMEX Remix already come with their own AppImage.

After that run the Mupen64, Ryujinx, and Yuzu emulators at least once to generate the configuration files.

### 2. Copy ROMs
Place your legally-dumped ROMs/ISOs in:
- Smash 64: `~/Emulation/roms/n64/smash64.z64`
- Slippi: `~/Emulation/roms/gamecube/ssbm.iso`
- Project+/PMEX Remix: `~/Emulation/roms/wii/ssbb.iso`
- HDR: `~/Emulation/roms/switch/ssbu.nsp`

If any of these ROMs aren't detected, some of the script's functions won't work.

### 3. Additional steps for HDR
If you're planning on playing HDR, you'll also need to do the following.

Ryujinx:
- copy `prod.keys` to `~/.config/Ryujinx/system/`
- dump your Switch FW and install it with Ryujinx
- dump your SSBU DLC and updates (13.0.1) and install these with Ryujinx

Yuzu:
- copy `prod.keys` to `~/.local/share/yuzu/keys/`
- dump your SSBU DLC and updates (13.0.1) and install these with Yuzu

### 4. Run the Script
Now you're ready to run the script. If you're on Steam Deck, download the [desktop file](https://raw.githubusercontent.com/linuxgamingcentral/competitive-smash-decker/main/competitive-smash-decker.desktop) (right-click, save link as) and save it to your desktop. Double-click or tap the file to download and run the script.

Other distros can run the script with:

`curl -L https://raw.githubusercontent.com/linuxgamingcentral/competitive-smash-decker/main/competitive-smash-decker.sh | sh`

## Notes

### Adding to Steam
Mods are downloaded to `~/Applications/`. Smash 64 Remix and HDR can be added as non-Steam shortcuts with Steam ROM Manager -- included with EmuDeck. Slippi, Lylat, and Project+/PMEX Remix will need to be manually added to Steam at the moment.

### Project+/PMEX Remix
You'll need to manually configure your default ISO, SD card path, and launcher directory with Project+ and PMEX Remix. Additionally, if you switch between playing Project+ and PMEX Remix, you'll need to keep changing the SD card path to switch between mods.

You *may* need to set the graphics backend to Vulkan if all you get is a white screen when launching either mod.

### Lylat
Lylat adds online multiplayer to Akaneia (Melee) and Project+. There are separate builds for each that are downloaded into `~/Applications/Lylat/` as an AppImage. You will need to create a [Lylat account](https://lylat.gg/). Once you've started Lylat, you will be asked to login. Save the `lylat.json` file to `~/.config/SlippiOnline/`.

If you're using the Lylat build for Project+, you will need to set your default ISO, SD card path, and launcher path.

### HDR
After you've downloaded the latest HDR patch with the script, you'll need to run Smash Ultimate at least once to generate the `arcropolis` folder inside of `sdmc` and `sdcard`, depending on the emulator you want to use. You'll then need to apply the fixes (save file, legacy discovery, and Wi-Fi fix) through the script in order to get HDR to work properly.

I currently recommend using Yuzu for HDR, because:
- it boots and runs faster
- it has GCC adapter support
- it has online multiplayer
- the emulator doesn't hang when you stop emulating the game

Right now the only thing Ryujinx has got going for this is stability.

### Mod Uploads
I have uploaded some mods (particularly those that are hosted on Mediafire and Google Drive) to my server. In particular:
- PMEX Remix (0.95 DX). I have stripped all of the unnecessary files from the download away and have only included the launcher .elf files, the changelog, and the sd.raw file
- HDR 100% save data, legacy discovery, and the Wi-Fi fix

This makes it easier to download these mods through the script. The downloads can now be handled automatically versus having to manually download them yourself. If any developer has a problem with this, they're more than welcome to shoot me an [email](mailto:contact@linuxgamingcentral.com) or file an issue and I will gladly take the mod down.

## To-Do
- add the ability to seamlessly patch Melee with Animelee and other mods
- allow users to add Slippi, Lylat, Project+, and PMEX Remix as non-Steam shortcuts
- moar mods
