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


fw=open('selected.smi', 'w')
for name in arr:
    tem_arr=name.split()
    print (maping[tem_arr[0]])
    fw.write(maping[tem_arr[0]]+'\n')


'''
for name in arr:
    tem_arr=name.split()
    for newname in arr2:
        tem_arr2=newname.split('\t')
        if tem_arr[0] == tem_arr2[1]:
            print (newname)
            break
'''
