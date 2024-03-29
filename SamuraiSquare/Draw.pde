void drawEverything() {
    clear();
    background(0);
    drawFloor();
    drawEnemies();
    drawPlayer();
    drawGodModeText();
    drawScore();
    drawDashSlots();
    if (showDashSlots) {
        drawJumpSlots();
    }
}

void drawDashSlots() {
    fill(0, 200, 0);
    for (int i = 0; i < player.dashSlots; i++) {
        circle(20 + 40 * i, height - 20, 25);
    }
    // draw used up dash slots (greyed out)
    if (shouldDrawUsedDashSlots) {
        fill(200, 200, 200);
        for (int i = player.dashSlots; i < player.maxDashSlots; i++) {
            circle(20 + 40 * i, height - 20, 25);
        }
    }
}

void drawJumpSlots() {
    fill(102, 51, 153);
    for (int i = 0; i < player.jumpSlots; i++) {
        circle(width - (20 + 40 * i), height - 20, 25);
    }
}

void drawScore() {
    fill(color(255, 255, 255));
    textSize(32);
    text(score, width - 60, 60);
}

void drawGodModeText() {
    if (godMode) {
        text("God Mode: ON", width - 250, 100);
    }
}

void drawEnemies() {
    for (Enemy enemy : enemies) {
        drawEnemy(enemy);
    }
}

void drawPlayer() {
    fill(255, 0, 0);
    rect(player.x, player.y, player.w, player.h);
    drawSword();
}

void drawEnemy(Enemy enemy) {
    if (enemy.isAlive) {
        fill(0, 100, 0);
    } else {
        fill(147, 130, 0);
    }
    rect(enemy.x, enemy.y, enemy.w, enemy.h);
    drawEnemyArmor(enemy);
}

void drawEnemyArmor(Enemy enemy) {
    fill(243, 103, 8);
    if (enemy.hasTopArmor) {
        rect(enemy.x, enemy.y, enemy.w, enemy.h/4);
    }
    if (enemy.hasBottomArmor) {
        rect(enemy.x, enemy.y + enemy.h * 3/4, enemy.w, enemy.h / 4);
    }
    if (enemy.hasLeftArmor) {
        rect(enemy.x, enemy.y, enemy.w/4, enemy.h);
    }
    if (enemy.hasRightArmor) {
        rect(enemy.x + enemy.w * 3/4, enemy.y, enemy.w / 4, enemy.h);
    }
}

void drawSword() {
    fill(217, 217, 217);
    rect(player.xsword, player.ysword, player.wsword, player.hsword);
}

void drawFloor() {
    fill(133, 94, 66);
    rectMode(CORNERS);
    rect(0, floor, width, height);
    rectMode(CORNER);
}

void drawGameOver() {
    fill(255, 255, 255);
    textAlign(CENTER);
    text("GAME OVER", width/2, 50);
    fill(0, 200, 0);
    text("Score: " + score, width/2, 100);
    fill(255, 255, 255);
    text("Restart: Space", width/2, 150);
    fill(255, 255, 255);
    text("Highscores:", width/2, 200);
    drawHighScores();
}

void drawHighScores() {
    ArrayList<Integer> highscores = getHighscores();
    for (int i = 0; i < highscores.size(); i++) {
        int scoreToPrint = highscores.get(i);
        if (scoreToPrint == score && (i == highscores.size() - 1 || (i < highscores.size() - 1 && highscores.get(i+1) != score))) {
            fill(0, 200, 0);
        } else {
            fill(255, 255, 255);
        }
        text((i+1) + ". " + str(scoreToPrint), width/2, 250 + i * 50);
    }
    rectMode(CORNER);
}
