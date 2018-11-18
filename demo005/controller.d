module controller;

import liberty.engine;

void updateMouseMode() {
  if (Input.getMouse().isButtonHold(MouseButton.RIGHT)) {
    CoreEngine.getScene().getActiveCamera().setMouseMoveLocked(false);
    Input.getMouse().setCursorType(CursorType.DISABLED);
  }
  
  if (Input.getMouse().isButtonUp(MouseButton.RIGHT)) {
    CoreEngine.getScene().getActiveCamera().setMouseMoveLocked();
    Input.getMouse().setCursorType(CursorType.NORMAL);
  }
}