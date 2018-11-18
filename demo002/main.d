module main;

import liberty.engine;

import player;

mixin(EngineRun);

/**
 * Application main.
 * Create a new scene, then spawn a Player,
 * then register the scene to the engine.
**/
void libertyMain() {
  new Scene(new SceneSerializer("res/demo002.lyasset"))
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
        .register();
    });

  CoreEngine.enableVSync();
}