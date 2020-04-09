void keyPressed() {
  if (key == ' ') {
    if (gameState == GameState.GAMEACTIVE) {
      player.deactiveDash();
      player.jump();
    }
    if (gameState == GameState.GAMEOVER) {
      resetGame();
    }
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
