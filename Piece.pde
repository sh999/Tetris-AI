/*
Data on each piece without any functions
*/
class Piece{
  String pieceName; 
  int[][] pieceDesign;
  int blockSize = 20; //Pixelsize of svg object  
  int pieceHeight; 
  int pieceWidth; 
  String svgFileURL;
  int[][] temporaryPieceDesign;
  PShape Iblock, squareblock, Tblock, Sblock, Zblock, Lblock, Jblock, thisBlock;
  
  Piece(String pieceName){
    this.pieceName = pieceName;
    pieceDesign = new int[5][5];
    pieceDesign = processPiece(pieceName, 1);
  }
  
  int[][] processPiece(String pieceName, int rotation_status){
    /*
    Form: 
    if (pieceName == "some block")
      switch(rotation status) {
      case 1...
        pieceDesign = etc.
        .
        break;
      }
    }
    */
        
    if (pieceName == "L block") {
      switch(rotation_status) {
      case 1: 
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0},
          {0, 0, 1, 1, 0},
          
        }; 
        break;
      case 2:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 0},
          {0, 1, 0, 0, 0}}; 
        break;
      case 3:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}
        }; 
        break;
      case 4:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 1, 0}, 
          {0, 1, 1, 1, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      }
    }//L piece
    else if (pieceName == "J block") {
      switch(rotation_status) {
      case 1: 
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0},
          {0, 1, 1, 0, 0}, 
          {0, 1, 0, 0, 0}
        }; 
        break;
      case 2:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 1, 0, 0, 0}, 
          {0, 1, 1, 1, 0}, 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0}
        }; 
        break;
      case 3:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 1, 0}, 
          {0, 0, 1, 0, 0},
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        };
        break;
      case 4:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 0},
          {0, 0, 0, 1, 0}, 
          {0, 0, 0, 0, 0}
        };
       
        break;
      }
    }//J piece
    else if (pieceName == "Z block") {
      switch(rotation_status) {
      case 1:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 1, 1, 0, 0}, 
          {0, 0, 1, 1, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 2:
        pieceDesign = new int[][] { 
            {0, 0, 0, 0, 0},
            {0, 0, 0, 1, 0}, 
            {0, 0, 1, 1, 0}, 
            {0, 0, 1, 0, 0}, 
            {0, 0, 0, 0, 0}
        }; 
        break;
      case 3:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 1, 1, 0, 0}, 
          {0, 0, 1, 1, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
       
      case 4:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 0, 1, 0}, 
          {0, 0, 1, 1, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      }
    }//Z piece
    else if (pieceName == "S block") {
      switch(rotation_status) {
      case 1: 

        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 1, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 2:
       pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 1, 0}, 
          {0, 0, 0, 1, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 3: 
      pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 1, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 4:
      pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0},
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 1, 0}, 
          {0, 0, 0, 1, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
       
      }
    }//S piece
    else if (pieceName == "T block") {
      switch(rotation_status) {
      case 1: 
        pieceDesign = new int[][] { 
          { 0, 0, 0, 0, 0}, 
          { 0, 0, 1, 0, 0}, 
          { 0, 1, 1, 1, 0}, 
          { 0, 0, 0, 0, 0}, 
          { 0, 0, 0, 0, 0}
        }; 
        break;
      case 2:
        pieceDesign = new int[][] { 
          { 0, 0, 0, 0, 0}, 
          { 0, 0, 1, 0, 0}, 
          { 0, 0, 1, 1, 0}, 
          { 0, 0, 1, 0, 0}, 
          { 0, 0, 0, 0, 0}
        }; 
        break;
      case 3:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      case 4:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      }
    }//T piece
    else if (pieceName == "I block") {
      switch(rotation_status) {
      case 1:
        pieceDesign = new int[][] { 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;  
      case 2:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 1}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      case 3:
        pieceDesign = new int[][] { 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 1, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 4:
         pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 1, 1}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      }
    }//I piece
    if (pieceName == "square block") {
      switch(rotation_status) {
      case 1:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;  
      case 2:
         pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      case 3:
        pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break; 
      case 4:
         pieceDesign = new int[][] { 
          {0, 0, 0, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 1, 1, 0, 0}, 
          {0, 0, 0, 0, 0}, 
          {0, 0, 0, 0, 0}
        }; 
        break;
      }//End square rotation switch
    }//End if square piece
    return pieceDesign;
  }// End function
    
    
  

}// End Piece Class
