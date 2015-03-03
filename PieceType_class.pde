class PieceType {
  boolean topWasHit = false;
  int linesToClear = 0; 
  boolean canSetHighScore = true;
  int check = 0; //unused?
  int EMPTY = 0;
  int FILLED_TEMP = 1; //Status of field cells
  int FILLED_PERM = 2;
  int TOBECLEARED = 3;
  boolean checkLeft = true; //Collision detection
  boolean checkDown = true;
  boolean checkRight = true;
  boolean canGoLeft = true;
  boolean canGoRight = true;
  int[] lineStatus = new int[a];  //Tetris detection
  int UNDETERMINED = 0;
  int INCOMPLETE = -1;
  int COMPLETE = 1;
  boolean tetris = false;
  int[][] tempField = new int[a][b];
  PShape[][] tempFieldColor = new PShape[a][b];
  String pieceName;
  int[][] pieceDesign;
  int[][] nextPieceDesign;
  int originX = 3; //Origins = where pieces start falling
  int originY = 1;
  int blockSize = 20; //Pixelsize of svg object  
  int pieceHeight;
  int pieceWidth;
  String svgFileURL;
  PShape nonEmptySpace, emptySpace;
  float clock = 0;
  int[][] temporaryPieceDesign;
  int tempOriginX, tempOriginY;
  boolean canGoDown = true;
  boolean colorFallenPieces = false;
  PShape Iblock, squareblock, Tblock, Sblock, Zblock, Lblock, Jblock, thisBlock;
  int slowDropPoints;
  int gameStatus;
  int PLAYING = 1;
  int GAMEOVER = 0;

  PieceType(String pieceName, int[][] pieceDesign, String svgFileURL) {
    gameStatus = PLAYING; 
    this.pieceName = pieceName;
    this.svgFileURL = svgFileURL;
    this.pieceDesign = pieceDesign;
    pieceHeight = pieceDesign.length;
    pieceWidth = pieceDesign[0].length;
    temporaryPieceDesign = pieceDesign;
    slowDropPoints = 30;
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
    thisBlock = loadShape(svgFileURL);
    emptySpace = loadShape("blank.svg");
    resetPiece();
    nonEmptySpace = loadShape(svgFileURL);
  }
  
  void incrLevel(){
    dropSpeed = 10;
  }
  
  //Controls how the program methods flow
  //Annotation:  Suggested placement of method in class
  //F = Field class.  P = Piece class.  I = "Interactor" class-Deals with piece-field interaction
  //PB = Piece behavior class?
  void runPiece() {
    if(gameStatus == PLAYING){
      clearSpace(); //F Allows "movement" by clearing transitive blocks
      matchField(); //F Matches pieceDesign with field (if pd = 1, field = 1)
      checkAllowableMoves(); //I Has collision detection algorithm.  Restricts illegal movements that result in collisions
      if(canGoDown == false){
        make_piece_permanent(); //I-Piece will stop and change field permanently; allows for proper coloring of fallen blocks 
        checkTetris(); //I- Sets lineStatus to complete where there should be tetris
        if(linesToClear > 0){
          updateScore((linesToClear+1)*slowDropPoints);
        }
        else{
          updateScore(slowDropPoints);
        }
        multiClear(); //I- Calls processField which actually does the line clearing
        /*if(isGameOver() == true){
          gameStatus = GAMEOVER;
        }*/
        resetPiece(); // Sets next piece to random.  Sets position, rotation, etc.
      } 
      else{
      }
      /*
      if (canGoDown == false) {  
        if(isGameOver() == true){
          gameStatus = GAMEOVER;
        }
        resetPiece(); // Sets next piece to random.  Sets position, rotation, etc.
      }*/
      if(gameStatus != GAMEOVER){  
        drawField(); //F- Draw field based on color and filled status
        dropSlowly(); // Slow drop depends on clock and dropSpeed (set by level)
      }
    }
    if(gameStatus == GAMEOVER && canSetHighScore == true){
      checkHighScore();
//      endGame();
      canSetHighScore = false;
    }
  }// End voidDisplay()
  
  // Clears space where piece is moving but leaves filled field intact
  void clearSpace(){
    for(int i = 0; i < a; i++){
      for(int j = 0; j < b; j++){
        if(field[i][j] != FILLED_PERM){
          field[i][j] = EMPTY;
        }
      }
    }
  }// End clearSpace()
  
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
      // Wall collision detection
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
          if (pieceDesign[i][j] == 1 && i + originY > a-2){
            canGoDown = false;
            break test;
          } 
          else{
            canGoDown = true;
          }
        }//end inner loop j  
      }//end "test" loop
    tempOriginX = originX;
    tempOriginY = originY+1;
    //Checks if there are already fallen pieces below the falling piece 
    if (canGoDown == true){
      for(int i = 0; i < pieceHeight; i++){
        for(int j = 0; j < pieceWidth; j++){        
          if (pieceDesign[i][j] == 1 && field[i+tempOriginY][j+tempOriginX] == FILLED_PERM){
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
      setToNextPiece();

      int topY = topY();
      int dropPosY = getDropPositionY();
      int desiredOriginY = 15; // Where top of piece should start dropping
      originY = desiredOriginY - topY; // Ensures piece starts dropping right below top of screen taking to account that top of array is not necessarily top of piece
      println("pieceName = "+pieceName+". topY = "+topY+".  dropPosY = "+dropPosY+".  originY = "+originY);
      /*
      iterate:
      for(int i = 0; i < pieceHeight; i++){
        for(int j = 0; j < pieceWidth; j++){
          if(pieceDesign[i][j] == 1 && field[i+originY][j+originX] == FILLED_PERM){
            topWasHit = true;
            originY = 1;
            break iterate;
            // gameStatus = GAMEOVER;  
          }
        }
      }*/

      /*
      for(int i = 0; i < pieceHeight; i++){
        for(int j = 0; j < pieceWidth; j++){  
          if(pieceDesign[i][j] == 1 && i + dropPosY < 10){
            originY = dropPosY;
            gameStatus = GAMEOVER;
          }
        }
      }*/
      rotation_status = 1;
      canGoDown = true;
  }
  
  int topY(){
    int i, j, topY;
    topY = 0;
    i = 0;
    j = 0;
    boolean searchTop = true;
    while(i < pieceHeight && searchTop == true){
      while(j < pieceWidth && searchTop == true){
        if(pieceDesign[i][j] == 1){
          topY = i;    
          searchTop = false;
        }
        j = j + 1;
      } 
      j = 0;
      i = i + 1;
    }
    return topY;
  }
  
  // Check if there is a completed line (tetris) and clear line if there is.
  void checkTetris(){
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
              linesToClear += 1;
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

void multiClear(){ //Testing if multiple tetris works
  for(int i = 0; i < a; i++){
    if(lineStatus[i] == COMPLETE){
      field = processField(field, i);
      fieldColor = processFieldColor(fieldColor, i);
    }
  }
  
}//End multiClear()

// Processes field for clearing lines
int[][] processField(int[][] _field, int lineToClear){ 
  int[][] temp = new int[a][b];
  for(int i = 0; i < a; i++){ // Temp equals row that is above current one
    for(int j = 0; j < b; j++){
      temp[i][j] = _field[i][j];
    }
  }
  for(int i = 1; i < lineToClear+1; i++){ // Temp equals row that is above current one
      for(int j = 0; j < b; j++){
        temp[i][j] = _field[i-1][j];
      }
  }
  linesToClear = 0;
  return temp;
  
}//End processField
PShape[][] processFieldColor(PShape[][] _field, int lineToClear){
  PShape[][] temp = new PShape[a][b];
  for(int i = 0; i < a; i++){ // Temp equals row that is above current one
    for(int j = 0; j < b; j++){
      temp[i][j] = _field[i][j];
    }
  }
  for(int i = 1; i < lineToClear+1; i++){ // Temp equals row that is above current one
      for(int j = 0; j < b; j++){
        temp[i][j] = _field[i-1][j];
      }
  }
  return temp;
}//End processFieldColor
  
  //Draw Field- Based on the value of the field element, draw a block (empty space, space occupied by piece have diff. colors
    void drawField(){
      rectMode(CORNER);
      stroke(0);
      if(topWasHit == true){
        topWasHit = false;
      }

      // originY = 1;
//      int fieldOffsetX = width/2-(gridSize*b/2)-100;
//      int fieldOffsetY = height/2-(gridSize*a/2)-50;
      int fieldOffsetX = 40;
      int fieldOffsetY = -40;
      for(int i = 4; i < a; i++){ //  Field has rows of indices 4-28 (row[0] to row[3] are hidden for gameplay purpose)
        for(int j = 0; j < b; j++){
          x = j * gridSize + fieldOffsetX; // grid locations
          y = i * gridSize + fieldOffsetY;
          fill(255);
          if(field[i][j] == EMPTY){ //Where there is no piece, have block
            shape(emptySpace, x, y, blockSize, blockSize);
          }
          else if(field[i][j] == FILLED_TEMP){ //moving piece
            shape(nonEmptySpace, x, y, blockSize, blockSize); 
          }//Draw filled block
          else if(field[i][j] == FILLED_PERM){ //empty field
            shape(fieldColor[i][j], x, y, blockSize, blockSize);
          }
          noFill();
          rectMode(CORNER);
          rect(x, y, blockSize, blockSize); 
          if(i == 5 || i == 10 || i == 15 || i == 20 || i == 25){ // Draw yellow rows at row 5, 10, etc.
            stroke(200, 200, 0);
            noFill();
            rect(x, y, blockSize, blockSize);
            stroke(0);
          }
          if(j == 0){ // Label row numbers
            fill(255, 0, 0);
            rect(x, y, 5, 5);  
            textSize(10);
            text(i, x, y);
          }
      }  
    }
    
  } //End drawField()  
  
  void dropSlowly(){
    //Drop piece slowly  
    if (clock >= dropSpeed) {
      originY = originY+1;
      clock = 0;
    }
    else clock++;
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
      pieceRotate("clockwise");
      /*
      if (rotation_status == 4) rotation_status = 1;
      else rotation_status = rotation_status + 1;
      */
      break; 
    case 'X': //Clockwise turn
      pieceRotate("clockwise");
      break;
    case LEFT:
      moveLeft(); 
      break;
    case DOWN:
      moveDown();
      break;  
    case RIGHT:
      moveRight();
      break;
    case 'Z': //Anticlockwise turn.  Still need to implement
      pieceRotate("clockwise");
      break;  
    default:
      if(key == 'v'){
          instantDrop();
      }
      else if(key == 'q'){
        dropSpeed = 5;
      }
      else if(key == 'y'){
        multiClear();
      }
      else if(key == 's'){
        originX = 0;
      }
      break;
    }//switch
  }//end userInput
  
  void moveLeft(){
    if(canGoLeft == true) originX = originX-1;
  }
  
  void moveRight(){
    if(canGoRight == true) originX = originX+1;
  }
  
  void moveDown(){
    if(canGoDown == true) originY = originY+1;
  }
  
  void rotateRight(){
    pieceRotate("clockwise"); 
  }
  
  void rotateLeft(){
    pieceRotate("clockwise");
  }
  
  void pieceRotate(String direction){
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
      if(direction == "clockwise"){
        if (rotation_status == 4) rotation_status = 1;
        else rotation_status = rotation_status + 1;
        pieceDesign = updateArray(rotation_status);
      }  
    }
  } //End checkValidRotation()
  
  void instantDrop(){
    originY = getDropPositionY();
  }

  int getDropPositionY(){
    //Drop phantom piece down until it hits something
    boolean droppable = true; //Assume piece can be dropped
    int phantomOriginY = originY;
    int phantomOriginX = originX;
    int dropPosY = originY; // Dummy initial value.  Will be calculated below
    while(droppable == true){
      phantomOriginY = phantomOriginY + 1; // Imaginary dropping of phantom piece
      //check if there is overlap between field and pieceDesign
      //Iterate over pieceDesign
      for(int i = 0; i < pieceHeight; i++){
        for(int j = 0; j < pieceWidth; j++){
          if(pieceDesign[i][j] == 1 && i+phantomOriginY > a-1){ //prevents going out of bounds down
            droppable = false;
          }
          else if(pieceDesign[i][j] == 1 && field[i+phantomOriginY][j+phantomOriginX] == FILLED_PERM){  //Drops piece on top of existing ones
            droppable = false;  
          }
          if(droppable == false){
            dropPosY = i+phantomOriginY-5; // Where a dropped piece's Y position should be
          }
        }
      }
    }
    return dropPosY;
  }

  void getComputerResponse(Computer _computer){
  }
  /*
  boolean isGameOver(){
    int topY = topY() + originY; // Coordinate of top of block
      if(topY == 4){
      return true; 
    }
    else return false;
  }*/
  
  void staticDraw2(){
    for(int i = 0; i < pieceHeight; i ++){
      for(int j = 0; j < pieceWidth; j++){
        x = j*gridSize+width/2-(gridSize*b/2)+300; //x and y are grid locations
        y = i*gridSize+height/2-(gridSize*a/2)+300; 
        if(pieceDesign[i][j]==0){
          shape(emptySpace, x, y, gridSize, gridSize);
        }
        else{
          shape(thisBlock, x, y, gridSize, gridSize);
        }
      }
    }
  }
  
  void staticDraw(PieceType piece){ // Draw static next piece
    for(int i = 0; i < pieceHeight; i ++){
      for(int j = 0; j < pieceWidth; j++){
        x = j*gridSize+width/2-(gridSize*b/2)+220; //x and y are grid locations
        y = i*gridSize+height/2-(gridSize*a/2)+200; 
        if(pieceDesign[i][j]==0){
          shape(emptySpace, x, y, gridSize, gridSize);
        }
        else{
          shape(thisBlock, x, y, gridSize, gridSize);
        }
      }
    }
    }//End staticDraw
  
  void updateScore(int points){
    points = points + int(random(0,20));
    scoreKeeper.updateScore(points);
  }
  
  void checkHighScore(){
    scoreKeeper.checkHighScore();
  }
  
  void endGame(){
    changeGameStateToEnd();
  }
  
  int[][] updateArray(int rotation_status) { //Has information for piece rotation
    int[][] newArray = new int[5][5];
    if (pieceName == "L block") {
      switch(rotation_status) {
      case 1: 
        newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0},
          {0, 0, 1, 1, 0},
        }; 
        break;
      case 2:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 0},
          {0, 1, 0, 0, 0}}; 
        break;
      case 3:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}
        }; 
        break;
      case 4:
        newArray = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 1, 0}, 
          {0, 1, 1, 1, 0}, 
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
    return newArray;
  }// End updatearray()
} //End pieceType class

