module gui;

import liberty.engine;

/**
 * Example class for HUD.
**/
final class HUD : Surface {
  mixin SceneNodeBody;

  private {
    TileMap tileMap;
    Material[2] materials;
    Vector2I pos = Vector2I.zero;
    InputProfiler profile1;
  }

  /**
   * Optional.
   * If declared, it is called after all objects instantiation.
  **/
  override void start() {
    materials = [
      new Material("res/textures/default.bmp"),
      new Material("res/textures/default2.bmp")
    ];

    (tileMap = new TileMap("MyTileMap", this))
      .build(50, 50, 6, 4)
      .createMouseEnterEvent()
      .createMouseLeaveEvent()
      .getTile(pos)
      .getRenderer()
      .getModel()
      .setMaterials([materials[0]]);

    addAction("ChangeMaterial", (sender, event) {
      tileMap.getTile(sender.getIndex())
        .getRenderer()
        .getModel()
        .setMaterials([materials[0]]);
    }, tileMap.getMouseEnterEvent());

    addAction("RestoreMaterial", (sender, event) {
      tileMap.getTile(sender.getIndex())
        .getRenderer()
        .getModel()
        .setMaterials([materials[1]]);
    }, tileMap.getMouseLeaveEvent());

    profile1 = Input.getProfile("Profile1");
  }

  override void update() {
    super.update();

    const oldPos = pos;

    if (profile1.isActionUnfolding("MoveRight")) {
      if (pos.x < tileMap.getDimension().x - 1)
        pos.x++;
    } else if (profile1.isActionUnfolding("MoveLeft")) {
      if (pos.x > 0)
        pos.x--;
    }

    if (profile1.isActionUnfolding("MoveDown")) {
      if (pos.y < tileMap.getDimension().y - 1)
        pos.y++;
    } else if (profile1.isActionUnfolding("MoveUp")) {
      if (pos.y > 0)
        pos.y--;
    }

    if (pos != oldPos) {
      tileMap.getTile(pos)
        .getRenderer()
        .getModel()
        .setMaterials([materials[0]]);

      tileMap.getTile(oldPos)
        .getRenderer()
        .getModel()
        .setMaterials([materials[1]]);
    }
  }
}