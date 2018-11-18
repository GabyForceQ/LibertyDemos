module player;

import liberty.engine;

/**
 * Example class for player.
**/
final class Player : SceneNode {
  mixin SceneNodeBody;

  private {
    SceneNode tree;
    Material pyramidMaterial;
    Camera camera;
    BSPPyramid playerBody;

    float gravity = -80.0f;
    float jumpPower = 20.0f;
    float upSpeed = 0;
    float moveSpeed = 2.0f;
    bool onGround;
    int killZ = -10;
  }

  /**
   * Optional.
   * If declared, it is called after all objects instantiation.
  **/
  override void start() {
    tree = getScene().getTree();
    pyramidMaterial = new Material("res/textures/mud.bmp");

    getScene().getActiveCamera().getTransform().setAbsoluteLocationY(3.0f);
    
    (playerBody = spawn!BSPPyramid("Body"))
      .build()
      .getTransform()
      .setPivotY(-0.5f);

    Input.getMouse().setCursorType(CursorType.DISABLED);
  }

  /**
   * Optional.
   * If declared, it is called every frame.
  **/
  override void update() {
    if (Input.getKeyboard().isButtonDown(KeyboardButton.T))
      GfxEngine.toggleWireframe();

    updateBody();
    updatePhysics();

    if (Input.getKeyboard().isButtonDown(KeyboardButton.ENTER)) {
      playerBody
        .getRenderer()
        .getModel()
        .toggleMaterials([Material.getDefault()], [pyramidMaterial]);
      if (getChild!BSPCube("cube") !is null)
        getChild!BSPCube("cube")
          .getRenderer()
          .getModel()
          .toggleMaterials([Material.getDefault()], [pyramidMaterial]);
    }

    if (getTransform().getAbsoluteLocation().y < killZ)
      CoreEngine.pause();

    if (Input.getKeyboard().isButtonDown(KeyboardButton.F))
      Platform.getWindow().toggleFullscreen();
  }

  private void updateBody() {
    const float deltaTime = Time.getDelta();

    if (Input.getKeyboard().isButtonHold(KeyboardButton.LEFT))
      getTransform().setAbsoluteLocationX!"+="(-moveSpeed * deltaTime);

    if (Input.getKeyboard().isButtonHold(KeyboardButton.RIGHT))
      getTransform().setAbsoluteLocationX!"+="(moveSpeed * deltaTime);
    
    if (Input.getKeyboard().isButtonHold(KeyboardButton.UP))
      getTransform().setAbsoluteLocationZ!"+="(-moveSpeed * deltaTime);

    if (Input.getKeyboard().isButtonHold(KeyboardButton.DOWN))
      getTransform().setAbsoluteLocationZ!"+="(moveSpeed * deltaTime);

    if (Input.getKeyboard().isButtonHold(KeyboardButton.SPACE) && onGround)
      upSpeed = jumpPower;
  }

  private void updatePhysics() {
    const float deltaTime = Time.getDelta();
    upSpeed += gravity * deltaTime;
    getTransform().setAbsoluteLocationY!"+="(upSpeed * deltaTime);
    const Vector3F worldPos = getTransform().getAbsoluteLocation();

    const float terrainHeight = tree.getChild!Terrain("DemoTerrain")
      .getHeight(worldPos.x, worldPos.z);

    onGround = false;
    
    if (worldPos.y < terrainHeight) {
      onGround = true;
      upSpeed = 0;
      getTransform().setAbsoluteLocationY(terrainHeight);
    }
  }
}