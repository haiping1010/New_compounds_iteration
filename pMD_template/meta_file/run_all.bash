cd ..

#for folder in 4076-????_run
#for folder in  1???-????_run  {3..4}???-????_run  8???-????_run
for folder in    CHEMID_1_294721_run
do

cd $folder


cp  -r   ../meta_file/prod.mdp   ../meta_file/gromac_meta.bash   ../meta_file/plumed.dat    .

#bash gromac_meta.bash

nohup bash gromac_meta.bash &

sleep 100s
cd  ..

done



