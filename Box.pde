class Box {
  
  boolean selected;
  boolean tempMemory;
  
  PVector position;
  
  color defaultColor;
  color highLightColor;
  color selectedColor;
  
  color boxColor;

  
  Box(float x, float y) {
    selected = false;
    position = new PVector(x, y);
    defaultColor = color(255);
    highLightColor = color(91);
    selectedColor = color(0);
    boxColor = defaultColor;
  }
  
  void update() {
    if(selected == true) {
      boxColor = selectedColor; 
    } else {
      if(isMouseOverBox()) {
        boxColor = highLightColor;     
      } else {
        boxColor = defaultColor; 
      }
    }
  }
  
  void display() {
    fill(boxColor);
    rect(position.x, position.y, scale, scale);
  }
  
  boolean isMouseOverBox() {
    if(mouseX > position.x && mouseX < position.x+scale &&
       mouseY > position.y && mouseY < position.y+scale) 
    {
      return true;
    }
    else {
      return false;
    }
  }
  
}
