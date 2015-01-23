color startColor, helpColor, aboutColor, quitColor;
String selectedOption;
int selectedOptionID;
Status currentStatus;
class MainMenu{
  MainMenu(){
    startColor = color(255,0,0);
    helpColor = color(0);
    aboutColor = color(0);
    quitColor = color(0);
    selectedOption = "Start";
    selectedOptionID = 0;
    currentStatus = Status.MAINMENU;
  }
  
  void drawMenu(){
    if (gameStatus == Status.MAINMENU){
      noStroke();
      fill(255);
      rect(width/2, height/2, 230, 200);
      fill(0);
      textFont(font, 30);
      fill(startColor);
      text("Start", width/2-80, height/2-50);
      fill(helpColor);
      text("Help", width/2-80, height/2-10);
      fill(aboutColor);
      text("About", width/2-80, height/2+30);
      fill(quitColor);  
      text("Quit", width/2-80, height/2+70);
      print(gameStatus);
    }
  }
  
  void keyboardResponse(){
    switch(keyCode){
      case UP:
        selectedOptionID = selectedOptionID - 1;
        if(selectedOptionID == -1){ selectedOptionID = 3; }
        break;
      case DOWN:
        selectedOptionID = selectedOptionID + 1;
        if(selectedOptionID == 4){ selectedOptionID = 0; }
        break;
      case ENTER:
        if (selectedOptionID == 0){
          shape(backgroundDesign); 
          currentStatus = Status.PLAYGAME; 
        }
        break;
    }
    startColor = color(0,0,0);
    helpColor = color(0);
    aboutColor = color(0);
    quitColor = color(0);
    switch(selectedOptionID){
      case 0:
        selectedOption = "Start";
        startColor = color(255, 0, 0);
        break;
      case 1:
        selectedOption = "Help";
        helpColor = color(255, 0, 0);
        break;
      case 2:
        selectedOption = "About";
        aboutColor = color(255, 0, 0);
        break;
      case 3:
        selectedOption = "Quit";
        quitColor = color(255, 0, 0);
        break;   
    }
  }
  
  Status getStatus(){
    return currentStatus;
  }
  
  
}
