for name in      CHEMID_1_294721_poc_ter_out.pdb
do
base=${name%_poc_ter_out.pdb}

mkdir $base'_run'

cp -r run_files/*  $base'_run'/
#cp -r run_files/gromac2.sh  $base'_run'/
cp -r  pocket/$base'_lig_n.acpype'/$base'_lig_n_GMX.gro'   pocket/$base'_lig_n.acpype'/$base'_lig_n_GMX.itp'  pocket/$base'_lig_n.acpype'/$base'_lig_n_GMX.top'   $base'_run'/

cp -r pocket/$base'_poc_ter_out.pdb'   $base'_run'/

cd $base'_run'/

bash run2.bash $base
#bash  gromac2.sh
#bash  gromac2.sh

nohup bash  gromac2.sh  &
sleep 20s

cd ..

done
