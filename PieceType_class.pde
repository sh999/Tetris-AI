///////////////////////Begin PieceType Class////////////////////
/*
Functions:r
  display
  userInput
  updateArray
  
Notes:
Check if where piece will go/rotate will have clash with another piece/wall. 
  If so, can't move there.
*/
class PieceType {
  int check = 0;
  int EMPTY = 0;
  int FILLED_TEMP = 1;
  int FILLED_PERM = 2;
  boolean checkLeft = true;
  boolean checkDown = true;
  boolean checkRight = true;

  
  String pieceName;
  int[][] pieceDesign;
  int originX = 2; //Origins = where pieces start falling
  int originY = 1;
  int blockSize = 20; //Pixelsize of svg object  
  int pieceHeight;
  int pieceWidth;
  float rect_width;
  float rect_height;
  String svgFileURL;
  int bottomBound = height-blockSize*2; //bottom of gameplay
  PShape nonEmptySpace, emptySpace;
  float clock = 0;
  int[][] temporaryPieceDesign;
  int tempOriginX, tempOriginY;
  boolean canGoDown = true;
  boolean stopPieceFromMoving = false;
  boolean colorFallenPieces = false;
  PShape blah = loadShape("Iblock.svg");
  PShape Iblock, squareblock, Tblock, Sblock, Zblock, Lblock, Jblock;
  boolean canGoLeft = true;
  boolean canGoRight = true;
  

  PieceType(String pieceName_, int[][] pieceDesign_, String svgFileURL_) {
    pieceName = pieceName_;
    svgFileURL = svgFileURL_;
    pieceDesign = pieceDesign_;
    pieceHeight = pieceDesign.length;
    pieceWidth = pieceDesign[0].length;
    temporaryPieceDesign = pieceDesign;
    for(int i = 0; i < a; i++){
      for(int j = 0; j < b; j++){
        fieldColor[i][j] = loadShape("blank.svg");
      }
    }
    Iblock = loadShape("Iblock.svg");
    squareblock = loadShape("squareblock.svg");
    Tblock = loadShape("Tblock.svg");
    Sblock = loadShape("Sblock.svg");
    Zblock = loadShape("Zblock.svg");
    Lblock = loadShape("Lblock.svg");
    Jblock = loadShape("Jblock.svg");
    
  }
  
  //Controls how the program methods flow
  void display() {
    initialize();
    clearSpace();
    matchField();
    checkAllowableMoves();
    if (stopPieceFromMoving == true){
      make_piece_permanent();//Piece will stop and change field permanently
    }
    
    drawField();
    //color_fallen_pieces();
    
    
    if (canGoDown == false) {
      resetPiece(); 
    }
    dropSlowly();
    
    
  }//End voidDisplay()
  
  
  void initialize(){
    rect_width = 200; 
    rect_height = 500;
    nonEmptySpace = loadShape(svgFileURL);
    emptySpace = loadShape("blank.svg");
    stroke(255);
  }//end initialize()
  
  //Clear space-clears space where piece is moving but leaves filled field intact
  void clearSpace(){
    for(int i = 0; i < a; i++){
      for(int j = 0; j < b; j++){
        if(field[i][j] != FILLED_PERM){
          field[i][j] = EMPTY;
        }
      }
    }
  }//end clearSpace()
  
  //Match field- //match field with piece information.  Wherever piece is, that location will be "marked on the field"
  void matchField(){
    
    for(int i = 0; i < pieceHeight; i++){
      for(int j = 0; j < pieceWidth; j++){
        x = j*gridSize+width/2-(gridSize*b/2); //x and y are grid locations
        y = i*gridSize+height/2-(gridSize*a/2); 
        if(pieceDesign[i][j] == 1){
          field[i+originY][j+originX] = pieceDesign[i][j];//where matching occurs
        }
        else if(pieceDesign[i][j] == 0){
           //do nothing         
        }
      }
    }  
  }//End matchField()
  
  void checkAllowableMoves(){
    int originXIfPieceGoesLeft = originX - 1;
    int originXIfPieceGoesRight = originX + 1;
    int originYIfPieceGoesDown = originY + 1;
    boolean keepLooping = true;
   
    println("\n\n");
    
    checkLeft = true;
    checkRight = true;
    test:
      for(int i = 0; i < pieceHeight; i++){
        println();
        for(int j = 0; j < pieceWidth; j++){ 
    
          //print("piece design = ", pieceDesign[i][j]);
          //print("("+j+","+originX+")");
          
          if (pieceDesign[i][j] == 1 && j + originX == 0 &&  checkLeft == true){
            //print("ifCalled ");
            canGoLeft = false;
            checkLeft = false;
          } 
          else if(pieceDesign[i][j] == 0 && j + originX == 0 &&  checkLeft == true){
            //print("elseCalled ");
            canGoLeft = true;
          }
          //else print("noneCalled");
          if (pieceDesign[i][j] == 1 && j + originX == 9 && checkRight == true){
            canGoRight = false;
            checkRight = false;
            //break test;
          } 
          else if(pieceDesign[i][j] == 0 && j + originX == 9 && checkRight == true) {
            //canGoRight = true;
            canGoRight = true;
          }
          if (pieceDesign[i][j] == 1 && i + originY > 15){
            
            canGoDown = false;
            stopPieceFromMoving = true;
            println("***************************************** HIT BOTTOM ************************");
            break test;
          } 
          else{
            canGoDown = true;
          }
        }  
      
      }//end "test" loop
    tempOriginX = originX;
    tempOriginY = originY+1;
    
    //Checks if there are already fallen pieces below the falling piece (collision detection)
    /*if (canGoDown == true){
      for(int i = 0; i < pieceHeight; i++){
        for(int j = 0; j < pieceWidth; j++){        
          if (pieceDesign[i][j] == 1 && field[i+tempOriginY][j+tempOriginX] == FILLED_PERM){
            stopPieceFromMoving = true;
            canGoDown = false;
            println("check = "+check+" down");
            break;
          } 
        }  
      }
    }*/
    
    //Check floor
    if (originY>133) {
      canGoDown = false;
    }
  }
  //End CheckAllowableMoves()
  
  
  //Called when a piece has fallen and another random one has to appear on top
  void resetPiece(){
      
      int randompiece = int(random(1, 8));
      if (randompiece==1) {
        pieceDesign = L_pieceDesign;
        pieceName = "L block";
        svgFileURL = "Lblock.svg";
      }
      else if (randompiece==2) {
        pieceDesign = J_pieceDesign;
        pieceName = "J block";
        svgFileURL = "Jblock.svg";
      }
      else if (randompiece==3) {
        pieceDesign = S_pieceDesign;
        pieceName = "S block";
        svgFileURL = "Sblock.svg";
      }
      else if (randompiece==4) {
        pieceDesign = Z_pieceDesign;
        pieceName = "Z block";
        svgFileURL = "Zblock.svg";
      }
      else if (randompiece==5) {
        pieceDesign = square_pieceDesign;
        pieceName = "square block";
        svgFileURL = "squareblock.svg";
      }
      else if (randompiece==6) {
        pieceDesign = T_pieceDesign;
        pieceName = "T block";
        svgFileURL = "Tblock.svg";
      }
      else if (randompiece==7) {
        pieceDesign = I_pieceDesign;
        pieceName = "I block";
        svgFileURL = "Iblock.svg";
      }
      originY = 1;
      originX = 2;
      rotation_status = 1;
      canGoDown = true;
      stopPieceFromMoving = false;
      canGoRight = true;
  }
  
  //Draw Field- Based on the value of the field element, draw a block (empty space, space occupied by piece have diff. colors
    void drawField(){
    for(int i = 0; i < a; i++){
      for(int j = 0; j < b; j++){
        x = j*gridSize+width/2-(gridSize*b/2); //x and y are grid locations
        y = i*gridSize+height/2-(gridSize*a/2); 
        
        if(field[i][j] == EMPTY){ //Where there is no piece, have block
          shape(emptySpace, x, y, blockSize, blockSize);
          
        }
        else if(field[i][j] == FILLED_TEMP){ //moving piece
          shape(nonEmptySpace, x, y, blockSize, blockSize); 
        }//Draw filled block
        else if(field[i][j] == FILLED_PERM){ //empty field
          shape(fieldColor[i][j], x, y, blockSize, blockSize);
        }
       stroke(100);
       noFill();
        rect(x, y, blockSize, blockSize); 
      }  
    }  
  }  
  
  void dropSlowly(){
    //Drop piece slowly  
    if (clock == 100) {
      //Check for collision here?
      originY = originY+1;
      clock = 0;
    }
    else clock++;

    //Reset piece
    //When piece reaches bottom, let another random piece fall from top  
  }
  
  
  
  
  
  void make_piece_permanent(){//Called when piece is supposed to be fixed on field
    for(int i = 0; i < pieceHeight; i++){
      for(int j = 0; j < pieceWidth; j++){
        if(pieceDesign[i][j] == 1){
           
          field[i+originY][j+originX] = FILLED_PERM;
          if(svgFileURL == "Iblock.svg"){ //fieldColor holds shape depending on which piece has just fallen
            fieldColor[i+originY][j+originX] = Iblock;
          }
          else if(svgFileURL == "Tblock.svg"){
            fieldColor[i+originY][j+originX] = Tblock;
          }
          else if(svgFileURL == "Tblock.svg"){
            fieldColor[i+originY][j+originX] = Tblock;
          }
          else if(svgFileURL == "Sblock.svg"){
            fieldColor[i+originY][j+originX] = Sblock;
          }
          else if(svgFileURL == "Zblock.svg"){
            fieldColor[i+originY][j+originX] = Zblock;
          }
          else if(svgFileURL == "Lblock.svg"){
            fieldColor[i+originY][j+originX] = Lblock;
          }
          else if(svgFileURL == "Jblock.svg"){
            fieldColor[i+originY][j+originX] = Jblock;
          }
          else if(svgFileURL == "squareblock.svg"){
            fieldColor[i+originY][j+originX] = squareblock;
          }
        }
      }
    }
      
  }//End make piece permanent()
  
  /*void color_fallen_pieces(){
     
    for(int i = 0; i < a; i++){
      for(int j = 0; j < b; j++){
        x = j*gridSize+width/2-(gridSize*b/2); //x and y are grid locations
        y = i*gridSize+height/2-(gridSize*a/2);
        if(field[i][j] == FILLED_PERM){
          if(fieldColor[i][j] == "Iblock"){
            shape(Iblock, x, y, blockSize, blockSize);  
          }
        }
      }
    }
    
  }*/
  
  //Decide what happens when the user presses a button
  void userInput() {
    switch(keyCode) {
    case UP:
      if (rotation_status == 4) rotation_status = 1;
      else rotation_status = rotation_status + 1;
      break; 
    case 'X':
      if (rotation_status == 4) rotation_status = 1;
      else rotation_status = rotation_status + 1;
      break;
    case LEFT:
      if(canGoLeft == true) originX = originX-1;
      break;
    case DOWN:
      if(canGoDown == true) originY = originY+1;
      break;
    case RIGHT:
      if(canGoRight == true) originX = originX+1;
      break;
    case 'Z':
      if (rotation_status == 1) rotation_status = 4;
      else rotation_status = rotation_status - 1;

      break;  
      default:;
    }//switch
    pieceDesign = updateArray(rotation_status);
    /*for(int i = 0; i < pieceHeight; i++){//print array in console
      for(int j = 0; j < pieceWidth; j++){
        print(pieceDesign[i][j]);
      }
      println();
    }*/
  }//userInput
  
  int[][] updateArray(int rotation_status) { //Has information for piece rotation
    int[][] newArray = new int[5][5];
    if (pieceName == "L block") {
      switch(rotation_status) {
      case 1: 
        newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 1, 0},
          {0, 0, 0, 0, 0},
          
        }; 
        break;
      case 2:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 0}, 
          {0, 1, 0, 0, 0},
          {0, 0, 0, 0, 0}}; 
        break;
      case 3:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 1, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      case 4:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 1, 0}, 
          {0, 1, 1, 1, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      }
    }//L piece
    else if (pieceName == "J block") {
      switch(rotation_status) {
      case 1: 
        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0},
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      case 2:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 1, 0, 0, 0}, 
          {0, 1, 1, 1, 0}, 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0}
        }; 
        break;
      case 3:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 1, 0}, 
          {0, 0, 1, 0, 0},
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        };
        break;
      case 4:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 0},
          {0, 0, 0, 1, 0}, 
          {0, 0, 0, 0, 0}
        };
       
        break;
      }
    }//J piece
    else if (pieceName == "Z block") {
      switch(rotation_status) {
      case 1:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 1, 1, 0, 0}, 
          {0, 0, 1, 1, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 2:
        newArray = new int[][] { 
            {0, 0, 0, 0, 0},
            {0, 0, 0, 1, 0}, 
            {0, 0, 1, 1, 0}, 
            {0, 0, 1, 0, 0}, 
            {0, 0, 0, 0, 0}
        }; 
        break;
      case 3:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 1, 1, 0, 0}, 
          {0, 0, 1, 1, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
       
      case 4:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 1, 0}, 
          {0, 0, 1, 1, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      }
    }//Z piece
    else if (pieceName == "S block") {
      switch(rotation_status) {
      case 1: 

        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 1, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 2:
       newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 1, 0}, 
          {0, 0, 0, 1, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 3: 
      newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 1, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 4:
      newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 1, 0}, 
          {0, 0, 0, 1, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
       
      }
    }//S piece
    else if (pieceName == "T block") {
      switch(rotation_status) {
      case 1: 
        newArray = new int[][] { 
          { 0, 0, 0, 0, 0}, 
          { 0, 0, 1, 0, 0}, 
          { 0, 1, 1, 1, 0}, 
          { 0, 0, 0, 0, 0}, 
          { 0, 0, 0, 0, 0}
        }; 
        break;
      case 2:
        newArray = new int[][] { 
          { 0, 0, 0, 0, 0}, 
          { 0, 0, 1, 0, 0}, 
          { 0, 0, 1, 1, 0}, 
          { 0, 0, 1, 0, 0}, 
          { 0, 0, 0, 0, 0}
        }; 
        break;
      case 3:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      case 4:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      }
    }//T piece
    else if (pieceName == "I block") {
      switch(rotation_status) {
      case 1:
        newArray = new int[][] { 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;  
      case 2:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 1}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      case 3:
        newArray = new int[][] { 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 4:
         newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 1}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      }
    }//I piece
    if (pieceName == "square block") {
      switch(rotation_status) {
      case 1:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;  
      case 2:
         newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      case 3:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 4:
         newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      }
    }//Square piece
    /*newArray = new int[][]{ 
          {0, 0, 1, 1, 1}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 1, 0},
          {0, 0, 0, 0, 0},
          
        };*/
    return newArray;
  }//updatearray
}/////////////////////////////End PieceType Class////////////////

