// TO-DO
// INPUT mode 1:
// X/space = jump, Z/shift = dash, c/enter = restart
// arrow keys = sword direction

// INPUT mode 2:
// LMB = jump, RMB = dash
// wasd = sword direction

// INPUT MODE 3:
// LMB = jump, RMB = dash
// mouse = sword direction

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
    if (key == ENTER || key == 'c' || key == ' ') {
        resetGame();
    }
}

void keysPressedGAMEACTIVE() {
    checkWASD();
    if (key == ' ' || key == 'x') {
        player.deactiveDash();
        player.jump();
    } else if (key == 'z') {
        player.activateDash();
    }
    if (key == CODED) {
        if (keyCode == RIGHT) {
            player.swordDirection = "right";
        } else if (keyCode == LEFT) {
            player.swordDirection = "left";
        } else if (keyCode == UP) {
            player.swordDirection = "up";
        } else if (keyCode == DOWN) {
            player.swordDirection = "down";
        }
        if (keyCode == SHIFT) {
            player.activateDash();
        }
    }
}

void checkWASD() {
    if (key == 'd') {
        player.swordDirection = "right";
    } else if (key == 'a') {
        player.swordDirection = "left";
    } else if (key == 'w') {
        player.swordDirection = "up";
    } else if (key == 's') {
        player.swordDirection = "down";
    }
}

void mousePressed() {
    switch(gameState) {
    case GAMEACTIVE:
        if (mouseButton == LEFT) {
            player.deactiveDash();
            player.jump();
        }
        if (mouseButton == RIGHT) {
            player.activateDash();
        }
        break;
    }
}
