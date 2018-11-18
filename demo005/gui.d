module gui;

import liberty.engine;
import controller;

/**
 * Example class for player.
**/
final class HUD : Surface {
  mixin(NodeBody);

  private {
    Button[10][10] button;
    Tuple!(Button, Event)[] leftClickEvents;
    Tuple!(Button, Event)[] mouseOverEvents;
    Material greyMaterial;
    Material redMaterial;
  }

  /**
   * Optional.
   * If declared, it is called after all objects instantiation.
  **/
  override void start() {
    greyMaterial = new Material("res/textures/grey.bmp");
    redMaterial = new Material("res/textures/red.bmp");

    foreach (i; 0..10)
      foreach (j; 0..10) {
        (button[i][j] = new Button("Button[" ~ i.to!string ~ "][" ~ j.to!string ~ "]", this))
          .setIndex(i, j)
          .getTransform()
          .setPosition(100 + i * 50, 100 + j * 50)
          .setExtent(50, 50);
        button[i][j].getRenderer().getModel().setMaterials([greyMaterial]);
        leftClickEvents ~= tuple(button[i][j], Event.MouseLeftClick);
        mouseOverEvents ~= tuple(button[i][j], Event.MouseOver);
      }

    // Action for mouse over
    addAction("ColorToRed", (sender, event) {
      foreach (btn; button)
        foreach (b; btn)
          b.getRenderer().getModel().setMaterials([greyMaterial]);

      const x = sender.getIndex().x;
      const y = sender.getIndex().y;

      if (x != 0 && y != 0)
        button[x - 1][y - 1].getRenderer().getModel().setMaterials([redMaterial]);
      
      if (x != 0)
        button[x - 1][y].getRenderer().getModel().setMaterials([redMaterial]);
      
      if (x != 0 && y != 9)
        button[x - 1][y + 1].getRenderer().getModel().setMaterials([redMaterial]);

      if (x != 9 && y != 0)
        button[x + 1][y - 1].getRenderer().getModel().setMaterials([redMaterial]);
      
      if (x != 9)
        button[x + 1][y].getRenderer().getModel().setMaterials([redMaterial]);
      
      if (x != 9 && y != 9)
        button[x + 1][y + 1].getRenderer().getModel().setMaterials([redMaterial]);

      if (y != 0)
        button[x][y - 1].getRenderer().getModel().setMaterials([redMaterial]);
      
      if (y != 9)
        button[x][y + 1].getRenderer().getModel().setMaterials([redMaterial]);
      
    }, mouseOverEvents);
  }

  /**
   * Optional.
   * If declared, it is called every frame.
  **/
  override void update() {
    super.update();

    updateMouseMode();

    if (Input.getJoystick().isButtonDown(JoystickButton.A))
      simulateAction("ColorToRed", button[1][1], Event.Update);
  }
}