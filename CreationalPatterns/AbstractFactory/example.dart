

// Abstract Factory
import 'dart:math';

abstract class UIFactory {
  Button createButton();
  Checkbox createCheckbox();
}

// Concrete Factories
class AndroidUIFactory implements UIFactory {
  @override
  Button createButton() => AndroidButton();

  @override
  Checkbox createCheckbox() => AndroidCheckbox();
}

class IOSUIFactory implements UIFactory {
  @override
  Button createButton() => IOSButton();

  @override
  Checkbox createCheckbox() => IOSCheckbox();
}

// Abstract Products
abstract class Button {
  void render();
}

abstract class Checkbox {
  void render();
}

// Concrete Products
class AndroidButton implements Button {
  @override
  void render() => print("Android button rendered");
}

class IOSButton implements Button {
  @override
  void render() => print("iOS button rendered");
}

class AndroidCheckbox implements Checkbox {
  @override
  void render() => print("Android checkbox rendered");
}

class IOSCheckbox implements Checkbox {
  @override
  void render() => print("iOS checkbox rendered");
}


void main() {
  UIFactory factory;

  bool isAndroid = Random().nextInt(2) == 0;

  if (isAndroid) {
    factory = AndroidUIFactory();
  } else {
    factory = IOSUIFactory();
  }

  // Client code depends only on abstractions
  Button button = factory.createButton();
  Checkbox checkbox = factory.createCheckbox();

  button.render();
  checkbox.render();
}
