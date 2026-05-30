# Braille.dart
A helper library for Text-based User Interfaces related to the Braille Unicode symbols.

## Features
- **Uses Zero Dependencies**: Fully made on pure Dart without dependencies, usable whether you install it through `dart pub add` or just copy-pasting the library content.
- **Performance-first architecture**: Heavily depends on bitwise and integer value manipulation.
- **API-dual**: You can use the raw bit values or just stick with X and Y.
- **Documented**: The code is fully documented with most details.

## Examples
### 1. Basic implementation (see `example/main.dart`)
```dart
var char = BrailleCharacter();

char.dotOn(0, 0);
char.bitOn(0x20); // Which is the same as dot (1, 2)
char.bitOn(char.bit(0, 3)); // Where `char.bit` converts to a bit
// then it turns it on, a better shortcut is `dotOn`.

print("$char"); // Output: '⡡'

char.invert();
print("$char"); // Output: '⢞'
```

### 2. F shape (see `example/fshape.dart`)
```dart
var char = BrailleCharacter();

// Writing the dots
char.dotOn(0, 0); char.dotOn(1, 0);
char.dotOn(0, 1);
char.dotOn(0, 2); char.dotOn(1, 2);
char.dotOn(0, 3);

// Printing the character
print("Character: $char"); // Outputs '⡯'
print("------------");
```

## Should-know definitions
- **Dot**: the main X and Y representation of a visible point on the Braille Unicode character.
- **Bit**: the integer representation of a dot on the symbol.
- **Pixel**: the X and Y representation of a dot on any symbol in a canvas.
- **Base Canvas**: the canvas that is measured by lines and columns where a single line and a single column equal 2x4 pixels (A full Braille character).