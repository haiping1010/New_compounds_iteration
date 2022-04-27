for name in   f870-0339_run  f870-0956_run  f870-0968_run  f871-0960_run  v013-9764_run
do 

	
cd $name


setsid  bash   gromac2_extend.sh    &


cd ..



done
