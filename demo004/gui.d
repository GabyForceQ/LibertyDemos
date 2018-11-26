module gui;

import liberty.engine;

/**
 * Example class for HUD.
**/
final class HUD : Surface {
  mixin NodeConstructor;

  private {
    TileMap tileMap;
    Material[2] materials;
    Vector2I pos = Vector2I.zero;
    InputProfiler profile1;

    CheckBox checkBox;
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
      .build(50, 50, 6, 4, 100, 100)
      .createMouseEnterEvent()
      .createMouseLeaveEvent()
      .getTile(pos)
      .getModel()
      .setMaterials([materials[0]]);

    checkBox = new CheckBox("MyCheckBox", this);

    auto btn = new CustomButton!([])("MyCBtn", this);

    btn
      .getTransform()
      .setLocation(600, 600);

    /*addAction("LC", (sender, event) {
      Logger.exception("LEFT CLICK");
    }, [tuple(btn, Event.MouseLeftClick)]);

    addAction("RC", (sender, event) {
      Logger.exception("RIGHT CLICK");
    }, [tuple(btn, Event.MouseRightClick)]);*/

    addAction("Check", (sender, event) {
      Logger.exception("Just checked!");
    }, [tuple(checkBox, Event.Check)]);

    addAction("UnCheck", (sender, event) {
      Logger.exception("Just unchecked!");
    }, [tuple(checkBox, Event.Uncheck)]);
    
    addAction("Change", (sender, event) {
      Logger.exception("State changed!");
    }, [tuple(checkBox, Event.StateChange)]);

    addAction("IsCheck", (sender, event) {
      //Logger.exception("vvvvvvvvvvvvvvvvvvvvvvvvvv");
    }, [tuple(checkBox, Event.Checked)]);

    addAction("IsUnCheck", (sender, event) {
      //Logger.exception("xxxxxxxxxxxxxxxxxxxxxxxxxx");
    }, [tuple(checkBox, Event.Unchecked)]);

    addAction("ChangeMaterial", (sender, event) {
      tileMap.getTile(sender.getIndex())
        .getModel()
        .setMaterials([materials[0]]);
    }, tileMap.getMouseEnterEvent());

    addAction("RestoreMaterial", (sender, event) {
      tileMap.getTile(sender.getIndex())
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
        .getModel()
        .setMaterials([materials[0]]);

      tileMap.getTile(oldPos)
        .getModel()
        .setMaterials([materials[1]]);
    }
  }
}