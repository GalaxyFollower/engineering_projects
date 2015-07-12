#!/usr/bin/env python

import time
import RPi.GPIO as GPIO
import os
import subprocess

def main():

    # tell the GPIO module that we want to use the 
    # chip's pin numbering scheme
    GPIO.setmode(GPIO.BCM)

    # setup pin 25 as an output
    GPIO.setup(23,GPIO.IN)
    GPIO.setup(24,GPIO.OUT)
    GPIO.setup(25,GPIO.OUT)


    GPIO.output(25,True)

    button_counter=0
    take_photo=0

    while True:
        if GPIO.input(23):
             # the button is being pressed, so turn on the green LED
             # and turn off the red LED
             GPIO.output(24,True)
             GPIO.output(25,False)
             print "button true"
             button_counter=0
             if take_photo > 0:
                  take_photo=0
                  time.sleep(3)
                  os.system("sudo python /home/pi/GPIObuttonphotoshutdown/pi_camera_options.py")
        else:
             # the button isn't being pressed, so turn off the green LED
             # and turn on the red LED
             button_counter = button_counter + 1
             take_photo=1
             if button_counter > 50:
                  os.system("sudo shutdown -h now")
             GPIO.output(24,False)
             GPIO.output(25,True)
             print "button false"


        time.sleep(0.1)

    print "button pushed"

    GPIO.cleanup()



if __name__=="__main__":
    main()


## script from http://raspberrywebserver.com/gpio/detecting-a-button-press-through-GPIO.html
## i want it so that camera is when come back from else, 
## need counter so that if button held down for 20 rounds then shutdown
## need some variable that starts as one, is made zero in else, then in the if statement
## says if less thatn one , add one, then photoscript
