cd ../
for name in   CHEMID*_run
	
#MD_CHMFL-BMX-078           MD_GNF-7               MD_tg101209  MD_dcc-2036    MD_Golvatinib   MD_Torin_1
#MD_DDR1-IN-2                         MD_k_0859_complex      MD_um-164 MD_Dehydroandrographolide_succinate  MD_masitinib           MD_ZCL_278  MD_Fedratini                         MD_nilotinib          MD_fenretinide                       MD_Nilotinib_complete
do

cd $name

#bash ../run_ana_redo.bash
bash ../run_ana_redo.bash

for filename in *_lig.xvg
do
   base=${filename%_lig.xvg}
   cp -r $base'_CA.xvg'  ../analysis_redo/$name'_'$base'_CA.xvg'
   cp -r  $filename   ../analysis_redo/$name'_'$filename
   cp -r npt2_out.xtc  ../analysis_redo/$name'_npt2_out.xtc'
   cp -r npt2.gro  ../analysis_redo/$name'_npt2_out.gro'
done


cd  ..


done

