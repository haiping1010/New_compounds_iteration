for name in   ????_poc_ter_out.pdb
do
base=${name%_poc_ter_out.pdb}

mkdir $base'_run'

cp -r run_files/*  $base'_run'/

cp -r  pocket_n/$base'_lig.acpype'/$base'_lig_GMX.gro'   pocket_n/$base'_lig.acpype'/$base'_lig_GMX.itp'  pocket_n/$base'_lig.acpype'/$base'_lig_GMX.top'   $base'_run'/

cp -r pocket_n/$base'_poc_ter_out.pdb'   $base'_run'/

cd $base'_run'/

bash run2.bash $base
#bash  gromac2.sh
nohup bash  gromac2.sh   &


cd ..

done
