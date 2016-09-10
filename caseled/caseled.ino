//caseled

const int led = 9;
int idle = 10;
int active = 64;
int incomingByte;

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
  pinMode(A0,INPUT);
  pinMode(A1,INPUT);
  pulse();
}

void loop() {
  int pwrSensor = digitalRead(A1);
  if (pwrSensor == HIGH) {
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
      pulse();
    } else {
      active = 64;
      idle = 10;
      pulse();
    }
  }
}

void pulse() {
  for (int x = 0; x <= 255; x++) {
    analogWrite(led, x);
    delay(1);
  }
  for (int x = 254; x >= 0; x--) {
    analogWrite(led, x);
    delay(1);
  }
}

void slowPulse() {
  for (int x = 0; x <= 64; x++) {
    analogWrite(led, x);
    delay(50);
  }
  for (int x = 63; x >= 0; x--) {
    analogWrite(led, x);
    delay(50);
  }
  delay(250);
}

