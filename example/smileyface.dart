import 'package:braille_dart/braille.dart';

// ...Man, I do know how the code works, but I don't know
// how will I illustrate every dot of a mouth.
void main() {
  var canvas = BrailleBaseCanvas(2, 4);
  // Eyes
  canvas.access(0, 1).dotOn(0, 1); // Left eye
  canvas.access(0, 2).dotOn(1, 1); // Right eye

  // Mouth

  // First character
  canvas.accessXY(0, 1).dotOn(0, 0);
  canvas.accessXY(0, 1).dotOn(1, 1);

  // Second character
  canvas.accessXY(1, 1).dotOn(0, 1);
  canvas.accessXY(1, 1).dotOn(1, 1);

  // Third character
  canvas.accessXY(2, 1).dotOn(0, 1);
  canvas.accessXY(2, 1).dotOn(1, 1);

  // Fourth character
  canvas.accessXY(3, 1).dotOn(0, 1);
  canvas.accessXY(3, 1).dotOn(1, 0);
  print(canvas);
}