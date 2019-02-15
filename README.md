# Humidity Control

## Summary

Monitors humidity sensors.

## Synopsis

    Usage: humidity_control [options]
      -h, --help                       Display this screen

    Configuration:
    - (1) file as specified by environment variable HUMIDITY_CONTROL_CONFIG_FILE,
    - (2) /data/.config.

## Description

Monitors an ESP32 microcontroller which provides humidity data given by an FC37 humidity sensor via a webservice. Respective ESP32 software can be found here:

    /Users/ms1/Programmierung/Arduino/esp32_humidity_server/esp32_humidity_server.ino

## Configuration

Needs a YAML configuration file either in `/data/.config` or as specified by the environment variable `HUMIDITY_CONTROL_CONFIG_FILE`.

## TODO

Following points need to be taken care of:

* If sensor is up after being not available, sent status update
* Update config: Time to send status SMS
* Optimize / seperate output: a) humidity control (program), b) ESP32 (sensor)
* Handle multiple sensors
* Rescue IOError and redo while alerting
* Overwrite LOGGER.warn with @@warnings += 1?
  