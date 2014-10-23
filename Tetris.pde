// Tetris.pde

//**********FIELD
import java.util.Arrays;
import java.lang.*;
int a = 29; // Field height (more than visible to accomodate rotation on top)
int b = 10; // Field width
int x, y; 
int gridSize = 20;
int[][] field = new int[a][b];
int rect_width, rect_height;
PShape[][] fieldColor = new PShape[a][b];
//**********FIELD
PShape backgroundDesign;
int dropSpeed = 30;
//Piecetype defines the Illustrator svg files for each piece. 
//Each svg file holds a different collor, corresponding to each piece
PieceType L_piece, J_piece, Z_piece, S_piece, T_piece, square_piece, I_piece, currentPiece, nextPiece, tempPiece;

int rotation_status = 1; //Default rotation status (upright piece)
//Piecedesign defines the array info for each piece type

Computer computer;
PFont font;

int[][] L_pieceDesign = new int[][]{ {0,0,0,0,0},
                                     {0,0,1,0,0},
                                     {0,0,1,0,0},
                                     {0,0,1,1,0},
                                     {0,0,0,0,0}};
int[][] J_pieceDesign = new int[][]{ {0,0,0,0,0},
                                     {0,0,1,0,0},
                                     {0,0,1,0,0},
                                     {0,1,1,0,0}, 
                                     {0,0,0,0,0}};
int[][] Z_pieceDesign = new int[][]{ {0,0,0,0,0},
                                     {0,1,1,0,0},
                                     {0,0,1,1,0},
                                     {0,0,0,0,0},
                                     {0,0,0,0,0}};
int[][] S_pieceDesign = new int[][]{ {0,0,0,0,0},
                                     {0,0,1,1,0},
                                     {0,1,1,0,0},
                                     {0,0,0,0,0},
                                     {0,0,0,0,0}};
int[][] T_pieceDesign = new int[][]{ {0,0,0,0,0},
                                     {0,0,1,0,0},
                                     {0,1,1,1,0},
                                     {0,0,0,0,0},
                                     {0,0,0,0,0}};
int[][] square_pieceDesign = new int[][]{{0,0,0,0,0},
                                        {0,1,1,0,0},
                                        {0,1,1,0,0},
                                        {0,0,0,0,0},
                                        {0,0,0,0,0}};
int[][] I_pieceDesign = new int[][]{ {0,0,1,0,0},
                                     {0,0,1,0,0},
                                     {0,0,1,0,0},
                                     {0,0,1,0,0},
                                     {0,0,0,0,0}};

void setup() {
  smooth(); 
  size(800, 600);
  ellipseMode(CENTER);
  L_piece = new PieceType("L block", L_pieceDesign, "Lblock.svg");  //The svg file has information for color of block.  Edit svg's in illustrator
  J_piece = new PieceType("J block", J_pieceDesign, "Jblock.svg");
  Z_piece = new PieceType("Z block", Z_pieceDesign, "Zblock.svg");
  S_piece = new PieceType("S block", S_pieceDesign, "Sblock.svg");
  T_piece = new PieceType("T block", T_pieceDesign, "Tblock.svg");
  square_piece = new PieceType("square block", square_pieceDesign, "squareblock.svg");
  I_piece = new PieceType("I block", I_pieceDesign, "Iblock.svg");


  //  tempPiece  = randomPiece2(); 
  tempPiece = new PieceType("S block", S_pieceDesign, "Sblock.svg");

  currentPiece = randomPiece();
  nextPiece = randomPiece();
  backgroundDesign = loadShape("Gamebackgroundv1.svg");
  shape(backgroundDesign);

  int x = 1;

  //Initialize field with emptiness
  for (int i = 0; i < a; i++) {
    for (int j = 0; j < b; j++) {
      field[i][j] = 0;
    }
  }
  //**********FIELD

  computer = new Computer(a, b);
  font = loadFont("Arial-Black-48.vlw");
  textFont(font, 10);
}

void setToNextPiece() {
  currentPiece = nextPiece;
  nextPiece = randomPiece();
}

PieceType randomPiece() {
  int r = int(random(1, 8));
  if (r == 1) {
    return I_piece;
  } else if ( r == 2) {
    return T_piece;
  } else if ( r == 3) {
    return S_piece;
  } else if ( r == 4) {
    return Z_piece;
  } else if ( r == 5) {
    return square_piece;
  } else if ( r == 6) {
    return L_piece;
  } else if ( r == 7) {
    return J_piece;
  }
  return I_piece; // dummy return
}

PieceType randomPiece2() {
  PieceType p = new PieceType("S block", S_pieceDesign, "Sblock.svg");
  return p;
}

void draw() {
  currentPiece.runPiece(); 
  computer.getMove(currentPiece, field);
}

void keyPressed() {
  currentPiece.userInput();
}
