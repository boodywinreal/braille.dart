import 'package:test/test.dart';
import 'package:braille_dart/braille.dart';

void main() {
  group("BrailleCharacter", () {
    late BrailleCharacter char;

    setUp(() {
      char = BrailleCharacter();
    });

    /// Default value testing
    test(
        "The default sum value should be 0", () => expect(char.sum, equals(0)));
    test("The default emptyIsSpace value should be true",
        () => expect(char.emptyIsSpace, isTrue));

    /// Basic bit functionality
    test("bitOn, bitOff, bitToggle and bitIsActive functionality", () {
      // Turning on bit 0x01 (X=0, Y=0)
      char.bitOn(0x01);
      expect(char.sum, equals(0x01));

      // Trying to turn on and already turned on bit 0x01 (X=0, Y=0)
      char.bitOn(0x01);
      expect(char.sum, equals(0x01));

      // Turning off bit 0x01 (X=0, Y=0)
      char.bitOff(0x01);
      expect(char.sum, equals(0x00));

      // Trying to turn off and already turned off bit 0x20 (X=1, Y=2)
      char.bitOff(0x20);
      expect(char.sum, equals(0x00));

      // Toggling bit 0x02 (X=0, Y=1)
      char.bitToggle(0x02);
      expect(char.sum, equals(0x02));

      // Toggling bit 0x02 (X=0, Y=1)
      char.bitToggle(0x02);
      expect(char.sum, equals(0x00));

      // Checking on bit 0x01 (X=0, Y=0)
      expect(char.bitIsActive(0x01), isFalse);
    });

    // Basic dot functionality
    test("dotOn, dotOff, dotToggle, dotIsActive and bit functionality", () {
      // Turning on dot (0, 0)
      char.dotOn(0, 0);
      expect(char.sum, equals(0x01));

      // Trying to turn on and already turned on dot (0, 0)
      char.dotOn(0, 0);
      expect(char.sum, equals(0x01));

      // Turning off dot (0, 0)
      char.dotOff(0, 0);
      expect(char.sum, equals(0x00));

      // Trying to turn off and already turned off dot (1, 2)
      char.dotOff(1, 2);
      expect(char.sum, equals(0x00));

      // Toggling dot (0, 1)
      char.dotToggle(0, 1);
      expect(char.sum, equals(0x02));

      // Toggling dot (0, 1)
      char.dotToggle(0, 1);
      expect(char.sum, equals(0x00));

      // Checking on dot (0, 0)
      expect(char.dotIsActive(0, 0), isFalse);

      // Converting a dot to a bit
      expect(char.bit(1, 3), equals(0x80));
    });

    // General functions
    test("Manipulation of fill, clear and invert", () {
      // fill tester
      char.fill();
      expect(char.sum, equals(0xff));

      // clear tester
      char.clear();
      expect(char.sum, equals(0x00));

      // invert tester
      char.dotOn(1, 2);
      char.invert();
      expect(char.sum, equals(0xff ^ 0x20));
    });

    // unicode and toString
    test("unicode getter and emptyIsSpace respect", () {
      // when emptyIsSpace = true
      char.emptyIsSpace = true;
      expect(char.unicode, equals(0x0020));

      // when emptyIsSpace = false
      char.emptyIsSpace = false;
      expect(char.unicode, equals(0x2800));

      // when the character isn't empty
      char.bitOn(0x01);
      expect(char.unicode, equals(0x2801));
    });
    test("Shaping the letter F with braille", () {
      char.dotOn(0, 0);
      char.dotOn(1, 0);
      char.dotOn(0, 1);
      char.dotOn(0, 2);
      char.dotOn(1, 2);
      char.dotOn(0, 3);

      // Explicit way
      expect(char.toString(), equals('⡯'));

      // Implicit way
      expect("$char", equals('⡯'));
    });
  });
  group("BrailleBaseCanvas", () {
    late BrailleBaseCanvas canvas;

    setUp(() => (canvas = BrailleBaseCanvas(4, 8)));
    test("Checking input values, and default values", () {
      // Checking given value: `lines`
      expect(canvas.lines, equals(4));
      // Checking given value: `columns`
      expect(canvas.columns, equals(8));

      // Checking default value: `emptyIsSpace`
      expect(canvas.emptyIsSpace, isTrue);
      // Checking default value: `separator`
      expect(canvas.separator, equals('\n'));
    });
    test("Checking input assertions", () {
      expect(() => BrailleBaseCanvas(0, 1), throwsA(isA<AssertionError>()));
      expect(() => BrailleBaseCanvas(5, -2), throwsA(isA<AssertionError>()));
    });

    // ... This is enough tests for now, adding later...
  });
}
