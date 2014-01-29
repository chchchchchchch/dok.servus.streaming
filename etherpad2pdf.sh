#!/bin/bash

  TMPTEX=`date +%s`.tex; TMPDIR=tmp; rm $TMPDIR/*.* ; FORKABLE=i/a  

  GRAFIKSTART="\\\grafik{i/pdf/" 
  GRAFIKEND="}"

  FULLPAGESTART="\\\fullpage{i/pdf/" 
  FULLPAGEEND="}"

  PAD2HTMLURL=https://etherpad.servus.at/p/streamdoku/export/txt
  DUMP=dump.md
  MD2TEX=md2tex.tex

  wget $PAD2HTMLURL --no-check-certificate -O $DUMP
  
   cat $DUMP |
  sed "s,% GRAFIK: ,$GRAFIKSTART,g" |           # OPEN GRAFIK TAG
  sed "/grafik/s/$/$GRAFIKEND\n/g"|             # CLOSE GRAFIK TAG
  sed "s,% FULLPAGE: ,$FULLPAGESTART,g" |       # OPEN FULLPAGE TAG
  sed "/fullpage/s/$/$FULLPAGEEND\n/g"|         # CLOSE FULLPAGE TAG
  grep -v ^% |                                  # REMOVE LINES STARTING WITH %
  pandoc -f markdown -t latex > md2tex.tex

  rm $DUMP

  for GRAFIK in `egrep "$GRAFIKSTART|$FULLPAGESTART" $MD2TEX | \
                 cut -d "{" -f 2 | cut -d "}" -f 1`
   do
      if [ -f ${GRAFIK}.pdf ]; then

           echo ${GRAFIK}.pdf "exists"
      else
          echo ${GRAFIK}.pdf "does not exist"
          sed -i "s,^.*grafik.*${GRAFIK}.*$,,g"   $MD2TEX
          sed -i "s,^.*fullpage.*${GRAFIK}.*$,,g" $MD2TEX
      fi
  done


  INPUT=md2tex.tex

  echo "\documentclass[8pt,cleardoubleempty]{scrbook}"            >  $TMPTEX
  echo "\usepackage[utf8]{inputenc}"                              >> $TMPTEX
  echo "\usepackage{i/sty/A5}"                                    >> $TMPTEX
  echo "\usepackage{i/sty/140129}"                                >> $TMPTEX
  echo "\setlength\textheight{170mm}"                             >> $TMPTEX
  echo "\setlength\topmargin{-17mm}"                              >> $TMPTEX

  echo "\setlength\textwidth{95mm}"                               >> $TMPTEX
  echo "\setlength\oddsidemargin{0mm}"                            >> $TMPTEX
  echo "\setlength\evensidemargin{0mm}"                           >> $TMPTEX

   echo "\parindent=0pt"                                          >> $TMPTEX

   echo "\begin{document}"                                        >> $TMPTEX

   echo "\titlepages{%"                                           >> $TMPTEX
   echo "\url{http://etherpad.servus.at/p/streamdoku}}"           >> $TMPTEX
   echo "{}{}"                                                    >> $TMPTEX
   echo "\hardpagebreak"                                          >> $TMPTEX

#  # http://www.mrunix.de/forums/showthread.php?t=37247
#  # Keine "Schusterjungen"
#  echo "\clubpenalty = 10000"                                    >> $TMPTEX
#  # Keine "Hurenkinder"
#  echo "\widowpenalty = 10000 \displaywidowpenalty = 10000"      >> $TMPTEX

   echo "\input{"$INPUT"}"                                        >> $TMPTEX

   echo "\end{document}"                                          >> $TMPTEX
#  =========================================================================  #

  pdflatex -output-directory o $TMPTEX 

  cp o/${TMPTEX%%.*}.pdf latest.pdf

  rm o/${TMPTEX%%.*}.idx o/${TMPTEX%%.*}.aux \
     o/${TMPTEX%%.*}.log o/${TMPTEX%%.*}.out \
     $TMPTEX $MD2TEX


exit 0;
