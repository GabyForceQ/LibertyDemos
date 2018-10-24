module player;

import liberty.engine;

/**
 * Example class for player.
**/
final class Player : Actor {
  mixin(NodeBody);

  private {
    BSPCube playerBody;
    float gravity = -80.0f;
    float jumpPower = 20.0f;
    float upSpeed = 0;

    UISquare square;
    Material pyramidMaterial;
    Material squareMaterial;
  }

  /**
   * Optional.
   * If declared, it is called after all objects instantiation.
  **/
  override void start() {
    pyramidMaterial = new Material("res/textures/mud.bmp");
    squareMaterial = new Material("res/textures/default2.bmp");

    (square = spawn!UISquare("UISquare"))
      .build(squareMaterial);
    
    (playerBody = spawn!BSPCube("Body"))
      .build()
      .getTransform()
      .setPosition(0.0f, 5.0f, 0.0f);

    getScene().getActiveCamera().setMovementSpeed(10.0f).lockMouseMove();
  }

  /**
   * Optional.
   * If declared, it is called every frame.
  **/
  override void update() {
    updateMouseMode();
    updateBody();

    if (Input.isKeyDown(KeyCode.T))
      GfxEngine.toggleWireframe();

    if (Input.isKeyDown(KeyCode.ENTER))
      playerBody.getRenderer().getModel().toggleMaterials([Material.getDefault()], [pyramidMaterial]);

    Vector3F terrainPoint = Input.getMousePicker().getCurrentTerrainPoint();

    if (Input.isMouseButtonDown(MouseButton.LEFT) && !terrainPoint.x.isNaN() && !terrainPoint.y.isNaN() && !terrainPoint.z.isNaN())
      playerBody.getTransform().setPosition(terrainPoint);

    if (Input.isKeyHold(KeyCode.Z))
      getScene().getActiveCamera().setPitch!"-="(1.0f);
    if (Input.isKeyHold(KeyCode.X))
      getScene().getActiveCamera().setPitch!"+="(1.0f);
    if (Input.isKeyHold(KeyCode.N))
      getScene().getActiveCamera().setYaw!"+="(1.0f);
    if (Input.isKeyHold(KeyCode.M))
      getScene().getActiveCamera().setYaw!"-="(1.0f);

    if (Input.isKeyHold(KeyCode.R))
      (spawnOnce!BSPPyramid("Pyramid"))
        .getTransform()
        .setPositionX!"+="(2.0f * Time.getDelta());

    // not working
    if (Input.isKeyDown(KeyCode.O)) {
      getScene()
        .getTree()
        .getChild!Terrain("DemoTerrain")
          .getRenderer()
          .getModel()
          .getMaterials()
          .map!(e => e.getTexture().setLODBias!"+="(0.1f));
      
      playerBody
        .getRenderer()
        .getModel()
        .getMaterials()
        .map!(e => e.getTexture().setLODBias!"+="(0.1f));
    }
  }

  private void updateBody() {
    const float deltaTime = Time.getDelta();
    const float cameraSpeed = getScene().getActiveCamera().getMovementSpeed();

    if (Input.isKeyHold(KeyCode.LEFT))
      playerBody.getTransform().setPosition!"+="(-cameraSpeed * deltaTime, 0.0f, 0.0f);

    if (Input.isKeyHold(KeyCode.RIGHT))
      playerBody.getTransform().setPosition!"+="(cameraSpeed * deltaTime, 0.0f, 0.0f);
    
    if (Input.isKeyHold(KeyCode.UP))
      playerBody.getTransform().setPosition!"+="(0.0f, 0.0f, -cameraSpeed * deltaTime);

    if (Input.isKeyHold(KeyCode.DOWN))
      playerBody.getTransform().setPosition!"+="(0.0f, 0.0f, cameraSpeed * deltaTime);

    if (Input.isKeyDown(KeyCode.SPACE))
      jump();

    upSpeed += gravity * deltaTime;
    playerBody.getTransform().setPosition!"+="(0.0f, upSpeed * deltaTime, 0.0f);
    
    const float terrainHeight = getScene().getTree().getChild!Terrain("DemoTerrain")
      .getHeight(playerBody.getTransform().getWorldPosition().x, playerBody.getTransform().getWorldPosition().z) + 0.5f;
    
    if (playerBody.getTransform().getWorldPosition().y < terrainHeight) {
      upSpeed = 0;
      playerBody.getTransform().setPositionY(terrainHeight);
    }
  }

  private void updateMouseMode() {
    if (Input.isMouseButtonHold(MouseButton.RIGHT)) {
      getScene().getActiveCamera().unlockMouseMove();
      Input.setMode(CursorType.DISABLED);
    }
    
    if (Input.isMouseButtonUp(MouseButton.RIGHT)) {
      getScene().getActiveCamera().lockMouseMove();
      Input.setMode(CursorType.NORMAL);
    }
  }

  private void jump() {
    upSpeed = jumpPower;
  }
}