//caseled

const byte led = 9;
const byte hdd = A0;
const byte pwr = A1;
int idle = 10;
int active = 64;
bool firstTry;

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
  pinMode(hdd,INPUT);
  pinMode(pwr,INPUT);
  pulse(255, 1);
}

void loop() {
  int pwrSensor = digitalRead(pwr);
  if (pwrSensor == HIGH) {
    firstTry = true;
    analogWrite(led, idle);
    hddActivity();
    serialRead();
  } else {
    sleep();
  }
  delay(10);
}

void hddActivity() {
  int sensorValue = digitalRead(hdd);
  if (sensorValue == LOW) {
    analogWrite(led, active);
  }  
}

void serialRead() {
  if (Serial.available() > 0) {
    int incomingByte = Serial.parseInt();
    if (incomingByte == 0) {
      active = 0;
      idle = 0;
      pulse(255, 1);
    } else {
      active = 64;
      idle = 10;
      pulse(255, 1);
    }
  }
}

void pulse(int a, int b) {
  for (int x = 0; x <= a; x++) {
    analogWrite(led, x);
    delay(b);
  }
  for (int x = a-1; x >= 0; x--) {
    analogWrite(led, x);
    delay(b);
  }
}

void sleep() {
  if (firstTry == true) {
    firstTry = false;
    analogWrite(led, 0);
    delay(5000);
  } else {
    pulse(64, 50);
  }
  delay(250);
}
