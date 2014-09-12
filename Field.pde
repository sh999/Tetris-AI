class Field{
  int linesToClear = 0; 
  int[][] design; 
  int EMPTY = 0;
  int FILLED_TEMP = 1; 
  int FILLED_PERM = 2;
  PShape nonEmptySpace, emptySpace;
  int blockSize = 20; //Pixelsize of svg object  

  
  int a = 29; // Field height (more than visible to accomodate rotation on top)
  int b = 10; // Field width

  int gridSize = 20;
  int[][] field = new int[a][b];
  int rect_width, rect_height;
  PShape[][] fieldColor = new PShape[a][b];
  PShape[][] tempFieldColor = new PShape[a][b];

  PShape backgroundDesign;
  
  NextPieceDisp nextPieceDisp;

  Field(){
    design = new int[a][b];
    for(int i = 0; i < a; i++){
      for(int j = 0; j < b; j++){
        design[i][j] = 0; 
      }
    }
  } 
  
  void display(){
//    nonEmptySpace = loadShape(svgFileURL);
//    emptySpace = loadShape("blank.svg");
    drawField(this);
  }
  

  
}
