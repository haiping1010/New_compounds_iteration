for name in mp_data_gen0?
do
echo $name
nohup  python  deep_dense_FC_load.py  $name > $name'_predict.log' 2>&1&

sleep 4s
done



