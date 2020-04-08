
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

Player player;
boolean godMode = false;


void setup() {
    size(1000, 800);
    player = new Player();
}

void draw() {
    if (player.isAlive) {
      drawEverything();
      updateLogic();
    }
    else {
      drawGameOver();
    }
}
