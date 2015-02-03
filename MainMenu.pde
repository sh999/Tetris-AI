color startColor, controlColor, aboutColor, hsColor, pausedColor, resumeColor, goToTitleColor, quitColor;
String selectedOption;
int selectedOptionID;
int maxSelectID;

Status currentStatus;
class MainMenu{
  MainMenu(){
    startColor = color(255,0,0);
    controlColor = color(0);
    aboutColor = color(0);
    hsColor = color(0);
    pausedColor = color(0);
    resumeColor = color(0);
    goToTitleColor = color(0);
    quitColor = color(0);
    selectedOption = "Start";
    selectedOptionID = 0;
    currentStatus = Status.MAINMENU;
    maxSelectID = 4;
  }
  
  void drawMenu(){
    rectMode(CENTER);
    if (gameStatus == Status.MAINMENU){
      noStroke();
      fill(255);
      rect(width/2+20, height/2, 270, 200);
      fill(0);
      textFont(font, 30);
      fill(startColor);
      text("Start", width/2-80, height/2-50);
      fill(controlColor);
      text("Controls", width/2-80, height/2-10);
      fill(aboutColor);
      text("About", width/2-80, height/2+30);
      fill(hsColor);  
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
        if(selectedOptionID == maxSelectID){ selectedOptionID = 0; }
        break;
      case ENTER:
        if(currentStatus == Status.MAINMENU){
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
          else if(selectedOptionID == 3){
            shape(backgroundDesign); 
            currentStatus = Status.HIGHSCORE;
          }
        }
        else if(currentStatus == Status.PAUSE){
          if (selectedOptionID == 0){
            shape(backgroundDesign);  
            currentStatus = Status.PLAYGAME; 
          }
          else if(selectedOptionID == 1){
            currentStatus = Status.MAINMENU;
            setup();
          }
          else if(selectedOptionID == 2){
            exit();
          } 
        }
        break;
    }
    startColor = color(0);
    controlColor = color(0);
    aboutColor = color(0);
    hsColor = color(0);
    pausedColor = color(0);
    resumeColor = color(0);
    goToTitleColor = color(0);
    quitColor = color(0);
    switch(selectedOptionID){
      case 0:
        startColor = color(255, 0, 0);
        resumeColor = color(255, 0, 0);
        break;
      case 1:
        controlColor = color(255, 0, 0);
        goToTitleColor = color(255, 0, 0);
        break;
      case 2:
        aboutColor = color(255, 0, 0);
        quitColor = color(255, 0, 0);
        break;
      case 3:
        hsColor = color(255, 0, 0);
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
  
  void drawHighScore(){
    for(int i = 0; i <= 9; i++){
      println(i);
    }
  }
  
  void drawPause(){
    maxSelectID = 3; // Makes scrolling of highlighted menu item work
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(width/2+20, height/2, 330, 200);
    fill(0);
    textFont(font, 30);
    fill(pausedColor);
    text("Paused", width/2-50, height/2-50);
    fill(resumeColor);
    text("Resume game", width/2-120, height/2-10);
    fill(goToTitleColor);
    text("Go to title screen", width/2-120, height/2+30);
    fill(quitColor);  
    text("Quit", width/2-120, height/2+70);
  }
  
  void gameOver(){
  
  }
}
