/*Tetris version 0.5
*/

//**********FIELD
import java.util.Arrays;
int a = 25;
int b = 10;
int x, y;
int gridSize = 20;
int[][] field = new int[a][b];
int rect_width, rect_height;
PShape[][] fieldColor = new PShape[a][b];
//**********FIELD

PShape backgroundDesign;

//Piecetype defines the Illustrator svg files for each piece. 
//Each svg file holds a different collor, corresponding to each piece
PieceType L_piece, J_piece, Z_piece, S_piece, T_piece, square_piece, I_piece, currentPiece;

int rotation_status = 1; //Default rotation status (upright piece)
//Piecedesign defines the array info for each piece type

Computer computer;

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
  
  
  L_piece = new PieceType("L block",L_pieceDesign,"Lblock.svg");  //The svg file has information for color of block.  Edit svg's in illustrator
  J_piece = new PieceType("J block",J_pieceDesign,"Jblock.svg");
  Z_piece = new PieceType("Z block",Z_pieceDesign,"Zblock.svg");
  S_piece = new PieceType("S block",S_pieceDesign,"Sblock.svg");
  T_piece = new PieceType("T block",T_pieceDesign,"Tblock.svg");
  square_piece = new PieceType("square block",square_pieceDesign,"squareblock.svg");
  I_piece = new PieceType("I block",I_pieceDesign,"Iblock.svg");
  
  currentPiece = I_piece; //Piece that initially falls, will change after each piece is dropped
  
  backgroundDesign = loadShape("Gamebackgroundv1.svg");
  shape(backgroundDesign);
  
  int x = 1;
  
  //Initialize field with emptiness
  for(int i = 0; i < a; i++){
    for(int j = 0; j < b; j++){
      field[i][j] = 0; 
    }
  }
  //**********FIELD
  
  computer = new Computer(a, b, currentPiece);
  
}

void draw() {
  currentPiece.display(); 
//  currentPiece.getComputerResponse(computer);
}

void keyPressed(){
  currentPiece.userInput(); 
}

/*
To load SVGs
  Class myClass;
void setup(){
  myClass = Class(SVGURL)
  myClass.drawmethod();
}
Class{
  PShape mySVG;
  String SVGURL;
  Class(String SVGURL){
    SVGURL = SVGURL_;
  }
  drawmethod{
    mySVG = loadShape(SVGURL);
  }
}
*/
