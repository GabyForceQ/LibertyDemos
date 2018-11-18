module gui;

import liberty.engine;

/**
 * Example class for player.
**/
final class HUD : Surface {
  mixin SceneNodeBody;
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
      .getRenderer()
      .getModel()
      .toggleMaterials([Material.getDefault()], [pyramidMaterial]);
  }

  @Signal!Button("Button1", Event.MouseLeftClick)
  @Signal!Button("Button1", Event.MouseMiddleClick)
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

    if (Input.getKeyboard().isButtonDown(KeyboardButton.T))
      GfxEngine.toggleWireframe();

    if (Input.getKeyboard().isButtonDown(KeyboardButton.NUM_5))
      button.getTransform.setPosition(10, 10);

    if (Input.getKeyboard().isButtonHold(KeyboardButton.NUM_1))
      button.getTransform.setExtent!"+="(10, 10);

    if (Input.getKeyboard().isButtonHold(KeyboardButton.NUM_2))
      button.getTransform.setExtent!"-="(10, 10);

    if (Input.getKeyboard().isButtonHold(KeyboardButton.LEFT))
      button.getTransform.setPosition!"+="(Vector2I.left);
    if (Input.getKeyboard().isButtonHold(KeyboardButton.RIGHT))
      button.getTransform.setPosition!"+="(Vector2I.right);
    if (Input.getKeyboard().isButtonHold(KeyboardButton.UP))
      button.getTransform.setPosition!"+="(Vector2I.up);
    if (Input.getKeyboard().isButtonHold(KeyboardButton.DOWN))
      button.getTransform.setPosition!"+="(Vector2I.down);

    if (Input.getKeyboard().isButtonDown(KeyboardButton.F))
      Platform.getWindow().toggleFullscreen();
  }
}