module main;

import liberty.engine;
import gui;
import profiles;

mixin(EngineRun);

/**
 * Application main.
 * Create a new scene, then spawn a Player,
 * then register the scene to the engine.
**/
void libertyMain() {
  createInputProfile1();
  
  new Scene(new SceneSerializer("res/demo004.lyasset"))
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