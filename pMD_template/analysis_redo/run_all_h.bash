cd ../
for name in  *_run
do

cd $name

bash ../run_ana_h_ns.bash


for filename in hbond.xvg
do
   base=${filename%.xvg}
   cp -r  $filename   ../analysis_redo/$name'_'$filename

done


cd  ..


done

