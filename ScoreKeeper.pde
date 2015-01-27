class ScoreKeeper{
  int highScore;
  String[] scores;
  ScoreKeeper(String[] scores){
    this.scores = scores;
    
  }
  void displayScore(){
    print(scores);
//    char[] c = "hey".toCharArray();
    fill(0);
    text(scores[0],500,100);
//text("c",20,20);
  }
}
