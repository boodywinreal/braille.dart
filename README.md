# Braille.dart
A helper library for Text-based User Interfaces related to the Braille Unicode symbols.

## Features so far
- BrailleCharacter: The core of the library, which has handling for position-specific dots or value-specific dots (called bits) and auto-converting to a string (overrided toString)

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
For a full example - about making an F shape, see `example/braille_example.dart`