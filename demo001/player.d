module player;

import liberty.engine;

/**
 * Example class for player.
**/
final class Player : Actor {
  mixin(NodeBody);

  private {
    SceneNode tree;
    Material squareMaterial;
    Camera camera;
    BSPCube[2] playerBody;

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
    squareMaterial = new Material("res/textures/default2.bmp");

    (camera = spawn!Camera("MyCam"))
      .setPreset(CameraPreset.getEmpty())
      .lockMouseMove()
      .registerToScene();

    foreach (i; 0..2)
      (playerBody[i] = spawn!BSPCube("Body" ~ i.to!string))
        .build()
        .getTransform()
        .setLocalPositionY(i)
        .setPivotY(0.5f);

    foreach (i; 0..50)
      tree.spawn!BSPCube("Block" ~ i.to!string)
        .build()
        .getTransform()
        .setWorldPositionX(uniform!"[]"(-19, 19))
        .setWorldPositionZ(uniform!"[]"(-19, 19))
        .setPivotY(0.5f);
  }

  /**
   * Optional.
   * If declared, it is called every frame.
  **/
  override void update() {
    if (Input.isKeyDown(KeyCode.T))
      GfxEngine.toggleWireframe();

    updateMouseMode();
    updateBody();
    updatePhysics();

    if (getTransform().getWorldPosition().y < killZ)
      CoreEngine.pause();

    if (Input.isKeyDown(KeyCode.F))
      Platform.getWindow().toggleFullscreen();
  }

  private void updateMouseMode() {
    if (Input.isMouseButtonHold(MouseButton.RIGHT)) {
      camera.unlockMouseMove();
      Input.setMode(CursorType.DISABLED);
    }
    
    if (Input.isMouseButtonUp(MouseButton.RIGHT)) {
      camera.lockMouseMove();
      Input.setMode(CursorType.NORMAL);
    }
  }

  private void updateBody() {
    const float deltaTime = Time.getDelta();

    if (Input.isKeyHold(KeyCode.A))
      getTransform().setWorldPositionX!"+="(-moveSpeed * deltaTime);

    if (Input.isKeyHold(KeyCode.D))
      getTransform().setWorldPositionX!"+="(moveSpeed * deltaTime);
    
    if (Input.isKeyHold(KeyCode.W))
      getTransform().setWorldPositionZ!"+="(-moveSpeed * deltaTime);

    if (Input.isKeyHold(KeyCode.S))
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