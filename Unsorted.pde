void phantomDrop(){
  
}

void printArr(int[][] array){
    for(int i = 17; i < array.length; i++){
      for(int j = 0; j < array[0].length; j++){
        print(array[i][j]);
      }println();
    }println("\n");
  }

void bestMove(int[][] _field, PieceType _piece){
/*
For each piece, calculate possible moves (collision important)
For finding move, can be unidirectional or random 
  Unidirectional is more straightforward but random would be more interesting
For each move, calculate score
  basic score:  If hole created, return 0
  if no hole, return 1
  fancier score:  score based on height/peak created


Building from simple case to complex:
  Calculate score with phantom drop and no AI
  Ignore rotation.  Slide from left to right

*/

}

int lowestRow(PieceType piece){
  /*for(int i = 0; i < piece.pieceHeight; i++){
    for(int j = 0; j < piece.pieceWidth; j++){
      print(piece.pieceDesign[i][j]);
    }println();
  }*/
  boolean pointFound = false;
  int lowestRow = 0;
  int i = piece.pieceHeight-1; 
  do{  // Traverse up and right until a piece square is found
    for(int j = 0; j < piece.pieceWidth; j++){ 
      if(piece.pieceDesign[i][j] == 1){
        lowestRow = i;
        pointFound = true;
      }
    }
    i--;
  }while(pointFound == false && i >= 0);
  return lowestRow;
}

int leftmostColumn(PieceType piece){
  boolean pointFound = false;
  int leftmostColumn = 0;
  int col = 0;
  do{
    
//  for(int col = 0; col < piece.pieceWidth; j++){
    
    for(int row = 0; row < piece.pieceHeight; row++){
      println("checking row "+row+" and column "+col);
      if(piece.pieceDesign[row][col] == 1){
        leftmostColumn = col;
        pointFound = true;
      }
    }
    col++;
  }while(pointFound == false && col < piece.pieceWidth); 
  return leftmostColumn;
}


