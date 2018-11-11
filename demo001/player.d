module player;

import liberty.engine;

/**
 * Example class for player.
**/
final class Player : SceneNode {
  mixin(NodeBody);

  private {
    SceneNode tree;
    Camera camera;
    BSPCube[3] playerBody;

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

    (camera = spawn!Camera("MyCam"))
      .setPreset(CameraPreset.getEmpty())
      .setMouseMoveLocked()
      .registerToScene();

    foreach (i; 0..3)
      (playerBody[i] = spawn!BSPCube("Body" ~ i.to!string))
        .build()
        .getTransform()
        .setRelativeLocationY(i)
        .setPivotY(-0.5f);
    
    playerBody[1]
      .getTransform()
      .rotateYaw(45.0f);

    foreach (i; 0..50)
      tree.spawn!BSPCube("Block" ~ i.to!string)
        .build()
        .getTransform()
        .setAbsoluteLocationX(uniform!"[]"(-19, 19))
        .setAbsoluteLocationZ(uniform!"[]"(-19, 19))
        .setPivotY(-0.5f);
  }

  /**
   * Optional.
   * If declared, it is called every frame.
  **/
  override void update() {
    //Logger.exception(getScene().getId());

    if (Input.isKeyDown(KeyCode.T))
      GfxEngine.toggleWireframe();

    updateMouseMode();
    updateBody();
    updatePhysics();

    if (getTransform().getAbsoluteLocation().y < killZ)
      CoreEngine.pause();

    if (Input.isKeyDown(KeyCode.F))
      Platform.getWindow().toggleFullscreen();
  }

  private void updateMouseMode() {
    if (Input.isMouseButtonHold(MouseButton.RIGHT)) {
      camera.setMouseMoveLocked(false);
      Input.setMode(CursorType.DISABLED);
    }
    
    if (Input.isMouseButtonUp(MouseButton.RIGHT)) {
      camera.setMouseMoveLocked();
      Input.setMode(CursorType.NORMAL);
    }
  }

  private void updateBody() {
    const float deltaTime = Time.getDelta();

    if (Input.isKeyHold(KeyCode.A)) {
      getTransform().setAbsoluteLocationX!"+="(-moveSpeed * deltaTime);
      playerBody[1]
        .getTransform()
        .rotateYaw!"-="(300.0f * deltaTime);
    }

    if (Input.isKeyHold(KeyCode.D)) {
      getTransform().setAbsoluteLocationX!"+="(moveSpeed * deltaTime);
      playerBody[1]
        .getTransform()
        .rotateYaw!"+="(300.0f * deltaTime);
    }
    
    if (Input.isKeyHold(KeyCode.W))
      getTransform().setAbsoluteLocationZ!"+="(-moveSpeed * deltaTime);

    if (Input.isKeyHold(KeyCode.S))
      getTransform().setAbsoluteLocationZ!"+="(moveSpeed * deltaTime);

    if (Input.isKeyHold(KeyCode.NUM_1))
      getTransform().rotateYaw!"+="(1.0f);
    if (Input.isKeyHold(KeyCode.NUM_2))
      getTransform().rotatePitch!"+="(1.0f);
    if (Input.isKeyHold(KeyCode.NUM_3))
      getTransform().rotateRoll!"+="(1.0f);

    if (Input.isKeyHold(KeyCode.NUM_4))
      getTransform().setAbsoluteScale!"+="(1.0f * deltaTime);
    if (Input.isKeyHold(KeyCode.NUM_5))
      getTransform().setAbsoluteScale!"-="(1.0f * deltaTime);

    if (Input.isKeyHold(KeyCode.NUM_6))
      camera.setZNear!"+="(3.0f * deltaTime);
    if (Input.isKeyHold(KeyCode.NUM_7))
      camera.setZNear!"-="(3.0f * deltaTime);

    if (Input.isKeyHold(KeyCode.NUM_8))
      camera.setZFar(20.0f);

    if (Input.isKeyHold(KeyCode.NUM_9))
      camera.setFieldOfView!"+="(20.0f * deltaTime);

    if (Input.isKeyHold(KeyCode.NUM_0))
      camera.setFieldOfView!"-="(20.0f * deltaTime);

    if (Input.isKeyHold(KeyCode.SPACE) && onGround)
      upSpeed = jumpPower;
  }

  private void updatePhysics() {
    const float deltaTime = Time.getDelta();
    upSpeed += gravity * deltaTime;
    getTransform().setAbsoluteLocationY!"+="(upSpeed * deltaTime);
    const Vector3F worldPos = getTransform().getAbsoluteLocation();

    const float terrainHeight = tree.getChild!Terrain("Demo001Terrain")
      .getHeight(worldPos.x, worldPos.z);

    onGround = false;
    
    if (worldPos.y < terrainHeight) {
      onGround = true;
      upSpeed = 0;
      getTransform().setAbsoluteLocationY(terrainHeight);
    }
  }
}