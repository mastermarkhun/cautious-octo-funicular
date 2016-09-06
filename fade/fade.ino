//fade

int led = 9;
int led2 = 10;
int brightness = 0;
int brightness2 = 250;
int fadeAmount = 5;
int fadeAmount2 = 5;

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
  pinMode(led2, OUTPUT);
}


void loop() {
  analogWrite(led, brightness);
  brightness = brightness + fadeAmount;
  if (brightness <= 0 || brightness >= 255) {
    fadeAmount = -fadeAmount;
  }

  analogWrite(led2, brightness2);
  brightness2 = brightness2 + fadeAmount2;
  if (brightness2 <= 0 || brightness2 >= 255) {
    fadeAmount2 = -fadeAmount2;
  }

  delay(30); 
}
