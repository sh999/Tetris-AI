/*Tetris version 0.5
Ver 0.5: Have better OOP design--Break down piecetype class
This version is intended to lead to the final tetris game
I have attempted to program tetris twice:
6/27: Fix disappearing piece.  Something to do with array passing thru function
One ends up with SaTris_no_trig:  Has good graphics but lacking in collision detection/tetris algorithm.  Has real tetris pieces
Two ends up with Tetris redesign with animation:  Has no graphics but has collision/tetris algorithm.  Doesn't incorporate real tetris pieces
Another important program is Tetris_2D_field_study
version 0.4: Can move around pieces and have collision detection.  Bug in that some pieces stay on field randomly.  Has bad
  OOP structure.  Version 0.5 will be more readable and have better OOP structure.

7/3(Done): change color every piece. Done 7/7!
  create block class?
  7/7: Prevent disappearing permanent field

7/7(Done!): Check bottom, side, collisions
  7/7: Make booleans to know status of where piece can move.  Do this for left, right, bottom wall collisions. Done, with some bugs.
7/14: fix piece falling through bug, check checkallowablemoves().  FIxed 7/15.  Problem was when piece is on the edge
7/15: after fixing previous bug, another bug occurs where if piece touches wall, it can't move toward that edge even
  after it has been moved to middle

7/21 (Done): Fixed left collision.  Right collision has issue where I piece once horizontal and pushed to the well can't go right anymore
  bug occurs due to piecedesign[i][j] = 1 on the boundary.  Can be replicated if I piece's horizontal rotation is changed so that
  instead of looking like 01111 it is changed to 11110; in this case the piece will hit the left wall and can't be moved left anymore
  in effect mirroring the bug to the left side... 7/21
    fixed else if cause....not really sure why it didn't work before 7/21

7/22(Done): Drop piece feature.  Done 7/23!
  7/22: Working on instantMethod().  Done 7/23!

7/22 (Done): Rotate collision detection
  7/23: Working on checkValidRotation(). Done!
 
7/24: Working on checkTetris() Done
  array out of bounds exception due to out of bounds on j when comparing field with empty part of piecedesign that's out of bounds
7/25: Work on clearlines().
  Can clear line.  Make algorithm for when multiple lines have tetris. 7/26
Bugs:
sometimes a piece falls through. Fixed 7/15  Never mind 7/21
7:22: starting with i piece, changing direction left/right raises position by 1. Fixed 7/22

*/
//**********FIELD
import java.util.Arrays;

int b = 10;
int a = 25;
int x;
int y;
int gridSize = 20;
int[][] field = new int[a][b];
int rect_width, rect_height;

PShape[][] fieldColor = new PShape[a][b];

/*PShape block;
 String svgFileURL = "Lblock.svg";
int pieceHeight;
  int pieceWidth;*/
//**********FIELD

PShape backgroundDesign;
//Piecetype defines the illustrator/pixel files for each piece. 
//Since each piece type is made of different colors, they have different variables
PieceType L_piece;
PieceType J_piece;
PieceType Z_piece;
PieceType S_piece;
PieceType T_piece;
PieceType square_piece;
PieceType I_piece;
PieceType currentPiece;
int rotation_status = 1; //Default rotation status (upright piece)
//Piecedesign defines the array info for each piece type
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
  currentPiece = I_piece; //Piece that is currently falling
  backgroundDesign = loadShape("Gamebackgroundv1.svg");
  shape(backgroundDesign);
  int x = 1;
  
  //**********FIELD
  for(int i = 0; i < a; i++){
    for(int j = 0; j < b; j++){
      
      field[i][j] = 0; //0 = empty field
      //if(i == 20){ field[i][j] = 2;} //2 = filled field 
      
    }
  }
  //**********FIELD
  
}

void draw() {
  //drawField();
  currentPiece.display(); 

}

void keyPressed(){
  currentPiece.userInput(); 
}

void updateField(){
  print("ahahaha");
}

void drawField(){
  stroke(255);
  for(int i = 0; i < a; i++){
    for(int j = 0; j < b; j++){
      x = i*gridSize+width/2-(gridSize*a/2); //x and y are grid locations
      y = j*gridSize+height/2-(gridSize*b/2); 
      if(field[i][j] == 0){ //Where there is no piece, have block
        fill(0);
      }
      else fill(255); //Where there is fill, have block
      rect(x, y, gridSize, gridSize);  
    }
  }
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
  
  
    
  

