module main;

import liberty.engine;
import gui;

mixin EngineRun!(() {
  new Scene(new SceneSerializer("res/demo001.lyasset"))
    .getTree()
    .spawn!(HUD, false)("DemoHUD", (self) {
      self
        .getScene()
        .initialize()
        .getActiveCamera()
        .setMouseMoveLocked();
    });

  CoreEngine.enableVSync();
}, () {});