#!/usr/bin/python

import os
import time
import subprocess
from time import strftime

# EV level
photo_ev = 0

# Photo dimensions and rotation
photo_width  = 640
photo_height = 480
photo_rotate = 90

photo_interval = 0.01 # Interval between photos (seconds)
photo_counter  = 0    # Photo counter

# Lets start taking photos!
try:

  print "Starting photo sequence"

  for ex in range(0,20):
    photo_counter = photo_counter + 1
    filename = '/home/pi/GPIObuttonphotoshutdown/photo_' + strftime("%Y-%m-%d__%H_%M_%S") + '.jpg'
    cmd = 'raspistill -o ' + filename + ' -t 500' + ' -ev ' + str(photo_ev) + ' -w ' + str(photo_width) + ' -h ' + str(photo_height) + ' -rot ' + str(photo_rotate)
    pid = subprocess.call(cmd, shell=True)
    print ' [' + str(photo_counter) + ' of 60'+'] ' + filename    
    time.sleep(photo_interval)
  
  print "Finished photo sequence"
  
except KeyboardInterrupt:
  # User quit
  print "\nGoodbye!"