import sys

file1=sys.argv[1]
file2=sys.argv[2]


fr=open(file1,'r')

fr2=open(file2,'r')

arr=fr.readlines()
arr2=fr2.readlines()
maping={}
for newname in arr2:
        tem_arr2=newname.split('\t')
        maping[tem_arr2[1].strip()]=newname.strip()


fw=open('retrain_withname.smi', 'w')
fw2=open('retrain.smi', 'w')

for name in arr:
    tem_arr=name.split()
    print (maping[tem_arr[0]])
    fw.write(maping[tem_arr[0]]+'\n')
    xx_arr=maping[tem_arr[0]].split()
    out=xx_arr[0]
    fw2.write(out+'\n')
fw.close()
fw2.close()


'''
for name in arr:
    tem_arr=name.split()
    for newname in arr2:
        tem_arr2=newname.split('\t')
        if tem_arr[0] == tem_arr2[1]:
            print (newname)
            break
'''
