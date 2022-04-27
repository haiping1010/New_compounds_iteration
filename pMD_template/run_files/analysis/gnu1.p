set term png
 set output "printme.png"
 set pm3d 
 set xlabel "Stem 1 coordination number"
 set ylabel "Stem 2 coordination number"
 set size square
 #set xrange [241.42:334.301]
 #set yrange [372.322:510.633]
 
 
 #set cbrange [-1:0]
 
 #set palette defined (-1  "blue" , 0 "white")
 #set palette defined (-1 "white", -1.5 "yellow", -2 "orange", -2.5 "red", -3  "blue" )
 
 set  contour
 set view map
 #set cbrange [f(-10):f(10)] # [0:1]
 set cntrp lev incremental -20,4.,1000.
 unset clabel 
 spl 'fes.dat' u 1:2:3 with image
 
 
 