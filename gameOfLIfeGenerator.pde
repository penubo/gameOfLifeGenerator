/***********
 * gameOfLifeGenerator
 * version : 1.0.1
 * developer : penubo
 * description : 
   - just click you can make box alive or dead.
   - press 'r' than game start
   - press 's' than game stop
   - press 'd' when you want to delete whole box so that you can test new condition.
   - press '+' or '-' than you can change the scale
*************/

Box[][] boxes;
int rows, cols;
int scale = 20;
int maximumScale;
int minimumScale = 10;
boolean gameState = false;

void setup() {
  size(600, 400);
  
  // find gcd for maximumScale
  int gcd = 0;
  for(int i = 1; i < width && i < height; i++) {
    if(width%i == 0 && height%i == 0) {
      gcd = i;
    }
  }
  maximumScale = gcd;
 
  createBoxes(scale);
}

void draw() {
  frameRate(15);
  background(0);
    
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      boxes[i][j].update();
      boxes[i][j].display();
    }
  }

  if(gameState) {
    // checkNeighbours
    for(int i = 0; i < cols; i++) {
      for(int j = 0; j < rows; j++) {
        int sum = 0;
        sum = findNeighbours(boxes[i][j], i, j, boxes);
        if(boxes[i][j].selected == true && (sum < 2 || sum > 3)) {
          boxes[i][j].tempMemory = false;
        } else if(boxes[i][j].selected == false && sum == 3) {
          boxes[i][j].tempMemory = true;
        } else {
          boxes[i][j].tempMemory = boxes[i][j].selected;
        }
      }
    }
    // state Update
    for(int i = 0; i < cols; i++) {
      for(int j = 0; j < rows; j++) {
        boxes[i][j].selected = boxes[i][j].tempMemory;
      }
    } 
  }
}


void mousePressed() {
  // mouseX/scale = index of x same as y
  Box box = boxes[mouseX/scale][mouseY/scale];
  if(box.selected == false) {
    box.selected = true;
  } else {
    box.selected = false;
  }
}

void keyPressed() {
  
  if(key == 'd') {
    // delete whole state. -> reset
    initBoxState();
    changeBackgroundColor(color(255));
  }
  
  if(key == 'r') {
    // run game
    gameState = true;
    changeBackgroundColor(color(66, 134, 244));
  }
  
  if(key == 's') {
    // stop game
    gameState = false;
    changeBackgroundColor(color(244, 65, 140));
  }
  
  if(key == '-') {
    do {
      if(scale > minimumScale) {
        scale -= 2;
      } else {
        break;
      }
    } while(!(width%scale == 0 && height%scale == 0)); 
    createBoxes(scale);
    initBoxState();
  }
  
  if(key == '+') {
    do {
      if(scale < maximumScale) {
        scale += 2;
      } else {
        break;
      }
    } while(!(width%scale == 0 && height%scale == 0)); 
    createBoxes(scale);
    initBoxState();
  }
}

int findNeighbours(Box me, int x, int y, Box[][] state) {
  // find Neighbours
  // check 9 blocks include myself and finally subtract myself.
  int sum = 0;
  for(int i = -1; i <= 1; i++) {
    for(int j = -1; j <= 1; j++) {
      // use module operation so that you can access diagonal blocks.
      sum += state[(x+i + cols) % cols][(y+j + rows) % rows].selected == true ? 1 : 0;
    }
  }
  sum -= me.selected == true ? 1 : 0;
  return sum;
}

void changeBackgroundColor(color targetColor) {
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      boxes[i][j].defaultColor = targetColor;
    }
  }
}

void initBoxState() {
  gameState = false;
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      boxes[i][j].selected = false;
    }
  }
}

void createBoxes(int scale) {
  cols = width / scale;
  rows = height / scale;
  boxes = new Box[cols][rows];
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      boxes[i][j] = new Box(i*scale, j*scale);
    }
  }
}