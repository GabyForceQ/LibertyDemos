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
  new Scene(new SceneSerializer("res/demo003.lyasset"))
    .getTree()
    .spawn!HUD("DemoHUD", false)
    .getScene()
    .register();

  CoreEngine.enableVSync();
}