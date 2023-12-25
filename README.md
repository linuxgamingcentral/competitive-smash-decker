# Competitive Smash Decker
The goal of this project is to be the ultimate Swiss army knife for all things *Smash* on Steam Deck/Linux.

By the time the project is complete I'm hoping to be able to do the following:
- seamlessly download, update, play, and configure:
  - [Smash 64 Remix](https://github.com/JSsixtyfour/smashremix)
  - [Slippi](https://github.com/project-slippi/slippi-launcher)
  - [Project+](https://projectplusgame.com/)
  - [Project M EX Remix](https://linuxgamingcentral.com/posts/how-to-setup-project-m-ex-on-deck/)
  - [Smash Ultimate HDR](https://github.com/HDR-Development/HDR-Releases)
- download and apply mods
- overclock the GCC adapter

## What Currently Works
- Smash 64 Remix
  - can't launch the ROM directly through the launcher; you'll just need to add it via Steam ROM Manager
- Slippi
  - manual patching of Animelee and Diet Melee
- Project+
  - automatic configuration of SD card path, default ISO, and launcher directory
- PMEX Remix
  - currently requires you to manually download the mod and manually setting your paths (textures are automatically copied though)
- overclocking the GCC adapter
  - if the overclock module already exists you have the option to uninstall

## To-Do
- Add support for:
  - HDR
- add the ability to seamlessly patch Melee with Animelee and other mods
- allow users to add games as non-Steam shortcuts
- netplay with Ryujinx?

## How to Use
This repository does NOT contain any copyrighted assets. You must provide your own legally-dumped copies of your ROMs/ISOs.

Please run [EmuDeck](https://www.emudeck.com/) first to get the necessary emulators installed. Emulators you'll want to install, if they're not installed already, include:
- Mupen64 (N64)
- Ryujinx (Switch)

Slippi and Project+/PMEX Remix already come with their own AppImage.

If you're on Steam Deck, download the [desktop file](https://raw.githubusercontent.com/linuxgamingcentral/competitive-smash-decker/main/competitive-smash-decker.desktop) (right-click, save link as) and save it to your desktop. Double-click or tap the file to download and run the script.

Other distros can run the script with:

`curl -L https://raw.githubusercontent.com/linuxgamingcentral/competitive-smash-decker/main/competitive-smash-decker.sh | sh`

The script will look for ROMs/ISOs in `~/Emulation/roms/`:
- Smash 64: `n64/smash64.z64`
- Slippi: `gamecube/ssbm.iso`
- Project+/PMEX Remix: `wii/ssbb.iso`
- HDR: `switch/ssbu.nsp`

If the script can't detect these ROMs, certain functions in the script won't work.

After your ROMs have been patched, they'll show up in `~/Emulation/roms/<system>/`. From here you can run Steam ROM Manager with EmuDeck to add your mods as non-Steam shortcuts, launch them directly through the script, or manually add them to Steam.

## Things to be Aware of
While this script tries to make things as simple as possible for the end-user, there are some parts of the script where there will need to be manual intervention. As an example, some mods are uploaded in some sketchy places (Mediafire, Google Drive, etc.). As a result, it makes downloading these mods through the terminal a bit of a pain. Patching your Melee ISO with Animelee or Diet Melee will currently require you to manually download the mod and apply the patch yourself. Downloading PMEX Remix will require you to open up the download link in your web browser. If I get the developers' permission I might just upload these mods to my own server to make downloading/patching mods a bit easier.

Another thing to be mindful of is, since PMEX Remix uses Project+ as the base, you'll need to keep changing your SD card path if you switch between Project+ and PMEX Remix.
