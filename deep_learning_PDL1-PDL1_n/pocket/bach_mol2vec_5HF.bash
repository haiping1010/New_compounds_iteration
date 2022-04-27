source activate my-rdkit-env
for name in   HF 
do
cd $name


for file in ????.smi
do
nohup python ../readsmi.py $file &
#nohup bash ../part1.bash  $base &
#babel -isdf  $file  -osmi $base'.smi'
sleep 1s

##mol2vec featurize -i $base'.smi'  -o  $base'.csv' -m ../models/model_300dim.pkl --uncommon UNK -r 1
done
sleep 3s

for file in ZINC*.smi
  do
base=${file%.smi}
nohup bash ../part1.bash  $base &

sleep 0.8s
done


cd ..
echo $name
done

