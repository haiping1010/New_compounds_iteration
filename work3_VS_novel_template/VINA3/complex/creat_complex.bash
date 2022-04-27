cd ../Docking
for name  in *
do

echo $name
cp -r $name/$name'_out.pdbqt'  ../complex/

babel -ipdbqt  ../complex/$name'_out.pdbqt'   -opdb  ../complex/$name'out.pdb' -m

cp -r  ../receptor/protein.pdb  ../complex/

cat  ../complex/protein.pdb   > ../complex/$name'_complex.pdb'

echo   "TER"  >> ../complex/$name'_complex.pdb'
cat  ../complex/$name'out1.pdb'  >> ../complex/$name'_complex.pdb'

done
