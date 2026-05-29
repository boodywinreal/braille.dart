import 'package:braille_dart/braille.dart';

void main(){
    print("Braille.dart demo (Shaping F)");
    print("-----------------------------");

    // Initializing a BrailleCharacter object with the name `char`
    var char = BrailleCharacter();

    // Writing the dots
    char.dotOn(0, 0); char.dotOn(1, 0);
    char.dotOn(0, 1);
    char.dotOn(0, 2); char.dotOn(1, 2);
    char.dotOn(0, 3);

    // Printing the character
    print("Character: $char");
    print("------------");

    // Inverting
    char.invert();
    print("Inverted character: $char");
    print("---------------------");

    // "Clearing" everything up
    char.clear();
    print("This should be a space: '$char'");

    // Or just making it invisible but existing
    char.emptyIsSpace = false;
    print("This shouldn't be a space but rather an empty Braille character: '$char'");
}