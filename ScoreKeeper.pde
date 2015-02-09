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
  void displayScore(){
    fill(0);
    rectMode(CORNER);
    rect(530, 40, 240, 140);
    fill(255);
    text("Score", 550, 70);
    text(currentScore, 550, 100);
    text("High Score", 550, 130);
    text(highScore, 550, 160);
    println();
  }
  
  void updateScore(int pts){
    currentScore += pts;
  }
  
  void checkHighScore(){
//    println("high score checked");
//    println("running func");
//    println("highScoreChecked is = "+highScoreChecked);
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
//      println(newList[i]);
    }
    saveStrings("data/scores.txt",newListStr); 
  }
} // end class
