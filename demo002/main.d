module main;

import liberty.engine;

import player;

mixin EngineRun!(() {
  Scene
    .create("res/demo002.lyasset")
    .getTree()
    .spawn!Terrain("DemoTerrain", (self) {
      self
        .build(800.0f, 20.0f, [
          new Material("res/textures/grass.bmp"),
          new Material("res/textures/blendMap.bmp"),
          new Material("res/textures/mud.bmp"),
          new Material("res/textures/grassFlowers.bmp"),
          new Material("res/textures/path.bmp")
        ]);
    })
    .getScene()
    .getTree()
    .spawn!(Player, false)("Player", (self) {
      self
        .getScene()
        .initialize();
    });

  CoreEngine.enableVSync();
}, () {});