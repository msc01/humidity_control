# Versioning information:
# - v0.0.1: Initial version.
# - v0.0.2: Improves output and logging format.
# - v0.0.3: Deployed and tested in production.
# - v0.0.4: Improves error handling.
# - v0.0.5: Furter improves error handling.
# - v0.0.6: Introduces Mountebank for imposters and stubs.
# - v0.0.7: Adds environment to config.
# - v0.0.8: Improves & updates Readme.
# - v0.0.9: Improves sensor tests.
# - v0.1.0: First production release.
# - v0.1.1: Retrieves more fields from a sensor.
# - v0.1.2: Optimizes output of uptime.
# - v0.1.3: Send daily info SMS update
# - v0.1.4: Send an info SMS after each alarm and pause for 15 minutes.
# - v0.1.5: Work with multiple to_phone_nbrs
# - v0.1.6: Enhance logging and speech.
# - v0.1.7: Switch daily info SMS from midnight to noon.
# - v0.1.8: Refactor Sensor/Test: Inject current_time annd add tests to #ready_for_status_update?.
# - v0.1.9: Optimize / seperate output: a) humidity control (program), b) ESP32 (sensor).
VERSION = '0.1.9'.freeze
VERSION_INFO = "Humidity Control v#{VERSION} (c) Michael Schwarze, 2019.".freeze
