
import sys
filename=sys.argv[1]

fr=open(filename,'r')

filebase=filename.replace('_poc_ter.pdb','')

arr=fr.readlines()
mapid={}
index=0
for name in arr:
    if  name[17:20] == 'ACE' :
        index=index+1
        mapid[filebase+str(index)]= name[22:26].replace(' ','')


for key, value in  mapid.items():
    print(key, ' : ', value)

frr=open(filebase+'_npt2_out_n.pdb')

arr2=frr.readlines()

index=0
allarr=[]
old='CH3 ACE'
for name in arr2:
    if  name[13:20] == 'CH3 ACE':
        index=index+1
        length=len(mapid[filebase+str(index)])
        begin=26-length
        print name[begin:26]
        print mapid[filebase+str(index)]
        #name[begin:26] = list(mapid[filebase+str(index)])
        newname=name[:begin]+mapid[filebase+str(index)]+name[26:]
        print newname
        old=name[17:26]
        resid=int(mapid[filebase+str(index)])
        old_resid=resid
    elif  name[17:26] != old  and index>0:
        resid=old_resid+1
        newname=name[:begin]+str(resid)+name[26:]
        old=name[17:26]
        old_resid=resid
    elif  name[17:26] == old  and index>0:
        newname=name[:begin]+str(old_resid)+name[26:]
        old=name[17:26]
    else :
        newname=name
    allarr.append(newname)
fww=open(filebase+'_npt2_out_n_f.pdb','w')
for name in allarr:
    fww.write(name)



