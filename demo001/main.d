module main;

import liberty.engine;

import player : Player;

mixin EngineRun!(() {
  Scene
    .create("res/demo001.lyasset")
    .getTree()
    .spawn!(Player, false)("Player", (self) {
      self
        .getScene()
        .initialize();
    });

  CoreEngine.enableVSync();
}, () {});