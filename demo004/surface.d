module surface;

import liberty.engine;

/**
 * Example class for player.
**/
final class HUD : Surface {
  mixin(NodeBody);
  mixin(ListenerBody);

  private {
    SceneNode tree;
    TileMap tileMap;
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
    (tileMap = new TileMap("TM", this)).build(6, 4);

    getScene().getActiveCamera().setMouseMoveLocked();
    startListening();
  }

  /**
   * Optional.
   * If declared, it is called every frame.
  **/
  override void update() {
    super.update();

    if (Input.isKeyDown(KeyCode.T))
      GfxEngine.toggleWireframe();

    if (Input.isKeyDown(KeyCode.F))
      Platform.getWindow().toggleFullscreen();
  }

  @Signal!Button("TMTile_1_0", ButtonEvent.MouseInside)
  private void toggleMaterials() {
    tileMap.getBlock(0, 3)
      .getRenderer()
      .getModel()
      .toggleMaterials([Material.getDefault()], [pyramidMaterial]);
  }
}