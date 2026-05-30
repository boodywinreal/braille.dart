import 'package:braille_dart/braille.dart';

void main() {
  var char = BrailleCharacter();

  char.dotOn(0, 0);
  char.bitOn(0x20); // Which is the same as dot (1, 2)
  char.bitOn(char.bit(0, 3)); // Where `char.bit` converts to a bit
  // then it turns it on, a better shortcut is `dotOn`.

  print("$char"); // Output: '⡡'

  char.invert();
  print("$char"); // Output: '⢞'
}