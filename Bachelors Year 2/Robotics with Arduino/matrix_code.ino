#include <LiquidCrystal.h>
#include <LedControl.h>
#include <time.h>
#include <stdlib.h>

//Pinii folositi
const int rs = 12, en = 11, d4 = 4, d5 = 5, d6 = 6, d7 = 7, v0 = 3; //pentru lcd display
const int din = 2, load = 0, clk = 1, numberOfDriversMAX7219 = 1; //pentru led matrix
const int button = 8, VRx = A0, VRy = A1; //pentru joystick

//Initializari
LiquidCrystal lcdDisplay(rs, en, d4, d5, d6, d7);
LedControl ledMatrix = LedControl(din, clk, load, numberOfDriversMAX7219);

//structuri de date
struct point {
    int x, y;

    point(int a, int b) {
        x = a;
        y = b;
    }

    point() {
        x = 0;
        y = 0;
    }

    bool operator!=(point a) {
        if (a.x != x || a.y != y)
            return true;
        else
            return false;
    }
} P;

//variabile globale
unsigned int brightness = 75;
const unsigned long delayTime = 10;
int xRead; //X values from joystick
int yRead; //Y values from joystick
char screen[8][8]; //variable for storing screen particles (pixels)
int n[8][8];  //variable for checking
long highScore;
long score = 0, birdX = 0, birdY = 0; //variaous variables for certain operations
int level = 1;
bool err; //boolean for error detection
int life = 4;
unsigned long currentMillis, previousMillis;
byte heart[8] = {
        B00000,
        B00000,
        B01010,
        B11111,
        B11111,
        B01110,
        B00100,
        B00000
};

//diverse functii
void claenScren();

void actualizeLines();

void boss();

void game();

bool gameOver();

void help();

void menu();

void endGame();

void credits();

void loseLife(point);

point readJoystick();

point mapPoint(point);

point mapPointMatrix(point);

point readJoystick() {
    P.x = analogRead(VRx); //sets the X value
    P.y = analogRead(VRy); //sets the Y value

    P.x = map(P.x, 0, 1000, 0, 7);
    P.y = map(P.y, 0, 1000, 0, 7);

    return P;
}

int readXFromJoystick() {
    return analogRead(VRx);
}

int readYFromJoystick() {
    return analogRead(VRy);
}

point mapPoint(point pointToMap) {
    point pointMapped = pointToMap;
    pointMapped.y = 7 - pointMapped.y;
    return pointMapped;
}

point mapPointMatrix(point pointToMap) {
    point pointMapped = pointToMap;
    pointMapped.x = 7 - pointMapped.x;
    return pointMapped;
}

void setup() {
    analogWrite(v0, brightness);
    lcdDisplay.begin(16, 2);
    /*
     The MAX72XX is in power-saving mode on startup,
     we have to do a wakeup call
     */
    ledMatrix.shutdown(0, false);
    /* Set the brightness to a medium values */
    ledMatrix.setIntensity(0, 8);
    /* and clear the display */
    ledMatrix.clearDisplay(0);
    srand(static_cast<unsigned int>(time(nullptr)));
    lcdDisplay.createChar(0, heart);
}

void SetPointToMatrix(point toDrow) {

    ledMatrix.setLed(0, toDrow.x, toDrow.y, true);
    delay(delayTime);
}

void unsetPointToMatrix(point toDrow) {

    ledMatrix.setLed(0, toDrow.x, toDrow.y, false);
}

void claenScren() {
    for (int i = 0; i < 8; i++)
        for (int j = 0; j < 8; j++)
            screen[i][j] = 0;
}

void SetScreenToMatrix() {

    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (screen[i][j])
                ledMatrix.setLed(0, mapPointMatrix(point(i, j)).x, mapPointMatrix(point(i, j)).y, true);
        }
    }
    delay(delayTime * 20);
}

void loop() {
    delay(20);
    menu();
}

point curentPoint = mapPointMatrix(point(1, 4)), precPoint, defPoint = mapPointMatrix(point(3, 3));
point bird;

void actualizeLinesForBoss() {
    for (int i = 0; i < 7; i++) {
        for (int j = 0; j < 8; j++) {
            screen[i][j] = screen[i + 1][j];
        }
    }

    for (int i = 0; i < 8; i++) {
        screen[7][i] = 0;
    }
}

void actualizeLines() {
    for (int i = 0; i < 7; i++) {
        for (int j = 0; j < 8; j++) {
            screen[i][j] = screen[i + 1][j];
        }
    }

    for (int i = 0; i < 8; i++) {
        screen[7][i] = 0;
    }

    if (screen[5][0] || screen[6][0]);
    else {
        if (rand() % 2) {
            for (int i = 0; i < 8; i++)
                screen[7][i] = 1;
            int emptyPos = rand() % 5 + 1;
            int emptySpace = min(emptyPos + 1 + rand() % (7 - 1 - emptyPos), 6);
            for (int i = emptyPos; i <= emptySpace; i++)
                screen[7][i] = 0;
        }
    }
}

void moveBird(int &i) {
    int newPositionY = readYFromJoystick();
    precPoint = curentPoint;
    if (newPositionY > 530) {
        curentPoint.y = map(newPositionY, 530, 1000, min(curentPoint.y + 1, 7), 7);
        for (int i = precPoint.y; i < curentPoint.y; i++)
            SetPointToMatrix(mapPointMatrix(point(1, i)));
        for (int i = precPoint.y; i < curentPoint.y; i++)
            unsetPointToMatrix(mapPointMatrix(point(1, i)));
    }
    if (newPositionY < 500) {
        curentPoint.y = map(newPositionY, 0, 500, 0, max(curentPoint.y - 1, 0));
        for (int i = precPoint.y; i > curentPoint.y; i--)
            SetPointToMatrix(mapPointMatrix(point(1, i)));
        for (int i = precPoint.y; i > curentPoint.y; i--)
            unsetPointToMatrix(mapPointMatrix(point(1, i)));
    }
    bird = curentPoint;
    SetPointToMatrix(bird);
    if (screen[7 - bird.x][bird.y]) {
        loseLife(bird);
        i = 100;

    }
    ledMatrix.setLed(0, precPoint.x, precPoint.y, false);
}

int setLevelDificulty() {
    switch (level) {
        case 1: {
            return 80;
        }
        case 2: {
            return 70;
        }
        case 3: {
            return 60;
        }
        case 4: {
            return 50;
        }
        case 5: {
            return 60;
        }
        case 6: {
            return 50;
        }
        case 7: {
            return 40;
        }
        case 8: {
            return 30;
        }
        case 9: {
            return 20;
        }
        case 10: {
            return 10;
        }
    }
}

struct enemy {
    point bossPosition = point(6, 3);

    void drowBoss() {
        SetPointToMatrix(mapPointMatrix(bossPosition));
        SetPointToMatrix(mapPointMatrix(point(bossPosition.x + 1, bossPosition.y)));
        SetPointToMatrix(mapPointMatrix(point(bossPosition.x, bossPosition.y + 1)));
        SetPointToMatrix(mapPointMatrix(point(bossPosition.x + 1, bossPosition.y + 1)));
    }

    void setBoss() {
        screen[bossPosition.x][bossPosition.y] = 1;
        screen[bossPosition.x + 1][bossPosition.y] = 1;
        screen[bossPosition.x][bossPosition.y + 1] = 1;
        screen[bossPosition.x + 1][bossPosition.y + 1] = 1;
    }

    void unsetBoss() {
        screen[bossPosition.x][bossPosition.y] = 0;
        screen[bossPosition.x + 1][bossPosition.y] = 0;
        screen[bossPosition.x][bossPosition.y + 1] = 0;
        screen[bossPosition.x + 1][bossPosition.y + 1] = 0;
    }

    int distanceToBoss() {
        return (int) sqrt((bird.x - bossPosition.x) * (bird.x - bossPosition.x) +
                          (bird.y - bossPosition.y) * (bird.y - bossPosition.y));
    }
} bosss;

void bossUpOrDownRandom() {
    int pos = rand() % 7;
    bosss.unsetBoss();
    bosss.bossPosition.y = pos;
    bosss.setBoss();
}

void bossUpOrDownBad() {
    int pos = rand() % 7;
    bosss.unsetBoss();
    bosss.bossPosition.y = (bird.y == 7 ? 6 : bird.y);
    bosss.setBoss();
}

void bossToBird() {
    int pos = rand() % 7;
    bosss.unsetBoss();
    bosss.bossPosition.x = pos;
    bosss.setBoss();
}

void actualizeBoss() {
    int option = rand() % 3;
    switch (option) {
        case 0: {
            bossUpOrDownRandom();
            break;
        }
        case 1: {
            bossUpOrDownBad();
            break;
        }
        case 2: {
            bossToBird();
            break;
        }
    }
}

void boss() {

    ledMatrix.clearDisplay(0);
    for (int p = 0; p < 8; p++) {
        lcdDisplay.begin(16, 2);
        lcdDisplay.clear();         //clear the screen
        lcdDisplay.setCursor(0, 0); //set cursor to upper left corner
        lcdDisplay.print("Lives: ");
        for (int l = 0; l < life; l++)
            lcdDisplay.print(char(0));
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("Score: ");
        lcdDisplay.print(score);

        lcdDisplay.setCursor(12, 0);
        lcdDisplay.print("L:");
        lcdDisplay.print(level);

        actualizeLinesForBoss();
        SetScreenToMatrix();

        int i;
        for (i = 0; i < setLevelDificulty(); i++)
            moveBird(i);

        if (i >= 100) {
            claenScren();
            ledMatrix.clearDisplay(0);
        } else if (screen[1][0])
            score += level;
        ledMatrix.clearDisplay(0);
    }

    //Boss code

    while (true) {
        lcdDisplay.begin(16, 2);
        lcdDisplay.clear();         //clear the screen
        lcdDisplay.setCursor(0, 0); //set cursor to upper left corner
        lcdDisplay.print("Lives: ");
        for (int l = 0; l < life; l++)
            lcdDisplay.print(char(0));
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("Score: ");
        lcdDisplay.print(score);

        lcdDisplay.setCursor(12, 0);
        lcdDisplay.print("L:");
        lcdDisplay.print(level);

        actualizeBoss();
        SetScreenToMatrix();

        int i;
        for (i = 0; i < 50; i++)
            moveBird(i);

        if (i >= 100) {
            claenScren();
            ledMatrix.clearDisplay(0);
        } else {
            unsigned long currentMillis = millis();
            if (currentMillis - previousMillis > 100) {
                previousMillis = currentMillis;
                score += bosss.distanceToBoss();
            }
        }
        ledMatrix.clearDisplay(0);
    }
}

void game() {

    while (true) {
        lcdDisplay.begin(16, 2);
        lcdDisplay.clear();         //clear the screen
        lcdDisplay.setCursor(0, 0); //set cursor to upper left corner
        lcdDisplay.print("Lives: ");
        for (int l = 0; l < life; l++)
            lcdDisplay.print(char(0));
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("Score: ");
        lcdDisplay.print(score);

        lcdDisplay.setCursor(12, 0);
        lcdDisplay.print("L:");
        lcdDisplay.print(level);

        actualizeLines();
        SetScreenToMatrix();

        int i;
        for (i = 0; i < setLevelDificulty(); i++)
            moveBird(i);

        if (i >= 100) {
            claenScren();
            ledMatrix.clearDisplay(0);
        } else {
            if (screen[1][0])
                score += level;
            unsigned long currentMillis = millis();
            if (currentMillis - previousMillis > 36000) {
                previousMillis = currentMillis;
                level++;
            }
        }
        if (level == 10)
            boss();
        ledMatrix.clearDisplay(0);
    }
}

void loseLife(point badPoint) {
    life--;
    level = 1;
    for (int i = 0; i < 3; i++) {
        unsetPointToMatrix(badPoint);
        delay(delayTime * 10);
        SetPointToMatrix(badPoint);
    }

    if (life < 0)
        endGame();
}

void endGame() {//just some screens for certain actions

    life = 4;
    claenScren();
    ledMatrix.clearDisplay(0);

    point sel;
    lcdDisplay.begin(16, 2);
    while (true) {
        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("GAME OVER !");
        delay(2000);

        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("YOUR SCORE:");
        lcdDisplay.print(score);
        if (score > highScore)
            highScore = score;
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("HIGH SCORE:");
        lcdDisplay.print(highScore);
        for (int i = 0; i < 50; i++) {
            delay(40);
            sel = readJoystick();
            if (mapPoint(sel).x == 0 || mapPoint(sel).x == 1 || mapPoint(sel).x == 2) {
                score = 0;
                loop();
            }
        }
    }
}

void menu() { //shows menu
    point sel;
    lcdDisplay.begin(16, 2);
    while (true) {
        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("NEW FLAPPY BIRD!");
        delay(2500);

        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("Menu: ");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("Up: Start Game");
        delay(1000);

        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("Left: Help");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("Right: Credits");
        delay(1000);

        lcdDisplay.clear();
        lcdDisplay.print("Please select.");
        for (int i = 0; i < 50; i++) {
            delay(50);
            sel = readJoystick();
            if ((mapPoint(sel).y == 7 || mapPoint(sel).y == 6 || mapPoint(sel).y == 5) &&
                (mapPoint(sel).x == 3 || mapPoint(sel).x == 4)) {
                game();
                return;
            }
            if (mapPoint(sel).x == 0 || mapPoint(sel).x == 1 || mapPoint(sel).x == 2) {
                help();
                return;
            }
            if (mapPoint(sel).x == 7 || mapPoint(sel).x == 6 || mapPoint(sel).x == 5) {
                credits();
                return;
            }
        }
    }
}

void help() {
    point sel;
    lcdDisplay.begin(16, 2);
    while (true) {
        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("Controls:  Press the ");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("joystick up to fly up.");
        delay(1000);
        // scroll 6 positions (string length) to the left
        // to move it offscreen left:
        for (int positionCounter = 0; positionCounter < 6; positionCounter++) {
            // scroll one position left:
            lcdDisplay.scrollDisplayLeft();
            // wait a bit:
            delay(350);
        }
        delay(350);

        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("Goal: Fly through the ");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("holes between the pipes. ");
        delay(1000);
        // scroll 10 positions (string length) to the left
        // to move it offscreen left:
        for (int positionCounter = 0; positionCounter < 10; positionCounter++) {
            // scroll one position left:
            lcdDisplay.scrollDisplayLeft();
            // wait a bit:
            delay(350);
        }
        delay(350);

        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("When you pass through the");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("hole,you get 1*level points.");
        delay(1000);
        // scroll 12 positions (string length) to the left
        // to move it offscreen left:
        for (int positionCounter = 0; positionCounter < 12; positionCounter++) {
            // scroll one position left:
            lcdDisplay.scrollDisplayLeft();
            // wait a bit:
            delay(350);
        }
        delay(350);

        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("Try to pass as");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("much as you can.");
        delay(1000);
        delay(350);

        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("But be careful, don't ");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("hit the pipes or the ground!");
        delay(1000);
        // scroll 12 positions (string length) to the left
        // to move it offscreen left:
        for (int positionCounter = 0; positionCounter < 12; positionCounter++) {
            // scroll one position left:
            lcdDisplay.scrollDisplayLeft();
            // wait a bit:
            delay(350);
        }
        delay(350);

        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("Are you ready?");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("Go! ");
        delay(1000);
        delay(350);

        lcdDisplay.clear();
        lcdDisplay.print("Go back? [y/n]");
        for (int i = 0; i < 50; i++) {
            delay(50);
            sel = readJoystick();
            if (mapPoint(sel).x == 0 || mapPoint(sel).x == 1 || mapPoint(sel).x == 2) return;
        }
    }
}

void credits() {
    point sel;
    lcdDisplay.begin(16, 2);
    while (true) {
        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("Programmer: LM");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("Go back? [y/n]");
        for (int i = 0; i < 50; i++) {
            delay(40);
            sel = readJoystick();
            if (mapPoint(sel).x == 0 || mapPoint(sel).x == 1 || mapPoint(sel).x == 2) return;
        }
        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("Designer: LM");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("Go back? [y/n]");
        for (int i = 0; i < 50; i++) {
            delay(40);
            sel = readJoystick();
            if (mapPoint(sel).x == 0 || mapPoint(sel).x == 1 || mapPoint(sel).x == 2) return;
        }
        lcdDisplay.clear();
        lcdDisplay.setCursor(0, 0);
        lcdDisplay.print("Version 1.0");
        lcdDisplay.setCursor(0, 1);
        lcdDisplay.print("Go back? [y/n]");
        for (int i = 0; i < 50; i++) {
            delay(40);
            sel = readJoystick();
            if (mapPoint(sel).x == 0 || mapPoint(sel).x == 1 || mapPoint(sel).x == 2) return;
        }
    }
}
