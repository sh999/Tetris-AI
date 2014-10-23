class Computer {
  int a, b;
//  int[][] field;
  int clock;
  String movement;
  int[][] pieceDesign;
  int[][] imaginaryField;
  int dropPos = 5; // row where the lowest part of piece is when it is dropped
  int gapScore;

  Computer(int a, int b){
    this.a = a; //Field dimensions
    this.b = b;
    imaginaryField = new int[a][b];
    clock = 0; //How fast computer moves piece
    movement = "";
  }

  void getMove(PieceType piece, int[][] field){
    calcMove(piece, field);
    // Implement doMove()
    
  }
  
  void calcMove(PieceType piece, int[][] field){
    imaginaryDrop(piece, field); // Should return imaginary field
//    gapScore = getGapScore(piece, dropPos, field);
//    printArr(imaginaryField);

    // List of functions that calculate score
    // Eg, check game
    // calculate score of contour
    // Add score together
    // Once score is obtained, 
    // Each move should be captured in a coordinate
    
  } 
  
  void imaginaryDrop(PieceType piece, int[][] field){
    for(int i = 0; i < a; i++){
      for(int j = 0; j < b; j++){
        imaginaryField[i][j] = field[i][j];
      }
    }
    boolean droppable = true; //Assume piece can be dropped
    int phantomOriginY = piece.originY;
    int predictedOriginY = 0;
    int phantomOriginX = piece.originX;
    int FILLED_PERM = 2;
    int EMPTY = 0;
    int lineToCheck = 0;
    while(droppable == true){
      phantomOriginY = phantomOriginY + 1; 
      for(int i = 0; i < piece.pieceHeight; i++){
        for(int j = 0; j < piece.pieceWidth; j++){
          
          if(piece.pieceDesign[i][j] == 1 && i+phantomOriginY > a-1){ //prevents going out of bounds down
            droppable = false;
            dropPos = i+phantomOriginY;
          }
          else if(piece.pieceDesign[i][j] == 1 && field[i+phantomOriginY][j+phantomOriginX] == FILLED_PERM){  //Drops piece on top of existing ones
            droppable = false;  
            dropPos = i+phantomOriginY;
            
          }
          if(droppable == false){
              predictedOriginY = i + phantomOriginY - 5; //For loop doesn't break but checks to last row even after finding a piece before that can collide

          }
        }
      }//End fors
    }//End while
    
    imaginaryField = stampPiece(piece, phantomOriginX, predictedOriginY, imaginaryField);
    
  } //End calcMove()
  
  int[][] modifyIField(PieceType piece, int phantomOriginX, int predictedOriginY, int[][] imaginaryField){
    for(int i = 0; i < piece.pieceHeight; i++){
        for(int j = 0; j < piece.pieceWidth; j++){        
          /*if (pieceDesign[i][j] == 1 && field[i+predictedOriginY][j+phantomOriginX] == FILLED_PERM){
            stopPieceFromMoving = true;
            canGoDown = false;
            break;
          } */
        }  
      }
    return imaginaryField;
  }
  
  /*
  int getGapScore(PieceType piece, int dropPos, int[][] field){
    // Check for gap below piece if piece is dropped
    boolean gapFound = false;
    println("Lowest point = "+lowestRow(piece));
    println("Drop pos = "+dropPos);
    println("Leftmost point = "+leftmostColumn(piece));
    for(int j = 0; j < piece.pieceWidth; j++){
      if(dropPos < 29 && field[dropPos][j] == 1){
        gapFound = false; 
      }
      else if (dropPos < 29) gapFound = true;
    }
    println("Gap found? = "+gapFound+"\n\n");
    if (gapFound == true) { return 1;}
    else {return 0;}
    
    
  }
  int getGapScore(PieceType piece, int dropPos, int[][] field){
    tempOriginX = originX;
    tempOriginY = originY+1;
      //Checks if there are already fallen pieces below the falling piece 
    if (canGoDown == true){
      for(int i = 0; i < pieceHeight; i++){
        for(int j = 0; j < pieceWidth; j++){        
          if (pieceDesign[i][j] == 1 && field[i+tempOriginY][j+tempOriginX] == FILLED_PERM){
            stopPieceFromMoving = true;
            canGoDown = false;
            break;
          } 
        }  
      }
    }
  }*/

  
  int[][] stampPiece(PieceType piece, int x, int y, int[][] ifield){ //Sets imaginary field to where the piece should land
    boolean gapPresent = false;
    for(int i = 0; i < piece.pieceHeight; i++){
      for(int j = 0; j < piece.pieceWidth; j++){
        if(piece.pieceDesign[i][j] == 1){
          ifield[i+y][j+x] = 5;  // Shows ghost piece where the piece will drop
          if(i+y < 28){
            ifield[i+y+1][j+x] = 3;  //'3' indicates the boxes that need to be checked for field status later (if there is a gap)
          }  
        }
        else if(piece.pieceDesign[i][j] == 0){
          //do nothing
        } 
      }
    }
    for(int i = 0; i < a; i++){
      for(int j = 0; j < b; j++){
        if(ifield[i][j] == 3 && field[i][j] == 0){ //If the spots to be checked have gaps...
          gapPresent = true;
        }
      }
    }
    if(gapPresent  == true) {print("There's a gap");}
    
    printArr(ifield);
    return ifield;
    
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
  
  
}
