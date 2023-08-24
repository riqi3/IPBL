#include <ESP8266WiFi.h>
#include <PubSubClient.h>

// Network Setting
const char* ssid = "your-wifi-ssid";
const char* password = "wifi-pass";

// MQTT Setting
const char* mqttServer = "192.168.1.12";
const int mqttPort = 1883;
const char* mqttUser = "test-mqtt";
const char* mqttPassword = "mq1111";
const char* mqttClientId = "esp8266_client";

const char* mqttSubTopic = "room/bed/lights";

WiFiClient espClient;
PubSubClient client(espClient);

void setup() {
  // Initialize the BUILTIN_LED pin as an output
  pinMode(BUILTIN_LED, OUTPUT);

  // Start with LED OFF
  digitalWrite(BUILTIN_LED, HIGH);

  Serial.begin(115200);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("Connecting to WiFi...");
  }

  Serial.println("Connected to the WiFi network");

  client.setServer(mqttServer, mqttPort);
  client.setCallback(callback);
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }

  client.loop();
}

void connect() {
  if (client.connect(mqttClientId, mqttUser, mqttPassword)) {
    Serial.println("Connected to MQTT Broker");

    // When connected, broadcast an announcement that client is connected
    client.publish(mqttSubTopic, "Hello from ESP8266");
    client.subscribe(mqttSubTopic);
  } else {
    Serial.print("Failed with state: ");
    Serial.println(client.state());

    // Wait for 5 seconds before trying to connect once more
    delay(5000);
  }
}

void reconnect() {
  // Loop until we are connected back
  while (!client.connected()) {
    Serial.println("Attempting to connect to MQTT Broker...");

    // Attempt to connect back
    connect();
  }
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived in topic: ");
  Serial.println(topic);

  Serial.print("Message: ");

  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }

  if ((char)payload[0] == '1') {
    // Turn the LED on (LOW is the voltage level) but actually the LED is on.
    // This is because it is active low on the ESP-01
    digitalWrite(BUILTIN_LED, LOW);
  } else {
    // Turn off the LED by making the voltage HIGH
    digitalWrite(BUILTIN_LED, HIGH);
  }

  Serial.println();
  Serial.println("--------------------------------------------------------------");
}
