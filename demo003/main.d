module main;

import liberty.engine;

import gui;

mixin(EngineRun);

/**
 * Application main.
 * Create a new scene, then spawn a Player,
 * then register the scene to the engine.
**/
void libertyMain() {
  new Scene("Scene")
    .getTree()
    .getScene()
    .getTree()
    .spawn!PointLight("DemoPointLight")
    .getScene()
    .getTree()
    .spawn!PointLight("DemoPointLight2")
    .setColor(Vector3F(1.0f, 1.0f, 1.0f))
    .getScene()
    .getTree()
    .spawn!HUD("DemoHUD", false)
    .getScene()
    .register();

  CoreEngine.enableVSync();
}