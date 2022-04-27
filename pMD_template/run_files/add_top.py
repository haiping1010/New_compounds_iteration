
import sys
name=sys.argv[1]


fr=open("topol.top",'r')

arrlines=fr.readlines()


fw=open("topol_n.top",'w')

addline='#include \"' + name + '_GMX.itp\"'
addline2=name + '   1'
addline_restr='; Include Position restraint file \n#ifdef T_POSRES \n#include \"termi_posre.itp\" \n#endif'

for line in arrlines:
    if line.startswith('#include ')   and 'forcefield.itp' in line:
         fw.write(line)
         fw.write(addline)
    elif line.startswith('Protein             1'):
         fw.write(line)
         fw.write(addline2+'\n')
    elif  line.startswith('; Include water topology') :
         fw.write(addline_restr+'\n')
         fw.write('\n')
         fw.write(line)   
    else:
          fw.write(line)

fr_gro=open('1AKI_processed.gro','r')

fr_groL=open(name+'_GMX.gro','r')

arr_gro=fr_gro.readlines()
arr_groL=fr_groL.readlines()

fw_gro=open('1AKI_processed_n.gro','w')


print arr_gro[1].strip(), arr_groL[1].strip()
countall=int(arr_gro[1].strip()) + int(arr_groL[1].strip())

end=arr_gro[-1]
print end
print countall

i=0
for line  in arr_gro:
    i=i+1
    if  i==2:
        print countall
        fw_gro.write(str(countall)+'\n')
    elif line == end:
        for line2 in arr_groL:
            #if  '    1 '  in line2:
            if line2.startswith('    1 '):
                fw_gro.write(line2)
        fw_gro.write(line)
        print line
    else :
        fw_gro.write(line)






