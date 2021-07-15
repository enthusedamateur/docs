# Identifying a Raspberry Pi

On at least a Pi 3, you can turn the green (SD card activity) LED to be on constantly with the following command (as root):

    echo 1 > /sys/class/leds/led0/brightness

Now that Pi will have the green LED on steady, which makes it very easy to identify and label.

To put the LED back to its default state:

    echo 0 > /sys/class/leds/led0/brightness
    echo mmc0 > /sys/class/leds/led0/trigger

Iterate through all of your Pis this way until you've got them all addressed and labeled accordingly.
