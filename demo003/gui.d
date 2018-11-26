module gui;

import liberty.engine;

/**
 * Example class for player.
**/
final class HUD : Surface {
  mixin NodeConstructor;
  mixin ListenerBody;

  private {
    Button button;
    Material pyramidMaterial;
    Material buttonMaterial;
  }

  /**
   * Optional.
   * If declared, it is called after all objects instantiation.
  **/
  override void start() {
    pyramidMaterial = new Material("res/textures/mud.bmp");
    buttonMaterial = new Material("res/textures/default2.bmp");
    button = new Button("Button1", this);

    startListening();
  }

  @Signal!Button("Button1", Event.MouseOver)
  private void toggleMaterials(Widget sender, Event e) {
    button
      .getModel()
      .toggleMaterials([Material.getDefault()], [pyramidMaterial]);
  }

  @Signal!Button("Button1", Event.MouseLeftClick)
  private void spawnCube(Widget sender, Event e) {
    spawnOnce!BSPCube("cube", (self) {
      self
        .build()
        .getTransform()
        .setRelativeLocationY(1.0f)
        .setPivotY(-0.5f);
    });
  }

  /**
   * Optional.
   * If declared, it is called every frame.
  **/
  override void update() {
    super.update();
  }
}