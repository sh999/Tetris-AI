class ScoreKeeper{
  int highScore;
  int currentScore;
  String[] newHS;
  ScoreKeeper(){
    scores = loadStrings("scores.txt");
    currentScore = 0;
    String[] scoreList = loadStrings("data/scores.txt");
    highScore = int(scoreList[0]);
    
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
    if(currentScore > highScore){
      print("yea");
      int newHighScore = currentScore;
      String[] newHighScoreStr = {str(newHighScore)};
      saveStrings("data/scores.txt", newHighScoreStr);
     
    }
    else print("no");
  }
}
