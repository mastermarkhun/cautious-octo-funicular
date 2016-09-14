//caseled

const int led = 9;
int idle = 10;
int active = 64;
int incomingByte;
bool firstTry = true;

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
  pinMode(A0,INPUT);
  pinMode(A1,INPUT);
  pulse(255, 1);
}

void loop() {
  int pwrSensor = digitalRead(A1);
  if (pwrSensor == HIGH) {
    firstTry = true;
    analogWrite(led, idle);
    hddActivity();
    serialRead();
  } else {
    slowPulse();
  }
  delay(10);
}

void hddActivity() {
  int sensorValue = digitalRead(A0);
  if (sensorValue == HIGH) {
    analogWrite(led, active);
  }  
}

void serialRead() {
  if (Serial.available() > 0) {
    incomingByte = Serial.parseInt();
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

void slowPulse() {
  if (firstTry == true) {
    firstTry = false;
    analogWrite(led, 0);
    delay(5000);
  } else {
    pulse(64, 50);
  }
  delay(250);
}

