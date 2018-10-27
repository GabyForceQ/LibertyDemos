module main;

import liberty.engine;

import player : Player;

mixin(EngineRun);

/**
 * Application main.
 * Create a new scene, then spawn a Player,
 * then register the scene to the engine.
**/
void libertyMain() {
  new Scene("Scene")
    .getTree()
    .spawn!Terrain("DemoTerrain")
    .build(40.0f, 0.0f, [
      new Material("res/textures/default.bmp"),
      new Material("res/textures/blendMap.bmp"),
      new Material("res/textures/default.bmp"),
      new Material("res/textures/default.bmp"),
      new Material("res/textures/default.bmp")
    ])
    .getScene()
    .getTree()
    .spawn!PointLight("DemoPointLight")
    .getScene()
    .getTree()
    .spawn!PointLight("DemoPointLight2")
    .setColor(Vector3F(1.0f, 1.0f, 1.0f))
    .getScene()
    .getTree()
    .spawn!Player("Player", false)
    .getScene()
    .register();

  CoreEngine.enableVSync();
  //Platform.getWindow().setFullscreen(true);
}