# Humidity Control

## Summary

Monitors humidity sensors.

## Synopsis

    Humidity Control 0.1.4 (c) Michael Schwarze, 2019.

    Usage: humidity_control [options]
      -h, --help                       Display this screen

    Configuration:
    - (1) file as specified by environment variable HUMIDITY_CONTROL_CONFIG_FILE,
    - (2) /data/.config.

## Description

Monitors an ESP32 microcontroller which provides humidity data given by an FC37 humidity sensor via a webservice. Respective ESP32 software can be found here:

    /Users/ms1/Programmierung/Arduino/esp32_humidity_server/esp32_humidity_server.ino

## Configuration

Needs a YAML configuration file with the following format / content:

    ##
    # Humidity Control's configuration file
    ##
    ---
    environment: 'TEST'
    phone_nbr_from: '+123456789'
    phone_nbr_to: ['+987654321', '+87654321']
    account_sid: <Your Twilio Account SID>
    auth_token: <Your Twilio Authorization Token>
    sensor_url_internal: 'http://localhost:1000'
    sensor_url_external: 'http://localhost:1000'
    nbr_of_retries: 3
    repeat_alarm_pause: 3

It either looks for it in `/data/.config` or as specified by the environment variable `HUMIDITY_CONTROL_CONFIG_FILE`.

## TODO

Following points need to be taken care of:

* Update config: Time to send status SMS
* Class Ready2SendStatusSMS
* Optimize / seperate output: a) humidity control (program), b) ESP32 (sensor)
* Handle multiple sensors
* Rescue IOError and redo while alerting
* Overwrite LOGGER.warn with @@warnings += 1?
  