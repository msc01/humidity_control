# Humidity Control

## Summary

Monitors humidity sensors.

## Synopsis

    humidity_control [options]
    -h, --help              Shows this information.

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
    phone_nbr_to: '+987654321'
    account_sid: <Your Twilio Account SID>
    auth_token: <Your Twilio Authorization Token>
    sensor_url: 'http://localhost:1000'
    nbr_of_retries: 3

It either looks for it in `/data/.config` or as specified by the environment variable `HUMIDITY_CONTROL_CONFIG_FILE`.

## TODO

Following points need to be taken care of:

* Alert to mulitple phone nbrs.
* Rescue IOError and redo while alerting
* Overwrite LOGGER.warn with @warnings += 1?
  