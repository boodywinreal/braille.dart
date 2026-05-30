/// A helper library for Text-based User Interfaces related to the Braille Unicode symbols.
// ignore: unnecessary_library_name
library Braille;

/// The base class of a singular Braille character.
///
/// Provides the low-level tools like `fill`, `clear`, `invert`,
/// and other bits and dots controlling functions.
class BrailleCharacter {
  /// The bitmask used as a 1D array, representing a flat 2x4 2D matrix.
  static const List<int> _bits = [
    0x01, 0x08, // Y = 0
    0x02, 0x10, // Y = 1
    0x04, 0x20, // Y = 2
    0x40, 0x80  // Y = 3
  // X=0, X=1
  ];

  /// The sum of the bits of the character.
  int sum = 0;

  /// In unicode, `\u2800` is a Braille empty symbol, and
  /// many text previewers view it as if it were a visible symbol.
  /// Which is why you need to turn it into a space (`\u0020` or ' ').
  late bool emptyIsSpace;

  /// The constructor of the BrailleCharacter object.
  ///
  /// `emptyIsSpace` is `true` by default.
  BrailleCharacter({this.emptyIsSpace = true});

  /// Fills the whole character, which sets [sum] to `0xff` (255 in decimal).
  void fill() => sum = 0xff;

  /// Clears the whole character, which clears out [sum] to zero.
  void clear() => sum = 0x00;

  /// Inverts all bits in the character,
  /// which uses the XOR operator on [sum] and `0xff` (255 in decimal).
  void invert() => sum ^= 0xff;

  /// Turns on a bit.
  void bitOn(int bit) => sum |= bit;

  /// Turns off a bit.
  void bitOff(int bit) => sum &= ~bit;

  /// Toggles a bit.
  void bitToggle(int bit) => sum ^= bit;

  /// Gets the state of the given bit.
  bool bitIsActive(int bit) => (sum & bit) != 0;

  /// Gets the integer bit from X and Y.
  int bit(int X, int Y) => _bits[(Y << 1) + X];

  /// Turns on a dot.
  void dotOn(int X, int Y) => bitOn(bit(X, Y));

  /// Turns off a dot.
  void dotOff(int X, int Y) => bitOff(bit(X, Y));

  /// Toggles a dot.
  void dotToggle(int X, int Y) => bitToggle(bit(X, Y));

  /// Gets the state of the given dot.
  bool dotIsActive(int X, int Y) => bitIsActive(bit(X, Y));

  /// The integer unicode getter.
  int get unicode => (sum == 0) && emptyIsSpace ? 0x20 : 0x2800 + sum;

  /// The hash code for the current BrailleCharacter object.
  @override
  int get hashCode => sum;

  /// The equal sign overrider for equality operations.
  @override
  bool operator ==(Object other) 
    => identical(this, other) || (other is BrailleCharacter && other.sum == sum);

  /// Overrider to the built-in `toString()`.
  @override
  String toString() => String.fromCharCode(unicode);
}

/// The base class of a Braille Characters Canvas.
/// 
/// Measured with lines and columns, and should be inputed
/// when accessing a bit or a dot inside a character.
class BrailleBaseCanvas {
  /// The count of lines in the canvas.
  late int lines;

  /// The count of columns in each line in the canvas.
  late int columns;

  /// The character list to store the full canvas,
  /// as a 1D array representing a 2D matrix.
  late List<BrailleCharacter> characterList;

  /// In unicode, `\u2800` is a Braille empty symbol, and
  /// many text previewers view it as if it were a visible symbol.
  /// Which is why you need to turn it into a space (`\u0020` or ' ').
  late bool emptyIsSpace;

  /// The separator character used when converting the canvas to a string,
  /// not recommended to use another braille character for the separator.
  late String separator;

  /// The internal list generator of BrailleBaseCanvas.
  List<BrailleCharacter> _genList(int n, bool eIS)
    => List.generate(
      n,
      (_) => BrailleCharacter(emptyIsSpace: eIS)
    );

  /// The constructor of the BrailleBaseCanvas.
  /// 
  /// `emptyIsSpace` is `true` by default. <br>
  /// `separator` is a newline (`\n`) by default,
  /// not recommended to use a Braille character.
  BrailleBaseCanvas(this.lines, this.columns, {this.emptyIsSpace = true, this.separator = '\n'}) {
    assert(lines > 0, "Lines should be more than 0");
    assert(columns > 0, "Columns should be more than 0");
    characterList = _genList(lines * columns, emptyIsSpace);
  }

  /// Access (get) a specific character inside the canvas
  BrailleCharacter access(int line, int column) {
    int index = column * lines + line;
    assert(
      (index >= 0) && (index < lines * columns),
      "Index $index out of range"
    );

    return characterList[column * lines + line];
  }

  /// Fills the whole canvas.
  void fillAll() => { for(BrailleCharacter i in characterList) i.fill() };

  /// Clears the whole canvas.
  void clearAll() => { for(BrailleCharacter i in characterList) i.clear() };

  /// Inverts the whole canvas.
  void invertAll() => { for(BrailleCharacter i in characterList) i.invert() };

  /// Turns on a given bit in every character in the canvas,
  /// best use when making a pattern.
  void bitsAllOn(int bitInEach)
    => { for(BrailleCharacter i in characterList) i.bitOn(bitInEach) };

  /// Turns off a given bit in every character in the canvas,
  /// best use when making a pattern.
  void bitsAllOff(int bitInEach)
    => { for(BrailleCharacter i in characterList) i.bitOff(bitInEach) };
  
  /// Toggles a given bit in every character in the canvas,
  /// best use when making a pattern.
  void bitsAllToggle(int bitInEach)
    => { for(BrailleCharacter i in characterList) i.bitToggle(bitInEach) };
  
  /// Turns on a given dot in every character in the canvas,
  /// best use when making a pattern.
  void dotsAllOn(int eachX, int eachY)
    => { for(BrailleCharacter i in characterList) i.dotOn(eachX, eachY) };
  
  /// Turns off a given dot in every character in the canvas,
  /// best use when making a pattern.
  void dotsAllOff(int eachX, int eachY)
    => { for(BrailleCharacter i in characterList) i.dotOff(eachX, eachY) };
  
  /// Toggles a given dot in every character in the canvas,
  /// best use when making a pattern.
  void dotsAllToggle(int eachX, int eachY)
    => { for(BrailleCharacter i in characterList) i.dotToggle(eachX, eachY) };
}