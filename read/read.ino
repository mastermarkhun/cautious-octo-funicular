//read

const int led = 9;
int idle = 10;
int brightness = 64;
int incomingByte;

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
  pulse();
}

void loop() {
  analogWrite(led, idle);
  
  int sensorValue = digitalRead(A0);

  if (sensorValue == HIGH) {
    analogWrite(led, brightness);
  }

  if (Serial.available() > 0) {
    incomingByte = Serial.parseInt();
      if (incomingByte == 0) {
        brightness = 0;
        idle = 0;
        pulse();
      } else {
        brightness = 64;
        idle = 10;
        pulse();
      }
  }
  
  delay(10);
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

