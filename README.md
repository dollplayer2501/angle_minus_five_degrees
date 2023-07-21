# Conky theme, "Angle minus five degrees"


<img src="./images/EndeavourOS_Qtile_2023-07-21_20-07-01.png" width="630"><br clear="all" />
<img src="./images/EndeavourOS_Qtile_2023-07-21_20-07-09.png" width="200">
<img src="./images/EndeavourOS_Qtile_2023-07-21_20-08-16.png" width="200">
<img src="./images//EndeavourOS_Qtile_2023-07-21_20-08-22.png" width="200">


I created this unnecessarily large [Conky](https://github.com/brndnmtthws/conky) theme on the premise that "I only need to know current time".  
Because I mainly use terminal emulator and text editor with _transparent background_ in Linux desktop environment.  
So I thought, "I should use this vast space!".

- Linux distribution: [EndeavourOS](https://endeavouros.com/)
- Window manager: [Qtile](http://www.qtile.org/), [qtile-extras](https://qtile-extras.readthedocs.io/en/stable/#)
- Terminal emulator: [Alacritty](https://github.com/alacritty/alacritty)
- Text editor: [Code OSS](https://github.com/microsoft/vscode/) ~~with [GlassIt-VSC](https://marketplace.visualstudio.com/items?itemName=s-nlf-fh.glassit)~~
- Standalone compositor: [Picom](https://wiki.archlinux.org/title/Picom)

I created the theme based on the idea that "Every thing other than the time display is a decoration" likening Mobile Suit Gundam's "Legs are decorations".


## Requirements, operating conditions

1. This theme runs the following Linux commands via Lua's `conky_parse` and Conky's `execi`.  
   All these are put together in `./scripts/_conky_parse.lua`.
    - `lscpu`
    - `hostnamectl`
    - `uptime`
    - `whoami`
    - `hostname`
    - [`checkupdates`](https://man.archlinux.org/man/community/pacman-contrib/checkupdates.8.en)
    - `pacman -Q`
    - `wget -q -O - http://checkip.amazonaws.com/`  
      This is a global IP address.  
      If you don't want to display, you'll need to comment out and/or modify code.  
      See `global_ip` of `./scripts/_conky_parse.lua` and `./scripts/text_detail.lua`.
    - `wc`, `grep`
2. [`Geosans Light font`](https://aur.archlinux.org/packages/ttf-geosans-light), [`Ralewy font`](https://aur.archlinux.org/packages/ttf-raleway)
3. I am writing this code assuming **4 CPUs**.  
   If the number is other than this, it will be necessary to modify the this theme.
4. This theme's design is based on the assumption that the screen is FHD/Full High Definition, 1920x1080.


## Lanch order for this theme

Assuming everything is stored in `~/.config/conky/angle_minus_five_degrees/`.

1. `./start.sh`
2. `./angle_minus_five_degrees.conf`
3. Start `./angle_minus_five_degrees.lua` from `lua_load` in above script
4. `./scripts/*.lua` of above script, `require`


## Features not implemented

Functions that could not be implemented due to my lack of technical skills.

1. ~~Change character decoration in the middle of a sentence~~  
   Done, not implemented as a generalized parser, for this reason, it is a very unrefined implementation.   
   See. `./scripts/text_detail.lua`
2. Network Up/Down speed graph, disk read/write, a logarithmic graph implementation ?  
   I have no idea...although I have a completely unique imprementation idea...
3. Imprementing display of currency rates.  
   Planned, may not be implemented.


## Other notable matters

A few years...half a year later, for myself to review this scripts.

- Setting a virtual space that is twice the size of the displayed image.  
  See `./angle_minus_five_degrees.conf`
- Changing the center point in code is relatively easy to fix.  
  See `THEME_POSITION` of `./angle_minus_five_degrees.lua`
- The width of the lower left panel is linked to width of the string of today's date (full).
- Each module/scripts is/are using [`conky_parse('${updates}')`](https://conky.cc/variables#updates) to do some lazy processing.  
  Therefore, it takes time to start up completely.
- This theme color scheme is used [EndeavourOS colour palette](https://forum.endeavouros.com/t/colour-palette/3480).  
  See `./scripts/_color.lua`
- NIC, Network Interface Card is dynamically fetching using [`conky_parse('${iface}')`](https://conky.cc/variables#gw_iface) of `./scripts/_conky_parse.lua`.
- The file system name is written directory in `DISK_DEVICE` of `_const.lua`, in my case `/dev/sda2`
- Since I am a native language other than English. For this reason, the sentences sutch as this `README.md` and comments in the source code may be strange.



//
