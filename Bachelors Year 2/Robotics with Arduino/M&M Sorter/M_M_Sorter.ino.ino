#include <Servo.h>
#define S0 13
#define S1 12
#define S2 10
#define S3 11
#define sensorOut 9
struct RGB {
  int R, G, B;
};
Servo topServo;
Servo bottomServo;
int frequency = 0;
int step = 1; //the variable used to configure the
//initial machine setting (step == 1) when you sort 
//the yellow, brown and the rest when you do not see 
//the bobbins in the last 5 days when the car moves 
//the redirect bridge 5 times in a short interval. 
//waiting for 5s after which you can sort the rest 
//of the bobbins: red, green and blue when step == 2
int numberOfNothing = 0; //the variable used to count 
//how many times there is no bobbin at the sensor, 
//meaning there are no bobbins or a starvation
//phenomenon when the candies are stuck
int color=0;
void setup() {
  
  pinMode(S0, OUTPUT); //for color sensor
  pinMode(S1, OUTPUT); //for color sensor
  pinMode(S2, OUTPUT); //for color sensor
  pinMode(S3, OUTPUT); //for color sensor
  pinMode(sensorOut, INPUT); //for color sensor
  digitalWrite(S0, HIGH); //init color sensor
  digitalWrite(S1, LOW); //init color sensor
  topServo.attach(7); //for servo
  bottomServo.attach(8); //for servo
  Serial.begin(57600);
}
void loop() {
  
  topServo.write(99); //where the head is initially taking the candy
  delay(750);
  
  for(int i = 99; i > 48; i--) { //the head moves to the color sensor
    topServo.write(i);
    delay(5);
  }
  delay(250);

  //read 3 times if an invalid color is found to reduce error in case of reading error
  color = readColor();
  if(color == 0)
    color = readColor();
  if(color == 0)
    color = readColor();
  delay(150);  

  //move the bridge through which candies are redirected to their containers
  switch (color) {

    case 1:
    bottomServo.write(60);
    break;
    case 2:
    bottomServo.write(110);
    break;
    case 3:
    bottomServo.write(160);
    break;

    case 4:
    bottomServo.write(110);
    break;
    case 5:
    bottomServo.write(60);
    break;
    
    case 0:
    bottomServo.write(160);
    break;
  }
  delay(300);
  
  for(int i = 48; i > 25; i--) { //walk the head to the slot through which 
    //the candy is allowed to fall through the bridge that puts it in its container
    topServo.write(i);
    delay(10);
  } 
  delay(300);

  //the head moves to the initial place
  for(int i = 25; i < 75; i++) {
    topServo.write(i);
    delay(1);
  }
  for(int i = 75; i < 99; i++) {
    topServo.write(i);
    delay(5);
  }
  color=0;
}

RGB readOneColor(){
  // Setting red filtered photodiodes to be read
  digitalWrite(S2, LOW);
  digitalWrite(S3, LOW);
  // Reading the output frequency
  frequency = pulseIn(sensorOut, LOW);
  int R = frequency;
  // Printing the value on the serial monitor
  //Serial.print("R= ");//printing name
  //Serial.print(frequency);//printing RED color frequency
  //Serial.print("  ");
  delay(2);
  // Setting Green filtered photodiodes to be read
  digitalWrite(S2, HIGH);
  digitalWrite(S3, HIGH);
  // Reading the output frequency
  frequency = pulseIn(sensorOut, LOW);
  int G = frequency;
  // Printing the value on the serial monitor
  //Serial.print("G= ");//printing name
  //Serial.print(frequency);//printing RED color frequency
  //Serial.print("  ");
  delay(2);
  // Setting Blue filtered photodiodes to be read
  digitalWrite(S2, LOW);
  digitalWrite(S3, HIGH);
  // Reading the output frequency
  frequency = pulseIn(sensorOut, LOW);
  int B = frequency;
  // Printing the value on the serial monitor
  //Serial.print("B= ");//printing name
  //Serial.print(frequency);//printing RED color frequency
  //Serial.println("  ");
  RGB color;
  color.R = R;
  color.G = G;
  color.B = B;
  return color;
}

// Custom Function - readColor()
int readColor() {
  long R = 0, G = 0, B = 0;
  int color = 0;
  RGB aux;

  for(int i = 0; i < 100; ++i){ //read 100 times from 
    //the sensor and make the arithmetic mean for a 
    //lower error and a higher uniformity
    aux = readOneColor();
    R += aux.R;
    G += aux.G;
    B += aux.B;
  }
  R /= 100;
  G /= 100;
  B /= 100;


  Serial.print(R);//printing RED color frequency
  Serial.print(" ");

  Serial.print(G);//printing RED color frequency
  Serial.print(" ");

  Serial.print(B);//printing RED color frequency
  Serial.print(" ");

  //Serial.print(numberOfNothing);//printing RED color frequency
  //Serial.print(" ");

  if(step == 1){

    if(R>=95 && R<=114 && G>=105 && G<=125 && B>=80 && B<=101){
      color = 5; // Brown
      numberOfNothing = 0;
    }
    if(R>=59 && R<=83 && G>=75 && G<=100 && B>=75 && B<=102){
      color = 4; // Yellow
       numberOfNothing = 0;
    }
    if(R>=87 && R<=100 && G>=94 && G<=106 && B>=74 && B<=85){
      numberOfNothing++;
    }

    if(numberOfNothing >= 13) {
      step++;
      delay(500);
      numberOfNothing = 0;
      for(int i = 0; i < 5; i++) {
        bottomServo.write(60);
        delay(300);
        bottomServo.write(160);
        delay(300);
      }
      delay(5000);
    }
  }
  else
    if(step == 2){
      
      if(R>=73 && R<=92 && G>=103 && G<=127 && B>=85 && B<=105){
        color = 1; // Red
        numberOfNothing = 0;
      }
      if(R>=83 && R<=99 && G>=83 && G<=100 && B>=74 && B<=89){
        color = 2; // Green
        numberOfNothing = 0;
      }
      if (R>=95 && R<=115 && G>=94 && G<=112 && B>=65 && B<=80){
        color = 3; // Blue
        numberOfNothing = 0;
      }
      if(R>=87 && R<=100 && G>=95 && G<=148 && B>=67 && B<=98){
      numberOfNothing++;
    }

    if(numberOfNothing >= 13) {
      step++;
      delay(500);
      numberOfNothing = 0;
      for(int i = 0; i < 5; i++) {
        bottomServo.write(60);
        delay(300);
        bottomServo.write(160);
        delay(300);
      }
    }
  }

  if(step == 3) // finish
    while(1);
  
  Serial.println("");
  return color;  
}
