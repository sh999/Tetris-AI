void phantomDrop(){
  
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
//    for(int i = piece.pieceHeight-1; i >= 0; i--){
      int i = piece.pieceHeight-1; 
      do{
        for(int j = 0; j < piece.pieceWidth; j++){
//          println(" i = "+i+", j = "+j);
          if(piece.pieceDesign[i][j] == 1){
            lowestRow = i;
            pointFound = true;
          }
        }
        i--;
      }while(pointFound == false && i >= 0);
    
  
  
  return lowestRow;
  
}



