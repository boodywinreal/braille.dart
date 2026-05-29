/// ## braille.dart
/// A helper library for Text-based User Interfaces related to the Braille Unicode symbols.
library;

class BrailleCharacter {
    /// The bits used in
    static const List<int> _bits = [
        0x01, 0x08, // Y = 0
        0x02, 0x10, // Y = 1
        0x04, 0x20, // Y = 2
        0x40, 0x80  // Y = 3
    //   X=0, X=1    
    ];
    /// The sum of the bits of the character
    int sum = 0;
    /// In unicode, \u2800 is a Braille empty symbol,
    /// Many text previewers view it as if it were a visible symbol.
    /// Which is why you need to turn it into a space (\u20 or ' ').
    late bool emptyIsSpace;
    BrailleCharacter({this.emptyIsSpace = true});

    /// Fills the whole character.
    void fill() => sum = 0xff;
    /// Clears the whole character.
    void clear() => sum = 0x00;
    /// Inverts all bits in the character, which uses the XOR logic gate.
    void invert() => sum ^= 0xff;

    
}