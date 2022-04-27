
cat mp_data_gen0?/sorted_out.txt  > all_out.list

sort -g -rk 2,2 all_out.list  > all_out.sort

awk ' $2 >= 0.99 ' all_out.sort  >  all_out_select.sort

