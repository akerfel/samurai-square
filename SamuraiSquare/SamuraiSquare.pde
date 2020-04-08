ArrayList<Enemy> enemies = new ArrayList<Enemy>();

Player player;
int floor = 700;
int enemySpawnTimerInterval = 150;
int enemySpawnTimer = 10;
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
