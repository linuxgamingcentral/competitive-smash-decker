# Competitive Smash Decker
The goal of this project is to be the ultimate Swiss army knife for all things *Smash* on Steam Deck/Linux.

By the time the project is complete I'm hoping to be able to do the following:
- seamlessly download, update, play, and configure:
  - Smash 64 Remix
  - Slippi
  - Project+
  - Project M EX Remix
  - Smash Ultimate HDR
- download and apply mods
- overclock the GCC adapter

## What Currently Works
- Smash 64 Remix
- Slippi
- overclocking the GCC adapter

## To-Do
- Add support for:
  - Project+
  - PMEX Remix
  - HDR
- add the ability to seamlessly patch Melee with Animelee and other mods
- allow users to add games as non-Steam shortcuts

## How to Use
Be aware this repository does NOT contain any copyrighted assets. You must provide your own legally-dumped copies of your ROMs/ISOs.

1. Please run [EmuDeck](https://www.emudeck.com/) first to get the necessary emulators installed. Emulators you'll want to install, if they're not installed already, include:
- Mupen64 (N64)
- Ryujinx (Switch)

Slippi, Project+, and PMEX Remix already come with their own AppImage.

2. If you're on Steam Deck, download the [desktop file]() (right-click, save link as) and save it to your desktop. Double-click or tap the file to download and run the script.

Other distros can run the script with:

```
curl -L 
```

The script will look for ROMs/ISOs in `~/Emulation/roms/`:
- Smash 64: `n64/smash64.z64`
- Melee: `gamecube/ssbm.iso`
- Project+/PMEX Remix: `wii/ssbb.iso`
- HDR: `switch/ssbu.nsp`

If the script can't detect these ROMs, certain functions in the script won't work.
