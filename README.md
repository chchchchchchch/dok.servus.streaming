Documentation is written collaboratively in etherpad
document and converted to a pdf file using LaTeX

https://etherpad.servus.at/p/streamdoku


USED SOFTWARE
-------------

- GNU coreutils 8.12.197-032bb
- texlive/pdflatex
- **pandoc**


Custom Etherpad Options 
-----------------------

- lines starting with % will be excluded

- % GRAFIK: filename
- % FULLPAGE: filename 

-> checks for graphics stored as pdf files
   stored inside [i/pdf](https://github.com/lafkon/dok.servus.streaming/tree/master/i/pdf) 
   and if a file exists, it will be include with the 
   custom LaTeX commands \grafik{filename}/\fullpage{}

   pdf files may excluded from the repository to
   save git space and can be exported from svg files inside
   [i/svg](https://github.com/lafkon/dok.servus.streaming/tree/master/i/svg)
  
