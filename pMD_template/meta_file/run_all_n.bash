cd ..

for folder in {1..8}???-????_run
#for folder in  f8??-????_run
do

cd $folder


cp  -r  /home/zhanghaiping/work/pMD_run_redo_li_meta/meta_file/prod.mdp   /home/zhanghaiping/work/pMD_run_redo_li_meta/meta_file/gromac_meta.bash   /home/zhanghaiping/work/pMD_run_redo_li_meta/meta_file/plumed.dat    .


nohup bash gromac_meta.bash &

sleep 5h


cd  ..

done



