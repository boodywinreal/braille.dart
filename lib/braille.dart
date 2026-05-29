/// ## braille.dart
/// A helper library for Text-based User Interfaces related to the Braille Unicode symbols.
/// 
/// Info that you might need:
/// - Bit: the integer representation of a dot on the symbol
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
    /// In unicode, \u2800 is a Braille empty symbol, and
    /// many text previewers view it as if it were a visible symbol.
    /// Which is why you need to turn it into a space (\u20 or ' ').
    late bool emptyIsSpace;
    BrailleCharacter({this.emptyIsSpace = true});

    /// Fills the whole character
    void fill() => sum = 0xff;
    /// Clears the whole character
    void clear() => sum = 0x00;
    /// Inverts all bits in the character, which uses the XOR logic gate
    void invert() => sum ^= 0xff;

    /// Turns on a bit
    void bitOn(int bit) => sum |= bit;
    /// Turns off a bit
    void bitOff(int bit) => sum &= ~bit;
    /// Toggles a bit
    void bitToggle(int bit) => sum ^= bit;
    /// Gets the state of the current bit
    bool bitIsActive(int bit) => (sum & bit) != 0;

    /// Gets the integer bit from X and Y
    int bit(int X, int Y) => _bits[(Y << 1) + X];
}