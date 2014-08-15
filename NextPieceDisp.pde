class NextPieceDisp {
  NextPieceDisp(){
    
  
  }
  
  void display(PieceType piece){
    
    fill(0);  
    pushMatrix();
    translate(520, 180);
    fill(0);
    stroke(0);
    rect(0, 0, 100, 100);
    fill(255);
    text("NEXT PIECE", 20, 20);
    popMatrix();
    piece.staticDraw(nextPiece);
  }
  
}
