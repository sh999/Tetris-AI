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
  int TOBECLEARED = 3;
  boolean checkLeft = true;
  boolean checkDown = true;
  boolean checkRight = true;
  int[] lineStatus = new int[a];
  int UNDETERMINED = 0;
  int INCOMPLETE = -1;
  int COMPLETE = 1;
  boolean tetris = false;
  int[][] tempField = new int[a][b];
  PShape[][] tempFieldColor = new PShape[a][b];
  
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
      //checkTetris();
    }
    if (canGoDown == false) {
      resetPiece(); 
    }
    checkTetris();
    if (tetris == true){
      //clearLines();
      //tetris = false;
    }
    drawField();  
    dropSlowly();
  }//End voidDisplay()
/* Here is the flow before I messed with it
initialize();
    clearSpace();
    matchField();
    checkAllowableMoves();
    if (stopPieceFromMoving == true){
      make_piece_permanent();//Piece will stop and change field permanently
      checkTetris();
    }
    if (canGoDown == false) {
      resetPiece(); 
    }
    dropSlowly();
    checkTetris();
    if (tetris == true){
      clearLines();
      tetris = false;
    }
    drawField();
*/


  
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
   
    
    checkLeft = true;
    checkRight = true;    
    test:
      for(int i = 0; i < pieceHeight; i++){
        for(int j = 0; j < pieceWidth; j++){           
          if ((pieceDesign[i][j] == 1 && j + originX == 0) ||
              (pieceDesign[i][j] == 1 && field[i+originY][j+originX-1] == FILLED_PERM) &&
              checkLeft == true){
            canGoLeft = false;
            checkLeft = false;
          } 
          else if(pieceDesign[i][j] == 1 && j + originX != 0 &&  checkLeft == true){
            canGoLeft = true;
            
          }
          else {

          } 
          
          if ((pieceDesign[i][j] == 1 && j + originX == 9) || 
              (pieceDesign[i][j] == 1 && field[i+originY][j+originX+1] == FILLED_PERM) &&
              checkRight == true){
            canGoRight = false; 
            checkRight = false;
          } 
          else if(pieceDesign[i][j] == 1 && j + originX != 9 &&  checkRight == true){
            canGoRight = true;
          }         
          if (pieceDesign[i][j] == 1 && i + originY > 23){
            canGoDown = false;
            stopPieceFromMoving = true;
            break test;
          } 
          else{
            canGoDown = true;
          }
        }//end inner loop j  
      }//end "test" loop
    tempOriginX = originX;
    tempOriginY = originY+1;
    
    //Checks if there are already fallen pieces below the falling piece (collision detection)
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
  }
  
  // Check if there is a completed line (tetris) and clear line if there is.
  void checkTetris(){
    //works by checking every line in field of play 
    //every line is checked the row is complete.  If not, lineStatus[row] = incomplete
    //every time function is called, status is changed to default which lets the changing to complete possible
    //Can make a better algorithm which checks only the rows that the piece is traveling through, 
    //But it can be more complicated.  Possibly make this in the future.
    for(int i = 0; i < a; i++){
      lineStatus[i] = UNDETERMINED; 
    }
    for(int row = 0; row < a; row++){ //Go from top row to bottom
        int col = 0;
        boolean continueCheckingRight = true;
        do{
          if(field[row][col] == FILLED_PERM){
            continueCheckingRight = true;
            if(col == 9){
              continueCheckingRight = false;
              lineStatus[row] = COMPLETE;
              clearLines();
              tetris = true;
            }
          } 
          else if(field[row][col] == EMPTY){
            continueCheckingRight = false;
            lineStatus[row] = INCOMPLETE;
          }
           
          col = col + 1;  
        }while(continueCheckingRight);
    }
      
  }//end checkTetris()

// If lineStatus[row] == complete, clear that row and bring pieces above below.
void clearLines(){
  //int[][] tempField = field;
  print("clearlines ");
  for(int i = 0; i < a; i++){
    for(int j = 0; j < b; j++){
      
      tempField[i][j] = field[i][j];
      tempFieldColor[i][j] = fieldColor[i][j];
    }
  }
  
  for(int i = 1; i < a; i++){
    for(int j = 0; j < b; j++){
      tempField[i][j] = field[i-1][j];
      tempFieldColor[i][j] = fieldColor[i-1][j];
    }
  }
  for(int i = 0; i < a; i++){
    for(int j = 0; j < b; j++){
      
      field[i][j] = tempField[i][j];
      fieldColor[i][j] = tempFieldColor[i][j];
      
    }
  }
  for(int row = 0; row < a; row++){
    lineStatus[row] = INCOMPLETE;
  }
  tetris = false;
}//End clearLines()

  
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
  
  //Decide what happens when the user presses a button
  void userInput() {
    switch(keyCode) {
    case UP:
      checkValidRotation();
      /*
      if (rotation_status == 4) rotation_status = 1;
      else rotation_status = rotation_status + 1;
      */
      break; 
    case 'X': //Clockwise turn
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
    
    default:
      if(key == 'v'){
          instantDrop();
          
      }
      else if(key == 'f'){
        clearLines();
      }
      break;
        
    }//switch
    pieceDesign = updateArray(rotation_status);    
  }//end userInput
  
  void checkValidRotation(){
    
    int phantom_rotation_status = rotation_status;
    int[][] phantom_pieceDesign = pieceDesign;
    boolean canRotate = true;
    
    if (phantom_rotation_status == 4) phantom_rotation_status = 1;
    else phantom_rotation_status = phantom_rotation_status + 1;
    phantom_pieceDesign = updateArray(phantom_rotation_status);
    rotate:
    for(int i = 0; i < pieceHeight; i++){
        for(int j = 0; j < pieceWidth; j++){
          if(phantom_pieceDesign[i][j] == 1 && j+originX > 9){ //right wall rotation check
            canRotate = false;
            break rotate;
          }
          if(phantom_pieceDesign[i][j] == 1 && j+originX < 0){ //left wall rotation check
            canRotate = false;
            break rotate;
          }
          if(phantom_pieceDesign[i][j] == 1 && field[i+originY][j+originX] == FILLED_PERM){
            canRotate = false;
            break rotate;
          }
        }
    }
    
    if(canRotate == true){
      if (rotation_status == 4) rotation_status = 1;
      else rotation_status = rotation_status + 1;  
    }
    
    
  }
  
  void instantDrop(){
    //Drop phantom piece down until it hits something
    boolean droppable = true; //Assume piece can be dropped
    int phantomOriginY = originY;
    int phantomOriginX = originX;
    while(droppable == true){
      phantomOriginY = phantomOriginY + 1;
      //check if there is overlap between field and pieceDesign
      //Iterate over pieceDesign
      for(int i = 0; i < pieceHeight; i++){
        for(int j = 0; j < pieceWidth; j++){
          
          if(pieceDesign[i][j] == 1 && i+phantomOriginY > 24){ //prevents going out of bounds down
            droppable = false;
          }
          else if(pieceDesign[i][j] == 1 && field[i+phantomOriginY][j+phantomOriginX] == FILLED_PERM){  //Drops piece on top of existing ones
            droppable = false;  
          }
          if(droppable == false){
            originY = i+phantomOriginY-5;
          }
          
        }
      }

        
      
      
    }

  }
  
  
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

