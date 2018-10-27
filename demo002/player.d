module player;

import liberty.engine;

/**
 * Example class for player.
**/
final class Player : Actor {
  mixin(NodeBody);

  private {
    WorldObject tree;
    Material pyramidMaterial;
    Material squareMaterial;
    Camera camera;
    BSPPyramid playerBody;
    UISquare square;

    float gravity = -80.0f;
    float jumpPower = 20.0f;
    float upSpeed = 0;
    float moveSpeed = 5.0f;
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
    squareMaterial = new Material("res/textures/default2.bmp");

    getScene().getActiveCamera().getTransform().setWorldPositionY(3.0f);
    
    (playerBody = spawn!BSPPyramid("Body"))
      .build()
      .getTransform()
      .setPivotY(0.5f);

    (square = spawn!UISquare("UISquare"))
      .build(squareMaterial);

    Input.setMode(CursorType.DISABLED);
  }

  /**
   * Optional.
   * If declared, it is called every frame.
  **/
  override void update() {
    if (Input.isKeyDown(KeyCode.T))
      GfxEngine.toggleWireframe();

    if (Input.isKeyDown(KeyCode.B))
      spawnOnce!BSPCube("cube")
        .getTransform()
        .setLocalPositionY(1.0f)
        .setPivotY(0.5f);

    updateBody();
    updatePhysics();

    if (Input.isKeyDown(KeyCode.ENTER)) {
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

    if (getTransform().getWorldPosition().y < killZ)
      CoreEngine.pause();

    if (Input.isKeyDown(KeyCode.F))
      Platform.getWindow().setFullscreen(true);
  }

  private void updateBody() {
    const float deltaTime = Time.getDelta();

    if (Input.isKeyHold(KeyCode.LEFT))
      getTransform().setWorldPositionX!"+="(-moveSpeed * deltaTime);

    if (Input.isKeyHold(KeyCode.RIGHT))
      getTransform().setWorldPositionX!"+="(moveSpeed * deltaTime);
    
    if (Input.isKeyHold(KeyCode.UP))
      getTransform().setWorldPositionZ!"+="(-moveSpeed * deltaTime);

    if (Input.isKeyHold(KeyCode.DOWN))
      getTransform().setWorldPositionZ!"+="(moveSpeed * deltaTime);

    if (Input.isKeyHold(KeyCode.SPACE) && onGround)
      upSpeed = jumpPower;
  }

  private void updatePhysics() {
    const float deltaTime = Time.getDelta();
    upSpeed += gravity * deltaTime;
    getTransform().setWorldPositionY!"+="(upSpeed * deltaTime);
    const Vector3F worldPos = getTransform().getWorldPosition();

    const float terrainHeight = tree.getChild!Terrain("DemoTerrain")
      .getHeight(worldPos.x, worldPos.z);

    onGround = false;
    
    if (worldPos.y < terrainHeight) {
      onGround = true;
      upSpeed = 0;
      getTransform().setWorldPositionY(terrainHeight);
    }
  }
}