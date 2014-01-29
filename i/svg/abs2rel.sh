#!/bin/bash

# REMOVE SODIPODI IMAGE LINKS

 for SVG in `ls *.svg`
  do
     sed -i 's/sodipodi:absref=".*"//g' $SVG
 done

exit 0;

