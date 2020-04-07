int x = 350;
int y = 700;
int w = 30;
int h = 30;
float vx = 4;
float vy = 0;
int floor = 700;
float upTickSpeed = 10;
float gravity = 0.8;

void setup() {
    size(800, 800);
}

void draw() {
    drawEverything();
    updateLogic();
}

void updateLogic() {
  updatePosition();
}

void updatePosition() {
  x += vx;
  if (x + w > width) {
    vx = -abs(vx);  
  }
  if (x < 0) {
    vx = abs(vx);  
  }
  
  y += vy;
  if (y > floor) {
    y = floor;  
    vy = 0;
  }
  if (y < floor) {
    vy += gravity;
  }
}

void keyPressed() {
  if (key == ' ' && vy == 0) {
      vy -= upTickSpeed;
  }
}

void drawEverything() {
    clear();
    fill(255, 0, 0);
    rect(x, y, w, h);
    
}
