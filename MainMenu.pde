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
    rectMode(CENTER);
    if (gameStatus == Status.MAINMENU){
      noStroke();
      fill(255);
      rect(width/2, height/2, 230, 200);
      fill(0);
      textFont(font, 30);
      fill(startColor);
      text("Start", width/2-80, height/2-50);
      fill(helpColor);
      text("Controls", width/2-80, height/2-10);
      fill(aboutColor);
      text("About", width/2-80, height/2+30);
      fill(quitColor);  
      text("High Scores", width/2-80, height/2+70);
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
        else if(selectedOptionID == 1){
          shape(backgroundDesign); 
          currentStatus = Status.CONTROLS;
        }
        else if(selectedOptionID == 2){
          shape(backgroundDesign); 
          currentStatus = Status.ABOUT;
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
        selectedOption = "Controls";
        helpColor = color(255, 0, 0);
        break;
      case 2:
        selectedOption = "About";
        aboutColor = color(255, 0, 0);
        break;
      case 3:
        selectedOption = "High Scores";
        quitColor = color(255, 0, 0);
        break;   
    }
  }
  
  Status getStatus(){
    return currentStatus;
  }
  
  void setStatus(Status status){
    currentStatus = status;
  }
  
  void drawAbout(){
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(width/2, height/2, 230, 200);
    fill(0);
    textFont(font, 30);
    text("Made by", width/2-80, height/2-50);
    text("Satrio", width/2-50, height/2-10);
    fill(255, 0, 0);
    text("Back", width/2-50, height/2+50);      
  }
  
  void drawControls(){
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(width/2, height/2, 440, 200);
    fill(0);
    textFont(font, 30);
    text("Movement: Arrow keys", width/2-200, height/2-50);
    text("Instant drop:  v", width/2-200, height/2-10);
    text("Pause:  p", width/2-200, height/2+30);
    fill(255, 0, 0);
    text("Back", width/2-200, height/2+70);      
  }
  
  void drawPause(){
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(width/2, height/2, 200, 50);
    fill(255);
    text("Paused", width/2-60, height/2+5);
    fill(255, 0, 0);
  }
}
