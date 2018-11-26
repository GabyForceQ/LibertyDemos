module main;

import liberty.engine;

import gui;

mixin EngineRun!(() {
  new Scene(new SceneSerializer("res/demo003.lyasset"))
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