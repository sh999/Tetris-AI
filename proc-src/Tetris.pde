// Tetris.pde

//**********FIELD
import java.util.Arrays;
import java.lang.*;
int a = 29; // Field height (more than visible to accomodate rotation on top)
int b = 10; // Field width
int x, y; // Grid locations, used in pieceType.drawField()
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

Status gameStatus = Status.MAINMENU;
MainMenu mainMenu = new MainMenu();
ScoreKeeper scoreKeeper;
String[] scores; 

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
  size(500, 600);
  ellipseMode(CENTER);
  rectMode(CENTER);
  scoreKeeper = new ScoreKeeper();
  
  L_piece = new PieceType("L block", L_pieceDesign, "Lblock.svg");  //The svg file has information for color of block.  Edit svg's in illustrator
  J_piece = new PieceType("J block", J_pieceDesign, "Jblock.svg");
  Z_piece = new PieceType("Z block", Z_pieceDesign, "Zblock.svg");
  S_piece = new PieceType("S block", S_pieceDesign, "Sblock.svg");
  T_piece = new PieceType("T block", T_pieceDesign, "Tblock.svg");
  square_piece = new PieceType("square block", square_pieceDesign, "squareblock.svg");
  I_piece = new PieceType("I block", I_pieceDesign, "Iblock.svg");
  tempPiece = new PieceType("S block", S_pieceDesign, "Sblock.svg");
  currentPiece = randomPiece();
  nextPiece = randomPiece();
  
  backgroundDesign = loadShape("Gamebackgroundv2.svg");
  shape(backgroundDesign);
  
  
  int x = 1;
  

  //Initialize field with emptiness
  for (int i = 0; i < a; i++) {
    for (int j = 0; j < b; j++) {
      field[i][j] = 0;
    }
  }
  //**********FIELD

//  computer = new Computer(a, b);
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

void draw() {
  gameStatus = mainMenu.getStatus();
  if(gameStatus == Status.MAINMENU){
    mainMenu.drawMenu();
  }
  else if (gameStatus == Status.PLAYGAME){
    currentPiece.runPiece();
    scoreKeeper.displayScore();
  } 
  else if (gameStatus == Status.CONTROLS){
    mainMenu.drawControls();
  }
  else if (gameStatus == Status.ABOUT){
    mainMenu.drawAbout();
  }
  else if (gameStatus == Status.HIGHSCORE){
    mainMenu.drawHighScore();
  }
  else if (gameStatus == Status.PAUSE){
    mainMenu.drawPause();
  }
  else if (gameStatus == Status.ENDGAME){
    mainMenu.gameOver();
  }
//  scoreKeeper.displayScore();
//  computer.run(currentPiece, field);
//  print("game status = "+gameStatus);
}

void changeGameStateToEnd(){
  gameStatus = Status.ENDGAME;
}

void keyPressed() {
  if(gameStatus == Status.MAINMENU){
    mainMenu.keyboardResponse();
  }
  else if (gameStatus == Status.PLAYGAME){
    switch(keyCode){
      default:
      if(key == 'p'){
        mainMenu.setStatus(Status.PAUSE);
      }
      
    }
    currentPiece.userInput();
  }
  else if (gameStatus == Status.ABOUT){
    mainMenu.setStatus(Status.MAINMENU);
    shape(backgroundDesign);
  }
  else if (gameStatus == Status.CONTROLS){
    mainMenu.setStatus(Status.MAINMENU);
    shape(backgroundDesign);
  }
  else if (gameStatus == Status.PAUSE){
    switch(keyCode){
      default:
      if(key == 'p'){
        mainMenu.setStatus(Status.PLAYGAME);
        shape(backgroundDesign);
      }
    }
    mainMenu.keyboardResponse();
  }
}

void drawMenu(){
  noStroke();
  fill(255);
  rect(width/2, height/2, 230, 200);
  fill(0);
  textFont(font, 30);
  text("Start", width/2-80, height/2-50);
  text("Help", width/2-80, height/2-10);
  text("About", width/2-80, height/2+30);  
  text("Quit", width/2-80, height/2+70);
}
