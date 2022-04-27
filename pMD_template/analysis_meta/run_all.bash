

cd ../
for name in    *_run
do

	cd $name
rm fes.dat
plumed sum_hills --hills HILLS   --mintozero

cp fes.dat   ../analysis_meta/$name'_fes.dat'

cd ..


done
