class Computer {
  int a, b;
  int[][] field;
  PieceType piece;
  int clock;
  String movement;
  int[][] pieceDesign;
  
  Computer(int a, int b, PieceType piece){
    this.a = a; //Field dimensions
    this.b = b;
    this.piece = piece;
    clock = 0; //How fast computer moves piece
    movement = "";
  }
  
  // Obtains field info from the game, process, then 
  void respond(int[][] _pieceDesign, int[][] _field){
    field = _field;
    pieceDesign = _pieceDesign;
    computeMove();
    sendMove();
  }// End Respond()
  

  void computeMove(){
//    randMovtCompute(); 
    findBestMoves();
  }
  
  void sendMove(){
//    randMovtSend();
  }
  
  void findBestMoves(){
    
  }
  
  void randMovtCompute(){
    int r = int(random(0,100));
    if(r > 75) movement = "right";
    else if(r < 75 && r > 50) movement = "left";
    else if(r < 50 && r > 25) { movement = "rotate right";}
    else if(r < 25 && r > 10) movement = "down";
    else movement = "drop";  
  }
   
  void randMovtSend(){
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
