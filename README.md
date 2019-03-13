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

## Example

Start the control program in the background, write all output to logfile log.txt:

    bin/humidity_control &> log.txt &

## TODO

Following points need to be taken care of:

* If sensor is up after being not available, sent status update
* Update config: Time to send status SMS
* Handle multiple sensors
* Rescue IOError and redo while alerting
* Overwrite LOGGER.warn with @@warnings += 1?
