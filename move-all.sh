#!/bin/bash

# move all the files which matches the regex from nested directories without using much system call 
find  "folder 1"/ -type f -name  "*.jpg" -exec  mv -v "folder2"/ {} +


