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
    calcMove(piece, field);

//    randMovtCompute(); 
//    randMovtSend(piece);
  }
  
  void calcMove(PieceType piece, int[][] field){
    int[][] imaginaryField = field;
//    imaginaryField = phantomDrop(imaginaryField);
//    printArr(imaginaryField);
      //Drop phantom piece down until it hits something
    boolean droppable = true; //Assume piece can be dropped
    int phantomOriginY = piece.originY;
    int phantomOriginX = piece.originX;
    int FILLED_PERM = 2;
    while(droppable == true){
      phantomOriginY = phantomOriginY + 1;
      //check if there is overlap between field and pieceDesign
      //Iterate over pieceDesign
      for(int i = 0; i < piece.pieceHeight; i++){
        for(int j = 0; j < piece.pieceWidth; j++){
          if(piece.pieceDesign[i][j] == 1 && i+phantomOriginY > a-1){ //prevents going out of bounds down
            droppable = false;
          }
          else if(piece.pieceDesign[i][j] == 1 && field[i+phantomOriginY][j+phantomOriginX] == FILLED_PERM){  //Drops piece on top of existing ones
            droppable = false;  
          }
          if(droppable == false){
            print("phantomOrigY = "+phantomOriginY);
            imaginaryField = stampPiece(piece, phantomOriginX, i+phantomOriginY-5, imaginaryField); 
//            originY = i+phantomOriginY-5;
          }
        }
      }//End fors
    }
    printArr(imaginaryField);
  } //End calcMove()
  
  int[][] stampPiece(PieceType piece, int x, int y, int[][] field){
    for(int i = 0; i < piece.pieceHeight; i++){
      for(int j = 0; j < piece.pieceWidth; j++){
        if(piece.pieceDesign[i][j] == 1){
          
          field[i+y][j+x] = 5;//where matching occurs
        }
        else if(piece.pieceDesign[i][j] == 0){
           //do nothing
        }  
      }
    }
    return field;
    
  } // End stampPiece();
    
  int[][] phantomDrop(int[][] field){
    return field;  
  } // End phantomDrop()
  
  
  void randMovtCompute(){
    int r = int(random(0,100));
    if(r > 75) movement = "right";
    else if(r < 75 && r > 50) movement = "left";
    else if(r < 50 && r > 25) { movement = "rotate right";}
    else if(r < 25 && r > 10) movement = "down";
    else movement = "drop";
    println("\n");
  }// End randMovtCompute
   
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
  
  void printArr(int[][] array){
    for(int i = 0; i < array.length; i++){
      for(int j = 0; j < array[0].length; j++){
        print(array[i][j]);
      }println();
    }println("\n");
  }
}
