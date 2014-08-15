class NextPiece {
  NextPiece(){
    
  
  }
  
  void display(){
    
    fill(0);  
    pushMatrix();
    translate(520, 180);
    
    rect(0, 0, 120, 100);
    fill(255);
    text("NEXT PIECE", 20, 20);
    popMatrix();

  }
  
}
