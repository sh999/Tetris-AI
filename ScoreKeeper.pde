class ScoreKeeper{
  int highScore;
  int currentScore;
  String[] newHS;
  boolean highScoreChecked;
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
//    String[] textScore = {str(currentScore)};
    text("High Score", 550, 130);
    text(highScore, 550, 160);
//    print(textScore);
    println();
//    saveStrings("scores.txt", textScore);
  }
  
  void updateScore(int pts){
    currentScore += pts;
  }
  
  void checkHighScore(){
    loadScoreTable();
    insertNewScore();
    saveScoreTable();
    
    println("high score checked");
    println("running func");
    println("highScoreChecked is = "+highScoreChecked);
    
    
    
    if(highScoreChecked == false){
      /*
      Load high score file, convert to list of ints
      Iterate through list of ints, insert score if criteria are met
      Convert list of ints to list of strings, save to file
      */
      load
      String[] scoreListStr = loadStrings("data/scores.txt");
      int[] scoreList = new int[10];
      for(int i = 0; i < 10; i++){
        scoreList[i] = int(scoreListStr[i]);
      }
  //    int[] scoreList = {1000,90,80,70,60,50,40,30,20,10}; 
      int[] newList = {0,0,0,0,0,0,0,0,0,0};
      String[] newListStr = new String[10];
      boolean scoreInserted = false;
      
      for(int i = 0; i < scoreList.length; i++){
        if(scoreInserted == false){ 
          if(currentScore < scoreList[i]){  
            newList[i] = scoreList[i];
          }
          else if(currentScore >= scoreList[i]){  // Insert highest score at top of page
            newList[i] = currentScore;  
            scoreInserted = true;
          }
        }
        else if(scoreInserted == true){
          newList[i] = scoreList[i-1];
        }
      }
      
      
   } 
   highScoreChecked = true; 
  } // end func
  
  void loadScoreTable(){
  }
  void insertNewScore(){
  }
  void saveScoreTable(){
  }
  
  
  
} // end class
