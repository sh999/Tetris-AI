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
    String[] scoreListStr = loadStrings("data/scores.txt");
//    int[] scoreList = new int[10];
    /*for(int i = 0; i < 10; i++){
      scoreList[i] = int(scoreListStr[i]);
    }*/
    int[] scoreList = {1000,90,80,70,60,50,40,30,20,10}; 
    int[] newList = {0,0,0,0,0,0,0,0,0,0};
    String[] newListStr = new String[10];
    boolean scoreInserted = false;
    for(int i = 0; i < scoreList.length; i++){
      if(scoreInserted == false){
        if(currentScore < scoreList[i]){
          newList[i] = scoreList[i];
        }
        else if(currentScore > scoreList[i]){
          newList[i] = currentScore;
          scoreInserted = true;
        }
      }
      else if(scoreInserted == true){
        newList[i] = scoreList[i-1];
      }
    }
    for(int i = 0; i < newList.length; i++){
      newListStr[i] = str(newList[i]);
      println(newList[i]);
    }
    saveStrings("data/scores.txt",newListStr); 
  }
}
