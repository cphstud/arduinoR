
int tp = 2;
int ep = 4;


long duration;
int distance;

void setup() {
  pinMode(tp,OUTPUT);
  pinMode(ep,INPUT);
  Serial.begin(9600);

}

void loop() {
  //float t = dht.readTemperature();
  // skriv til output-pin - sluk - vent - åben - vent - sluk

digitalWrite(tp,LOW);
delay(2);
digitalWrite(tp,HIGH);
delay(10);
digitalWrite(tp,LOW);

duration = pulseIn(ep, HIGH);
distance = (duration*0.034)/2;
//analogSensor = analogRead(A5);
//Serial.print(distance);
if (distance > 200) {
  distance = 200;
}
Serial.println(distance);

delay(250);
}
