class Score {
  int points = 0;
  int toAdd = 0;
  String[] highScore = loadStrings("highScore.txt");
  int highScoreNum = int(highScore[0]);
  PFont font;
  Score (){
      font = loadFont("Arial-Black-48.vlw");
      textFont(font, 10);


  }
  void update(int lines){
    
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
  void display(){
    
    fill(0);
    rect(520, 40, 100, 100);
    println(points);
    fill(255);
    text("SCORE", 540, 55);
    text(points, 540, 75);
    displayHighScore();
    
  }
  void checkHighScore(){
    String[] pastHS = loadStrings("highScore.txt");
    int pastHSnum = int(pastHS[0]);
    int newScore;
    String[] newHS = {str(points)};
    if(points > pastHSnum){
//      newScore = points;
        saveStrings("highScore.txt", newHS);      
    }
  }
    
    void displayHighScore(){
      text("HIGH SCORE", 540, 95);
      
      text(highScoreNum, 540, 115);
    }
    
    
  
  
}
