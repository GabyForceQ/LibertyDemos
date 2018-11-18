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
  new Scene(new SceneSerializer("res/demo001.lyasset"))
    .getTree()
    .spawn!(Player, false)("Player", (self) {
      self
        .getScene()
        .register();
    });

  CoreEngine.enableVSync();
}