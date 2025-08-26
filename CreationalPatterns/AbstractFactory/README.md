# 🔹 Abstract Factory Pattern

### 1. **Definition**

The **Abstract Factory Pattern** provides an **interface** for creating families of related or dependent objects **without specifying their concrete classes**.

* It’s called "abstract" because the client (your app code) never directly instantiates concrete classes.
* Instead, it works only with **abstract interfaces**, and the specific factory decides which concrete implementation to return.

Think of it as a **“factory of factories”** 🏭.

---

### 2. **Difference from Factory Method**

| **Aspect**  | **Factory Method** (your first example) | **Abstract Factory**                                              |
| ----------- | --------------------------------------- | ----------------------------------------------------------------- |
| Focus       | Creates **one product** at a time.      | Creates **a family of related products**.                         |
| Example     | Create a `Button` for Android/iOS.      | Create a **UI Kit** (Button + Checkbox + Dialog) for Android/iOS. |
| Flexibility | Simpler, but limited.                   | More complex, but scalable.                                       |
| UML analogy | One abstract creator.                   | Multiple factories producing consistent product sets.             |

---

### 3. **When to Use Abstract Factory**

You should use Abstract Factory when:

✅ You need **cross-platform families of objects** (e.g., Material vs Cupertino widgets).
✅ You want to enforce **consistency** between products (e.g., Android button always goes with Android checkbox).
✅ You want to **switch implementations easily** (Firebase vs SQLite, Stripe vs PayPal, REST vs GraphQL).
✅ You want **clean architecture** with dependency inversion — client code depends only on **abstract contracts**.

---

### 4. **Core Components**

* **Abstract Factory** → Declares methods for creating products (e.g., `createButton()`, `createCheckbox()`).
* **Concrete Factories** → Implement methods to produce platform-specific products (e.g., `AndroidUIFactory`, `IOSUIFactory`).
* **Abstract Products** → Interfaces for product families (e.g., `Button`, `Checkbox`).
* **Concrete Products** → Platform-specific implementations (`AndroidButton`, `IOSButton`).
* **Client Code** → Uses only abstract factories and products, never touching concrete classes directly.

---

### 5. **Dart Example (UI Widgets)**

```dart
// Abstract Factory
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
```

---

### 6. **Client Code (Usage)**

```dart
void main() {
  UIFactory factory;

  if (Platform.isAndroid) {
    factory = AndroidUIFactory();
  } else if (Platform.isIOS) {
    factory = IOSUIFactory();
  } else {
    throw Exception("Unsupported platform");
  }

  // Client code depends only on abstractions
  Button button = factory.createButton();
  Checkbox checkbox = factory.createCheckbox();

  button.render();
  checkbox.render();
}
```

💡 The client doesn’t know or care about `AndroidButton` or `IOSButton`.
It only knows it’s working with a `Button` and `Checkbox`.

---

### 7. **Real-World Flutter Use Cases**

#### (a) **UI Adaptation**

Switch between **Material Design** and **Cupertino** styles in a consistent way.

```dart
abstract class WidgetFactory {
  Widget createButton(String label, VoidCallback onPressed);
  Widget createSwitch(bool value, ValueChanged<bool> onChanged);
}

class MaterialWidgetFactory implements WidgetFactory {
  @override
  Widget createButton(String label, VoidCallback onPressed) =>
      ElevatedButton(onPressed: onPressed, child: Text(label));

  @override
  Widget createSwitch(bool value, ValueChanged<bool> onChanged) =>
      Switch(value: value, onChanged: onChanged);
}

class CupertinoWidgetFactory implements WidgetFactory {
  @override
  Widget createButton(String label, VoidCallback onPressed) =>
      CupertinoButton(child: Text(label), onPressed: onPressed);

  @override
  Widget createSwitch(bool value, ValueChanged<bool> onChanged) =>
      CupertinoSwitch(value: value, onChanged: onChanged);
}
```

Usage:

```dart
WidgetFactory factory = Platform.isIOS
    ? CupertinoWidgetFactory()
    : MaterialWidgetFactory();

Widget build(BuildContext context) {
  return Column(
    children: [
      factory.createButton("Click Me", () => print("Pressed")),
      factory.createSwitch(true, (v) => print("Switch: $v")),
    ],
  );
}
```

---

#### (b) **Service Abstraction (Firebase vs Local DB)**

```dart
abstract class StorageFactory {
  UserStorage createUserStorage();
  ProductStorage createProductStorage();
}

// Firebase
class FirebaseStorageFactory implements StorageFactory {
  @override
  UserStorage createUserStorage() => FirebaseUserStorage();
  @override
  ProductStorage createProductStorage() => FirebaseProductStorage();
}

// Local DB
class LocalStorageFactory implements StorageFactory {
  @override
  UserStorage createUserStorage() => SQLiteUserStorage();
  @override
  ProductStorage createProductStorage() => SQLiteProductStorage();
}
```

This allows you to swap the **entire data layer** (e.g., Firebase vs SQLite) without touching client code.

---

### 8. **Advantages**

✅ Provides **consistency** across product families.
✅ Enables **easy swapping** of product families.
✅ Supports **dependency inversion** (client depends on interfaces, not concrete classes).
✅ Great for **unit testing** (mock factories can be injected).

---

### 9. **Disadvantages**

⚠️ Adds **extra complexity** (more classes/interfaces).
⚠️ If you only need **one product type**, a simple **Factory Method** is enough.
⚠️ Overkill for small apps — shines in **large, multi-platform projects**.

---

# ⚡ TL;DR

* **Factory Method** = create **one product** at a time.
* **Abstract Factory** = create **entire product families** (consistent, swappable).
* **Flutter Real Use** → Service layers, cross-platform UI kits, theming, testing.
* **Benefits** → Consistency, flexibility, testability.
* **Tradeoff** → More boilerplate.
