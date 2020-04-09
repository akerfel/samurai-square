void keyPressed() {
  if (key == ' ') {
    player.jump();
  }
  if (!player.isAlive && key == ' ') {
    enemies.clear();
    setup();
  }
  if (key == CODED) {
      if (keyCode == RIGHT) {
        player.attack("right");
      }
      if (keyCode == LEFT) {
        player.attack("left");
      }
      if (keyCode == UP) {
        player.attack("up");
      }
      if (keyCode == DOWN) {
        player.attack("down");
      }
      if (keyCode == SHIFT) {
        player.activateDash();
      }
    }
}
