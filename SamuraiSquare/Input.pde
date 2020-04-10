void keyPressed() {
  switch(gameState) {
    case GAMEACTIVE:
      keysPressedGAMEACTIVE();
      break;
    case GAMEOVER:
      keysPressedGAMEOVER();
      break;
    case STARTSCREEN:
      break;
  }
}

void keysPressedGAMEOVER() {
  if (key == ENTER) {
    resetGame();
  }
}

void keysPressedGAMEACTIVE() {
  if (key == ' ') {
      player.deactiveDash();
      player.jump();
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
