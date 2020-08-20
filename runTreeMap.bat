
@ECHO OFF
SET /A n=0
FOR /L %%i IN (0,1,60) DO (
  java -jar TreeMap3b1243.jar i sample%%i.tree solve test quit > output%%i.txt
  echo %%i
)
::for %i in (*.tree) DO (
::echo %i
:: java -jar  TreeMap3b1243.jar i %i  solve test quit >> TreeMapOutput.txt 
::)
