
for m in ????.pdb 
do
i=${m%.pdb}



echo 0 0 | gmx_mpi rmsf -s $i".pdb" -f $i".pdb"  -fit  -ox $i'xaver.pdb'
echo 0 0 | gmx_mpi  rms -s $i'xaver.pdb' -f $i".pdb"  -fit rot+trans -o $i'avrms.xvg' 


grep -v "^#\|^@" $i'avrms.xvg' > file_tem.txt
nl file_tem.txt > file.txt

sed -i "s/0.0000000    //g"   file.txt


min=1000
while read LINE
do
    fir=`echo $LINE|awk '{print $1}'`
    sec=`echo $LINE|awk '{print $2}'`
st=`echo "$sec < $min" | bc`
    if [ $st -eq 1 ];then
        min=$sec
        minindex=$fir
    fi
done < <(cat file.txt)

minindexint=${minindex%.*}
echo 0 | gmx_mpi  trjconv -s $i".pdb" -f $i".pdb"  -o $i'_av_rep.pdb'  -sep

mv $i'_av_rep'$minindexint'.pdb'   $i"_"$minindexint'_out.pdb'

rm -rf *av_rep*.pdb
#mv $i".pdb" $i"_old.pdb"
#cp -r $i"_"$minindexint'av_rep.pdb' $i".pdb"



#echo 36 37 | /home/zhp/program/gromacs-4.6.5/bin/bin/g_dist -s md2.tpr -f md2.xtc -o $i'domain.xvg' -n index.ndx

#cp $i'xaver.pdb' $i"_"$minindexint'av_rep.pdb' $i'avrms.xvg'  ../AVRAGE


done
