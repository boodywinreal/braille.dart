# Braille.dart
A helper library for Text-based User Interfaces related to the Braille Unicode symbols.

## Features
- Undependencies: Fully made on pure Dart without dependencies, usable whether you install it through `dart pub add` or just copy-pasting the library content.
- Performance: Heavily depends on bitwise manipulation.
- API Duality: You can literally use the raw bit values or just go with X and Y.

## Example
```dart
var char = BrailleCharacter();

char.dotOn(0, 0);
char.dotOn(1, 2);
char.dotOn(0, 3);

print("$char"); // Output: '⡡'

char.invert();
print("$char"); // Output: '⢞'
```
For a full example - which shows making an F shape, see `example/braille_example.dart`