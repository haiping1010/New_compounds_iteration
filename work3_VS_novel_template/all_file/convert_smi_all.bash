source activate my-rdkit-env

for  name in   gen0?.smi
do

base=${name%.smi}
#grep -v 'StrEd'  $name  > $base'_n.smi'

#nohup 
mol2vec featurize -i        $base'.smi'  -o  $base'_n.csv'     -m  /home/zhanghaiping/model_300dim.pkl   --uncommon UNK -r 1 
#&
#sleep 2s

done
