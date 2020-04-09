void keyPressed() {
  if (key == ' ') {
    player.jump();
  }
  if (!player.isAlive && key == ' ') {
    resetGame();
  }
  if (key == CODED) {
      if (keyCode == RIGHT) {
        player.swordDirection = "right";
      }
      if (keyCode == LEFT) {
        player.swordDirection = "left";
      }
      if (keyCode == UP) {
        player.swordDirection = "up";
      }
      if (keyCode == DOWN) {
        player.swordDirection = "down";
      }
      if (keyCode == SHIFT) {
        player.activateDash();
      }
    }
}
