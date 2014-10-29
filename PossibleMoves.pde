/*
In each iteration, computer will calculate score at 
every possible (reasonable) move
*/
class PossibleMoves { //Objects declared in Computer computer.  Draws mini grid of where the move will be, with info sent 
  int originX, originY;
  int rotationStatus;
  int gridSize;
  int[][] field;
  int[][] piece;
  
  PossibleMoves(){ // Coordinate of mini box
    originX = 30;
    originY = 40;
    gridSize = 7;
  }
  
  void draw(){
    drawField();
    drawPiece();
  }
  
  void drawField(){
    stroke(200);
    fill(0);
    for(int i = 10; i < a; i++){
      for(int j = 0; j < b; j++){
        x = j*gridSize+originX;
        y = i*gridSize+originY;
        rect(x, y, gridSize, gridSize);
      }
    }
  }
  
  void drawPiece(){
  }
  
}
