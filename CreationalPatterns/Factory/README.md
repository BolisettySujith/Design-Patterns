
# 🔹 Factory Method Pattern

### 1. **Definition**

The **Factory Method Pattern** defines an interface for creating an object but lets **subclasses decide which class to instantiate**.

* It provides a **single method** (the factory method) that returns a product.
* The client uses the abstract interface and doesn’t know the exact concrete class being instantiated.

Think of it as a **“customizable object creator”** ⚙️.

---

### 2. **Difference from Abstract Factory**

| **Aspect**  | **Factory Method**                 | **Abstract Factory**                                              |
| ----------- | ---------------------------------- | ----------------------------------------------------------------- |
| Focus       | Creates **one product** at a time. | Creates **a family of related products**.                         |
| Example     | Create a `Button` for Android/iOS. | Create a **UI Kit** (Button + Checkbox + Dialog) for Android/iOS. |
| Flexibility | Simpler and lightweight.           | More powerful but adds complexity.                                |
| UML analogy | One abstract creator.              | Multiple factories producing product families.                    |

---

### 3. **When to Use Factory Method**

✅ You want to delegate object creation to subclasses.
✅ You want to **abstract away platform-specific or service-specific classes**.
✅ You need **testability and flexibility** without hard-coding object creation.
✅ You don’t need full **families of objects** — just **one product type** per factory.

---

### 4. **Core Components**

* **Creator (Abstract Class)** → Declares the factory method (`createButton()`), which returns an abstract product.
* **Concrete Creators (Subclasses)** → Override the factory method to return a concrete product (e.g., `AndroidDialog → AndroidButton`).
* **Abstract Product** → Defines the interface (e.g., `Button`).
* **Concrete Products** → Actual implementations (`AndroidButton`, `IOSButton`).
* **Client Code** → Calls the creator’s method but works only with **abstract types**, not knowing the concrete implementation.

---

### 5. **Dart Example (UI Button)**

```dart
// Abstract Creator
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
```

---

### 6. **Client Code (Usage)**

```dart
void main() {
  Dialog dialog;

  if (Platform.isAndroid) {
    dialog = AndroidDialog();
  } else if (Platform.isIOS) {
    dialog = IOSDialog();
  } else {
    throw Exception("Unsupported platform");
  }

  dialog.render();
}
```

💡 The client doesn’t know or care about `AndroidButton` vs `IOSButton`.
It only depends on the **abstract `Button` type**.

---

### 7. **Real-World Flutter Use Cases**

#### (a) **Platform-Specific Widgets**

Factory Method can wrap widget creation:

```dart
abstract class ButtonFactory {
  Widget createButton(String text, VoidCallback onPressed);
}

class MaterialButtonFactory implements ButtonFactory {
  @override
  Widget createButton(String text, VoidCallback onPressed) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}

class CupertinoButtonFactory implements ButtonFactory {
  @override
  Widget createButton(String text, VoidCallback onPressed) {
    return CupertinoButton(child: Text(text), onPressed: onPressed);
  }
}
```

Usage:

```dart
ButtonFactory factory =
    Platform.isIOS ? CupertinoButtonFactory() : MaterialButtonFactory();

Widget build(BuildContext context) {
  return factory.createButton("Click Me", () => print("Pressed!"));
}
```

---

#### (b) **Service Abstraction (API Clients)**

Imagine switching between **REST** and **GraphQL**:

```dart
abstract class ApiClientFactory {
  ApiClient createClient();
}

class RestApiFactory implements ApiClientFactory {
  @override
  ApiClient createClient() => RestApiClient();
}

class GraphQLApiFactory implements ApiClientFactory {
  @override
  ApiClient createClient() => GraphQLApiClient();
}
```

---

### 8. **Advantages**

✅ Encapsulates object creation.
✅ Promotes **loose coupling** (client depends on interfaces).
✅ Easier **unit testing** (mock factories).
✅ Open/closed principle — new product types require new subclasses, not changes to client code.

---

### 9. **Disadvantages**

⚠️ Introduces more classes/subclasses (extra boilerplate).
⚠️ Can be **overkill** if a simple constructor or dependency injection works.
⚠️ Only covers **one product** at a time (Abstract Factory is better for product families).

---

# ⚡ TL;DR

* **Factory Method** = one product, decided at runtime by subclasses.
* **Abstract Factory** = whole product families, swappable.
* **Flutter Real Use** → Platform widgets, service abstraction, dependency injection.
* **Benefits** → Flexibility, testability, clean architecture.
* **Tradeoff** → Boilerplate with abstract classes and subclasses.
