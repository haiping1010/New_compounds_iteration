#! /bin/bash
export adtpy=/home/zhanghaiping/MGLTools-1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24
export path=/home/zhanghaiping/MGLTools-1.5.6/bin

rm aa.txt

cd receptor

export pdbtool=/home/zhanghaiping/program/pdbTools_0.2.1

for f in *_poc.pdb
do
python $pdbtool/pdb_centermass.py $f > aa.txt

grep  '_poc.pdb'  aa.txt > aaa.txt
a=`cat  aaa.txt`
IFS=' ' read -r -a array <<< $a

echo ${array[0]}
echo ${array[1]}
echo ${array[2]}
echo ${array[3]}


done
cd ..




cd receptor

for f in protein.pdb
do
base=${f%.pdb}
$path/pythonsh $adtpy/prepare_receptor4.py -r $f -o $base".pdbqt"

done

cd ../ligand


for f in *.sdf
do
base=${f%.sdf}

#obminimize -o mol2 $f  > $base'.mol2'

babel -isdf $f -omol2 $base'.mol2'
$path/pythonsh $adtpy/prepare_ligand4.py -l  $base'.mol2' -o   $base".pdbqt"

done

cd ..


######################
rm -rf Docking
mkdir  Docking

#cp -r  ligand/*.pdbqt  .
for  xxx in   ligand/*.pdbqt
do
base1=${xxx%.pdbqt}
base=${base1:7 }
echo $base

echo Docking/$base
mkdir Docking/$base
echo ${array[0]}
vina --config conf.txt --receptor receptor/protein.pdbqt --ligand  $xxx   --center_x ${array[1]} --center_y ${array[2]}  --center_z ${array[3]} --out Docking/$base/$base'_out.pdbqt' --log Docking/$base/log.txt

done





