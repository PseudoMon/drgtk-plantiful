# Plantiful
This game is built with [DragonRuby GTK](https://dragonruby.itch.io/dragonruby-gtk) Standard version 3.24. It's just a silly thing I built for fun in two days. The game is playable [here](http://plantiful-pseudomon-idk.surge.sh/)! But it's not playable on mobile afaik.

Btw this is the ffmpeg spell to resize/convert images. I don't know where to put it so I'm just gonna put it here.
```
ffmpeg -i "count machine.png" -vf scale=143:90 "countmachine.png" -quality 90
```

## This repo
This repo contains the full source code of the game and all the assets I use. If you have DragonRuby, you can put this in the `mygame` folder and run it. Feel free to look around, but please don't straight-up take the code without telling me first.

## Credits
Art for the game is by my wonderful sister. You can find her on the bird site as [@miasmig](https://twitter.com/miasmig). Btw you can find me on bird site too as [@PseudoMonious](https://twitter.com/PseudoMonious). Font is [Mansalva](https://fonts.google.com/specimen/Mansalva).  

## Additional Features
I'm not actively developing this game; it's just a weekend project. If I am though, here are some things I'd like to do:

- Better timing for growth/wilting of the plant
- Add randomized variation for each plant's growth/wilting time
- A chill mode where the game can be left in the background and the plants will grow in minutes/hours. The current mode is more "arcade".
- Add more plant type maybe? 
- Controller support? lol