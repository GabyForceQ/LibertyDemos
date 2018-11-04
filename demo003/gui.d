module gui;

import liberty.engine;

/**
 * Example class for player.
**/
final class HUD : Frame {
  mixin(NodeBody);
  mixin(ListenerBody);

  private {
    SceneNode tree;
    Button button;
    Material pyramidMaterial;
    Material buttonMaterial;
  }

  /**
   * Optional.
   * If declared, it is called after all objects instantiation.
  **/
  override void start() {
    tree = getScene().getTree();
    pyramidMaterial = new Material("res/textures/mud.bmp");
    buttonMaterial = new Material("res/textures/default2.bmp");
    button = new Button("Button1", this);

    getScene().getActiveCamera().lockMouseMove();
    startListening();
  }

  @Signal!Button("Button1", ButtonEvent.MouseInside)
  private void toggleMaterials() {
    button
      .getRenderer()
      .getModel()
      .toggleMaterials([Material.getDefault()], [pyramidMaterial]);
  }

  @Signal!Button("Button1", ButtonEvent.MouseLeftClick)
  @Signal!Button("Button1", ButtonEvent.MouseMiddleClick)
  private void spawnCube() {
    spawnOnce!BSPCube("cube")
      .getTransform()
      .setLocalPositionY(1.0f)
      .setPivotY(0.5f);
  }

  /**
   * Optional.
   * If declared, it is called every frame.
  **/
  override void update() {
    super.update();

    if (Input.isKeyDown(KeyCode.T))
      GfxEngine.toggleWireframe();

    if (Input.isKeyDown(KeyCode.NUM_5))
      button.getTransform.setPosition(10, 10);

    if (Input.isKeyHold(KeyCode.NUM_1))
      button.getTransform.setExtent!"+="(10, 10);

    if (Input.isKeyHold(KeyCode.NUM_2))
      button.getTransform.setExtent!"-="(10, 10);

    if (Input.isKeyHold(KeyCode.LEFT))
      button.getTransform.setPosition!"+="(Vector2I.left);
    if (Input.isKeyHold(KeyCode.RIGHT))
      button.getTransform.setPosition!"+="(Vector2I.right);
    if (Input.isKeyHold(KeyCode.UP))
      button.getTransform.setPosition!"+="(Vector2I.up);
    if (Input.isKeyHold(KeyCode.DOWN))
      button.getTransform.setPosition!"+="(Vector2I.down);

    if (Input.isKeyDown(KeyCode.F))
      Platform.getWindow().toggleFullscreen();
  }
}