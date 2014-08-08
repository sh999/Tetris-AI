class Computer {
  int a, b;
  int[][] field;
  PieceType piece;
  int clock;
  String movement;
  
  Computer(int _a, int _b, PieceType _piece){
    a = _a; //Field dimensions
    b = _b;
    piece = _piece;
    clock = 0; //How fast computer moves piece
    movement = "";
  }
  
  // Obtains field info from the game, process, then 
  void respond(int[][] _field){
    field = _field;
    computeMove();
    sendMove();
  }// End Respond()
  
  void computeMove(){
    int r = int(random(0,100));
    if(r > 75) movement = "right";
    else if(r < 75 && r > 50) movement = "left";
    else if(r < 50 && r > 25) { movement = "rotate right";}
    else if(r < 25 && r > 10) movement = "down";
    else movement = "drop";
  }
  
  void sendMove(){
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
   
  }// End sendMove()



}
