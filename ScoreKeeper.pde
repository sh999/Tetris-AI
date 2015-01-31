class ScoreKeeper{
  int highScore;
  int currentScore;
  String[] newHS;
  ScoreKeeper(){
    scores = loadStrings("scores.txt");
    currentScore = 0;
  }
  void displayScore(){
    fill(0);
    rectMode(CORNER);
    rect(550,70,200,100);
    fill(255);
    text(currentScore, 630,100);
    String[] textScore = {str(currentScore)};
    print(textScore);
    saveStrings("scores.txt",textScore);
  }
  
  void updateScore(int pts){
    currentScore += pts;
  }
  
  void checkHighScore(){
  }
}
