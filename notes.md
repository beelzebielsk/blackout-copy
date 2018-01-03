- Looks like Graphics.initBlend() and Graphics.termBlend() create
  something like a "drawing context". You have to start drawing stuff
  with initBlend() and end the drawing stuff (maybe you flush the
  changes to the screen)? with Graphics.termBlend().
  - Q: Is there a way to do contexts in Lua? Is that too much to think
    about right now? Probably.
- LPP uses Lua 5.2.4.
