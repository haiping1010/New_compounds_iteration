

fr=open('gen0.smi','r')


arr=fr.readlines()

i=0
ii=0
fw=open('gen0'+str(ii)+'.smi','w')
for name in arr:
    i=i+1
    newname=name.strip()+'\t'+'CHEMID'+str(i)+'\n'
    fw.write(newname)

    if i%100000==0:
        ii=ii+1
        fw.close()
        fw=open('gen0'+str(ii)+'.smi','w')


fw.close()
