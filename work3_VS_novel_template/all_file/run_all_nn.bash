#rm selected.smi
#python choose_sel.py  all_out_select_0.998.sort  gen_all.smi
#python  convert_smi_sdf.py
bash   run_QED.bash

bash cp_file.bash
