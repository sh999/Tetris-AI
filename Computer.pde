class Computer {
  int a, b;
  int[][] field;
  Computer(int _a, int _b){
    a = _a; //Field dimensions
    b = _b;
  }
  
  // Obtains field info from the game, process, then 
  void respond(PieceType currentPiece, int[][] _field){
    field = _field;
    
    /*println("\n");
    for(int i = 0; i < a; i++){ // Temp equals row that is above current one
      for(int j = 0; j < b; j++){
        print(field[i][j]);
      }println();
    }*/
    
    computeMove();
    sendMove();       
  }// End Respond()
  
  void computeMove(){
    
    
  }
  
  void sendMove(){
    
  
  }



}
