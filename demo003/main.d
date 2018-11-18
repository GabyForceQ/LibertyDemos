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
    .spawn!(HUD, false)("DemoHUD", (self) {
      self
        .getScene()
        .register()
        .getActiveCamera()
        .setMouseMoveLocked();
    });
    
  CoreEngine.enableVSync();
}