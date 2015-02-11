class ScoreKeeper{
  int highScore;
  int currentScore;
  String[] newHS;
  boolean highScoreChecked;
  
  String[] scoreListStr, newListStr;
  int[] scoreList, newList;
  boolean scoreInserted;
  
  ScoreKeeper(){
    scores = loadStrings("scores.txt");
    currentScore = 0;
    String[] scoreList = loadStrings("data/scores.txt");
    highScore = int(scoreList[0]);
    highScoreChecked = false;
    
  }
  void displayScore2(){
    fill(0);
    rectMode(CORNER);
    rect(530, 40, 240, 140);
    fill(255);
    text("Score", 550, 70);
    text(currentScore, 550, 100);
    text("High Score", 550, 130);
    text(highScore, 550, 160);
  }
  
  void displayScore(){
    rectMode(CENTER);
    noStroke();
    int menuX = 370;
    int menuY = 130;
    int textOffsetX = menuX - 90;
    int textOffsetY = menuY - 50;
    fill(0);
    rect(menuX, menuY, 220, 180);
    textFont(font, 30);
    color textColor = color(255);
    drawLineItem("Score", textOffsetX, textOffsetY, 0, 40, textColor);
    drawLineItem(str(currentScore), textOffsetX, textOffsetY, 1, 40, textColor);
    drawLineItem("High Score", textOffsetX, textOffsetY, 2, 40, textColor);
    drawLineItem(str(highScore), textOffsetX, textOffsetY, 3, 40, textColor);
  }
  
  void updateScore(int pts){
    currentScore += pts;
  }
  
  void checkHighScore(){
    if(highScoreChecked == false){
      loadScoreTable();
      println("inserting..");
      insertNewScore();
      saveScoreTable();
    }
    highScoreChecked = true;
  } // end func
  
  void loadScoreTable(){
    scoreListStr = loadStrings("data/scores.txt");
    scoreList = new int[10];
    for(int i = 0; i < 10; i++){  // Copy the scores into scoreList by way of str to int conversion
      scoreList[i] = int(scoreListStr[i]);
    }
    newList = new int[]{0,0,0,0,0,0,0,0,0,0};
    newListStr = new String[10];
    scoreInserted = false;
  }
  
  void insertNewScore(){
    for(int i = 0; i < scoreList.length; i++){
      if(scoreInserted == false){ 
        if(currentScore >= scoreList[i]){  // Insert highest score at top of page
          print("updating with score = "+currentScore);

          newList[i] = currentScore;  
          scoreInserted = true;
        }
        else if(currentScore < scoreList[i]){  
          newList[i] = scoreList[i];
        }
      }
      else if(scoreInserted == true){
        newList[i] = scoreList[i-1];
      }
    }
  }
  
  void saveScoreTable(){
    for(int i = 0; i < newList.length; i++){
      newListStr[i] = str(newList[i]);
    }
    saveStrings("data/scores.txt",newListStr); 
  }
  
  void drawLineItem(String lineName, int x, int y, int lineNum, int lineSpacing, int lineColor){
    fill(lineColor);
    y = y + (lineSpacing * lineNum);  
    text(lineName, x, y);
  }
} // end class
