# Humidity Control

## Summary
Monitor humidity sensors.

## Synopsis
	humidity_control[options]
    -h, --help				Shows this information.
	
## Description
Monitors an ESP32 microcontroller which provides humidity data given by an FC37 humidity sensor via a webservice:

    /Users/ms1/Programmierung/Arduino/esp32_humidity_server/esp32_humidity_server.ino


## Configuration
Needs a YAML configuration file with the following format / content:

    ##
    # Humidity Control's configuration file
    # PRODUCTION
    ##
    ---
    phone_nbr_from: '+123456789'
    phone_nbr_to: '+987654321'
    account_sid: <Your Twilio Account SID>
    auth_token: <Your Twilio Authorization Token>

It either looks for it in `/data/.humidity_control.config` or as specified by the environment variable `CONFIG_FILE`.

## TODO
Following points need to be taken care of:

* Optimize output format
 * Add sensor metadata (IP, sensor type, etc.)
