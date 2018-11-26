module main;

import liberty.engine;
import gui;
import profiles;

mixin EngineRun!(() {
  createInputProfile1();
  
  Scene
    .create("res/demo004.lyasset")
    .getTree()
    .spawn!(HUD, false)("DemoHUD", (self) {
      self
        .getScene()
        .initialize()
        .getActiveCamera()
        .setMouseMoveLocked();
    });

  CoreEngine.enableVSync();
}, () {

});