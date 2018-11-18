module profiles;

import liberty.engine;

/**
 *
**/
void createInputProfile1() {
  Input
    .createProfile("Profile1")
    .bindAction("MoveRight",
      InputAction!Keyboard(KeyboardButton.RIGHT, KeyboardAction.DOWN),
      InputAction!Keyboard(KeyboardButton.D, KeyboardAction.DOWN),
      InputAction!Joystick(JoystickButton.PAD_RIGHT, JoystickAction.DOWN))
    .bindAction("MoveLeft",
      InputAction!Keyboard(KeyboardButton.LEFT, KeyboardAction.DOWN),
      InputAction!Keyboard(KeyboardButton.A, KeyboardAction.DOWN),
      InputAction!Joystick(JoystickButton.PAD_LEFT, JoystickAction.DOWN))
    .bindAction("MoveDown",
      InputAction!Keyboard(KeyboardButton.DOWN, KeyboardAction.DOWN),
      InputAction!Keyboard(KeyboardButton.S, KeyboardAction.DOWN),
      InputAction!Joystick(JoystickButton.PAD_DOWN, JoystickAction.DOWN))
    .bindAction("MoveUp",
      InputAction!Keyboard(KeyboardButton.UP, KeyboardAction.DOWN),
      InputAction!Keyboard(KeyboardButton.W, KeyboardAction.DOWN),
      InputAction!Joystick(JoystickButton.PAD_UP, JoystickAction.DOWN),
      InputAction!Mouse(MouseButton.LEFT, MouseAction.DOWN))
    .setWarningsEnabled(false);
}