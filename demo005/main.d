module main;

import liberty.engine;

mixin(EngineRun);

/**
 * Application main.
 * Create a new scene, then spawn a Player,
 * then register the scene to the engine.
**/
void libertyMain() {
  new Scene(new SceneSerializer("res/demo001.lyasset"))
    .register();

  CoreEngine.enableVSync();
}