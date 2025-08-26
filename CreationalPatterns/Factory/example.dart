// Abstract Creator
import 'dart:math';

abstract class Dialog {
  Button createButton();

  void render() {
    Button okButton = createButton();
    okButton.onClick();
    okButton.render();
  }
}

// Concrete Creators
class AndroidDialog extends Dialog {
  @override
  Button createButton() => AndroidButton();
}

class IOSDialog extends Dialog {
  @override
  Button createButton() => IOSButton();
}

// Abstract Product
abstract class Button {
  void render();
  void onClick();
}

// Concrete Products
class AndroidButton implements Button {
  @override
  void render() => print("Rendering Android button");

  @override
  void onClick() => print("Clicked Android button");
}

class IOSButton implements Button {
  @override
  void render() => print("Rendering iOS button");

  @override
  void onClick() => print("Clicked iOS button");
}


void main() {
  Dialog dialog;

  bool isAndroid = Random().nextInt(2) == 0;

  if (isAndroid) {
    dialog = AndroidDialog();
  } else {
    dialog = IOSDialog();
  }

  dialog.render();
}
