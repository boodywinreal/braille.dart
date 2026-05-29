/// ## braille.dart
/// A helper library for Text-based User Interfaces related to the Braille Unicode symbols.
/// 
/// Info that you might need:
/// - Bit: the integer representation of a dot on the symbol
library;

/// ## [BrailleCharacter]
/// The base class of a singular Braille character
/// 
/// Provides the low-level tools like `fill`, `clear`, `invert`,
/// and other bits and dots controlling functions
class BrailleCharacter {
    /// The bitmask used as a 1D array, representing a flat 2x4 2D matrix
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
    /// Which is why you need to turn it into a space (\u0020 or ' ').
    late bool emptyIsSpace;
    /// Creates a single BrailleCharacter object
    /// 
    /// emptyIsSpace is `true` by default
    BrailleCharacter({this.emptyIsSpace = true});

    /// Fills the whole character, which sets [sum] to 0xff (255 in decimal)
    void fill() => sum = 0xff;
    /// Clears the whole character, which clears out [sum] to zero
    void clear() => sum = 0x00;
    /// Inverts all bits in the character,
    /// which uses the XOR operator on [sum] and 0xff (255 in decimal)
    void invert() => sum ^= 0xff;

    /// Turns on a bit
    void bitOn(int bit) => sum |= bit;
    /// Turns off a bit
    void bitOff(int bit) => sum &= ~bit;
    /// Toggles a bit
    void bitToggle(int bit) => sum ^= bit;
    /// Gets the state of the given bit
    bool bitIsActive(int bit) => (sum & bit) != 0;

    /// Gets the integer bit from X and Y
    int bit(int X, int Y) => _bits[(Y << 1) + X];

    /// Turns on a dot
    void dotOn(int X, int Y) => bitOn(bit(X, Y));
    /// Turns off a dot
    void dotOff(int X, int Y) => bitOff(bit(X, Y));
    /// Toggles a dot
    void dotToggle(int X, int Y) => bitToggle(bit(X, Y));
    /// Gets the state of the given dot
    bool dotIsActive(int X, int Y) => bitIsActive(bit(X, Y));

    /// The integer unicode getter
    int get unicode => (sum == 0) && emptyIsSpace ? 0x20 : 0x2800 + sum;

    /// Overrider to the built-in toString()
    @override
    String toString() => String.fromCharCode(unicode);
}