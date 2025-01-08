# AquaTrack

## Overview

This project is a smart water bottle designed to monitor and track water intake using sensors and provide personalized hydration recommendations. The system uses copper tapes for measuring water levels, an ESP32 microcontroller for data processing, and Type-C charging for power supply. The mobile application is built using Flutter and offers personalized water intake recommendations based on user data such as age, height, weight, gender, and activity level.

## Features

- **Water Level Measurement**: The system uses copper tapes to measure the water level inside the bottle.
- **Personalized Hydration Recommendations**: The app calculates and provides water intake recommendations based on:
  - Age
  - Height
  - Weight
  - Gender
  - Activity Level
- **Mobile App**: Developed using Flutter, providing an intuitive user interface for tracking and managing water intake.
- **ESP32 Integration**: The ESP32 microcontroller is used for data processing and communication between the water bottle sensors and the mobile application.
- **Type-C Battery Charging**: The bottle is equipped with Type-C charging for efficient and fast power management.

## Hardware

- **Water Level Sensors**: Copper tapes are used to detect the water level in the bottle.
- **Microcontroller**: ESP32 is used for reading sensor data and sending it to the mobile app.
- **Power**: Type-C USB charging port is used for charging the bottle's battery.

## Software

### Flutter App

- **Flutter Framework**: The mobile app is built using Flutter to provide a cross-platform solution for iOS and Android.
- **User Data**: The app collects and uses data (age, height, weight, gender, and activity level) to provide personalized water intake recommendations.
- **Water Intake Tracking**: The app tracks the water level in real time and notifies the user to drink more water when the intake is low.

### ESP32 Firmware

- **Sensor Interface**: Reads the water level from the copper tape sensors.
- **Communication**: Sends the sensor data to the Flutter mobile app via Bluetooth or Wi-Fi.

## Installation

### Hardware Setup

1. **Copper Tape Setup**: Attach copper tapes to the water bottle at specific height levels to measure the water level.
2. **ESP32**: Flash the firmware onto the ESP32 microcontroller.
3. **Power Supply**: Connect the Type-C charging port for battery charging.

### Software Setup

1. Clone the repository or download the source code for both the Flutter app and ESP32 firmware.
2. Follow the installation instructions for Flutter on your machine: [Flutter Installation](https://flutter.dev/docs/get-started/install)
3. Set up the ESP32 development environment. You can find instructions for this here: [ESP32 Setup](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/)
4. Compile and upload the ESP32 firmware to the microcontroller.
5. Build and run the Flutter app on your device.

## Usage

1. **User Registration**: Open the Flutter app and register by providing your details (age, height, weight, gender, and activity level).
2. **Water Intake Recommendations**: Based on the information provided, the app will calculate the recommended daily water intake.
3. **Monitor Water Level**: The app will continuously monitor the water level in the bottle, providing alerts when it's time to drink more water.

