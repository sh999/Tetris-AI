class ScoreKeeper{
  int highScore;
  String[] scoreList;
  int currentScore;
  ScoreKeeper(String[] scores){
    this.scoreList = scoreList;
    currentScore = 0;
  }
  void displayScore(){
    fill(0);
    rectMode(CORNER);
    rect(550,70,200,100);
    fill(255);
    text(currentScore, 630,100);
    
  }
  
  void updateScore(int pts){
    currentScore += pts;
  }
}
