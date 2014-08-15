class Score {
  int points = 0;
  int toAdd = 0;
  String[] highScore = loadStrings("highScore.txt");
  int highScoreNum = int(highScore[0]);
  int lineCount = 0;
  int level = 1;
//  PFont font;
  Score (){
//      font = loadFont("Arial-Black-48.vlw");
//      textFont(font, 10);
  }
  
  void leveller(int lineToAdd){
    lineCount = lineCount + lineToAdd;
    if(lineCount <= 10){
      level = 1;
      
    }
    else if(lineCount > 10 && lineCount <= 20){
      level = 2;
      
    }
    else if(lineCount > 20 && lineCount < 30){
      level = 3;
    }
   
  }
  
  
  void update(int lines){
    lineCount += lines;
    if(level == 1 && lineCount > 4){
      level++;
      setLevel();
    }
    if(level == 2 && lineCount > 8){
      level++;
      setLevel();
    }
    switch(lines){
    case 0:
      toAdd = 0;
      break;
    case 1:
      toAdd = 40;
      break;
    case 2:
      toAdd = 100;
      break;
    case 3:
      toAdd = 300;
      break;
    case 4:
      toAdd = 1200;
      break;
    }
    points = points + toAdd;
  }
  
  void setLevel(){
    currentPiece.setLevel();
  }
  
  void display(){
    
    fill(0);
    pushMatrix();
    translate(520, 40);
    rect(0, 0, 100, 200);
    fill(255);
    text("SCORE", 20, 20);
    text(points, 20, 40);
    displayHighScore();
    text("LINES", 20, 60);
    text(lineCount, 20, 80);
    text("LEVEL", 20, 100);
    text(level, 20, 120);
    popMatrix();
    
  }
  void checkHighScore(){
    String[] pastHS = loadStrings("highScore.txt");
    int pastHSnum = int(pastHS[0]);
    int newScore;
    String[] newHS = {str(points)};
    if(points > pastHSnum){
        saveStrings("highScore.txt", newHS);      
    }
  }//End checkHighScore()
    
    void displayHighScore(){
      text("HIGH SCORE", 540, 175);
      
      text(highScoreNum, 540, 195);
    }
    
    
  
  
}
