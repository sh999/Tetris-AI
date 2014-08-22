class Computer {
  int a, b;
  int[][] field;
  int clock;
  String movement;
  int[][] pieceDesign;
  
  Computer(int a, int b){
    this.a = a; //Field dimensions
    this.b = b;
    clock = 0; //How fast computer moves piece
    movement = "";
  }
  /*
  // Obtains field info from the game, process, then 
  void respond(int[][] _pieceDesign, int[][] _field){
    field = _field;
    pieceDesign = _pieceDesign;
    computeMove();
    sendMove();
  }// End Respond()*/
  

  void getMove(PieceType piece, int[][] field){
//    randMovtCompute(); 
//    randMovtSend(piece);
    getBestMove(piece, field)
  }
  
  void getBestMove(Piece piece, int[][] field){
    // Find left-most part of piece (leftX)
    
    
    int originXIfPieceGoesLeft = piece.originX - 1;
    boolean keepLooping = true;
    boolean checkLeft = true;
    boolean canGoleft;
    while(canGoleft == true){
      for(int i = 0; i < piece.pieceHeight; i++){
        for(int j = 0; j < piece.pieceWidth; j++){           
          // Check collision to left wall
          if ((piece.pieceDesign[i][j] == 1 && j + piece.originX == 0) ||
              (piece.pieceDesign[i][j] == 1 && field[i+piece.originY][j+piece.originX-1] == FILLED_PERM) &&
              checkLeft == true){
            canGoLeft = false;
            checkLeft = false; 
          } 
          else if(pieceDesign[i][j] == 1 && j + originX != 0 &&  checkLeft == true){
            canGoLeft = true;
            
          }
        }
      }
    } // End While
    // Iterate Piece in field from left edge (leftX) to right edge
    for(int i = 0; i < b; i++){
      
    }
      // Perform imaginary drop
      // See if drop creates a hole.  If it does, don't make that move
      // If drop doesn't create a hole, store the move coordinate.  Calculate "score"
    // Get the best "scored" move.  Make that move
      
  }
  
  void randMovtCompute(){
    int r = int(random(0,100));
    if(r > 75) movement = "right";
    else if(r < 75 && r > 50) movement = "left";
    else if(r < 50 && r > 25) { movement = "rotate right";}
    else if(r < 25 && r > 10) movement = "down";
    else movement = "drop";
    println("\n");
  }
   
  void randMovtSend(PieceType piece){
    print(movement);
    if (clock == 20){
      if(movement == "left"){
        piece.moveLeft();
      }
      else if(movement == "right"){
        piece.moveRight();
      }
      else if(movement == "down"){
        piece.moveDown();
      }
      else if(movement == "drop"){
        piece.instantDrop();
      }
      else if(movement == "rotate right"){
        piece.pieceRotate("clockwise");
      }
      else if(movement == "rotate left"){
        piece.pieceRotate("clockwise");
      }
      else if(movement == "nothing"){
      }
      clock = 0;
    }
    clock = clock + 1;
  }// End randMovtSend()
}
