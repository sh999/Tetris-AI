  //Match field- //match field with piece information.  Wherever piece is, that location will be "marked on the field"
  void pieceOnScreen(PieceType p, Field f){
    for(int i = 0; i < p.pieceHeight; i++){
      for(int j = 0; j < p.pieceWidth; j++){
        x = j*gridSize+width/2-(gridSize*f.b/2); //x and y are grid locations
        y = i*gridSize+height/2-(gridSize*f.a/2); 
        if(p.pieceDesign[i][j] == 1){
          f.field[i+p.originY][j+p.originX] = p.pieceDesign[i][j];//where matching occurs
        }
        else if(p.pieceDesign[i][j] == 0){
           //do nothing
        }
      }
    }  
  }//End matchField()
  
  
  //Draw Field- Based on the value of the field element, draw a block (empty space, space occupied by piece have diff. colors
  void drawField(Field f){
    int blockSize = 20; //Pixelsize of svg object  
    int EMPTY = 0;
    int FILLED_TEMP = 1; //Status of field cells
    int FILLED_PERM = 2;
    PShape nonEmptySpace, emptySpace;
    String svgFileURL = "Lblock.svg";
    emptySpace = loadShape("blank.svg");
    nonEmptySpace = loadShape(svgFileURL);
    for(int i = 4; i < f.a; i++){
      for(int j = 0; j < f.b; j++){
        x = j*gridSize+width/2-(gridSize*f.b/2); //x and y are grid locations
        y = i*gridSize+height/2-(gridSize*f.a/2)-50; 
        fill(255);
        if(f.field[i][j] == EMPTY){ //Where there is no piece, have block
          shape(emptySpace, x, y, blockSize, blockSize);  
        }
        else if(f.field[i][j] == FILLED_TEMP){ //moving piece
          shape(nonEmptySpace, x, y, blockSize, blockSize); 
        }//Draw filled block
        else if(f.field[i][j] == FILLED_PERM){ //empty field
          shape(f.fieldColor[i][j], x, y, blockSize, blockSize);
        }
//       stroke(232,32,32);
       noFill();
        rect(x, y, blockSize, blockSize); 
      }  
    }
//    printArr(field);  
  }
