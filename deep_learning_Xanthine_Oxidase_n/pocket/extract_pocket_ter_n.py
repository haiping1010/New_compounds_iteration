import sys
import numpy as np



Pposition={}
Lposition={}
ResinameP={}
ResinameL={}
Atomline=[]
residuePair=[]




C_oldline={}
N_newline={}

oldline_key={}
newline_key={}

filebase=sys.argv[1]

####oldline is the line before current line and with type of O

### N_newline[old_in]  is the line after old_in line with type of N


oldline=[]
old_in=''
oldkey=''
for line in open('RDRP_w.pdb'):
    tem_B=' '
    if len(line)>16:
       tem_B=line[16]
       line=line[:16]+' '+line[17:]
    #print(line)
    list_n = line.split()
    id = list_n[0]
    if id == 'ATOM' and list_n[2] == 'C' and tem_B !='B':
        list_n[5]=line[22:26].replace(' ','')
        type = list_n[2]
        #if type == 'CA' and list_n[3]!= 'UNK':
        if  list_n[3]!= 'UNK':
            residue = list_n[3]
            type_of_chain = line[21:22]
            tem1=line[22:26].replace("A", "")
            tem2=tem1.replace("B", "")
            tem2=tem2.replace("C", "")

            #tem2=filter(str.isdigit, list_n[5])
            atom_count = tem2+line[21:22]
            #list_n[5]=line[22:26].replace(' ','')
            C_oldline[residue+list_n[5]+list_n[4]]=oldline
            oldline_key[residue+list_n[5]+list_n[4]]=oldkey
            #print line
            #print C_oldline[residue+list_n[5]+list_n[4]]
            oldline=line
            oldkey=residue+list_n[5]+list_n[4]

    if id == 'ATOM' and  list_n[2] == 'N' and tem_B !='B':
        list_n[5]=line[22:26].replace(' ','')
        if  list_n[3]!= 'UNK':
            residue = list_n[3]
            type_of_chain = line[21:22]
            tem1=line[22:26].replace("A", "")
            tem2=tem1.replace("B", "")
            tem2=tem2.replace("C", "")

            #tem2=filter(str.isdigit, list_n[5])
            atom_count = tem2+line[21:22]

            N_newline[old_in]=line
            newline_key[old_in]=residue+list_n[5]+list_n[4]
            #print line
            #print old_in
            old_in=residue+list_n[5]+list_n[4]



for line in open('RDRP_w.pdb'):
    tem_B=' '
    if len(line)>16:
       tem_B=line[16]
       line=line[:16]+' '+line[17:]
    #print(line)
    list_n = line.split()
    id = list_n[0]
    if id == 'ATOM' and tem_B !='B':
        list_n[5]=line[22:26].replace(' ','')
        type = list_n[2]
        #if type == 'CA' and list_n[3]!= 'UNK':
        if  list_n[3]!= 'UNK':
            residue = list_n[3]
            type_of_chain = line[21:22]
            tem1=line[22:26].replace("A", "")
            tem2=tem1.replace("B", "")
            tem2=tem2.replace("C", "")

            #tem2=filter(str.isdigit, list_n[5])
            atom_count = tem2+line[21:22]
            list_n[6]=line[30:38]
            list_n[7]=line[38:46]
            list_n[8]=line[46:54]
            position = list_n[6:9]
            Pposition[atom_count]=position
            ResinameP[atom_count]=residue+list_n[5]+list_n[4]
            resindex=residue+list_n[5]
            Atomline.append(line)
index_nn=0            
for line in open(filebase+'_lig.mol2'):
    tem_B=' '
    line=line.strip()
    #print(line)
    if line == "@<TRIPOS>ATOM":
        index_nn=1
        #print(line)
    if line == "@<TRIPOS>BOND":
        index_nn=0 
    if index_nn==1 and line != "@<TRIPOS>ATOM":
            list_n = line.split()
            #tem2=filter(str.isdigit, list_n[5])
            atom_count = list_n[0]+list_n[5]
            position = list_n[2:5]
            Lposition[atom_count]=position
            ResinameL[atom_count]=list_n[5]
			
			
#-------------------------------------------------

for key1, value1 in Pposition.items():
   #print ( value1)
   for key2, value2 in Lposition.items():
           #print (ResinameE[key], 'corresponds to', value)
           ##distance=pow(value1[0]-value2[0])
            #print (value2)
            a = np.array(value1)
            a1 = a.astype(np.float)
            b = np.array(value2)
            b1 = b.astype(np.float)
            xx=np.subtract(a1,b1) 
            tem=np.square(xx)
            tem1=np.sum(tem)
            out=np.sqrt(tem1)
            #print (tem1)
            if out<10 :
                residuePair.append(ResinameP[key1])
                #print (ResinameP[atom_count])  
#---------------------------------------------------------------------                
#print (antiface) 
order_arr=[]
foo = open(filebase + "_poc_ter.pdb", "w")


import pandas as pd
tem_arr=pd.Series(residuePair).drop_duplicates().tolist()



for  value1 in Atomline:
    list_n2 = value1.split()
    list_n2[5]=value1[22:26].replace(' ','')
    resnameId=list_n2[3]+list_n2[5]+list_n2[4] 
    for value2 in tem_arr:
        if  value2 == resnameId : 
                 order_arr.append(value2) 

                 
final_arr=pd.Series(order_arr).drop_duplicates().tolist()
#final_arr=set( sorted(set(order_arr),key=order_arr.index)  )



for value2 in final_arr:
    if oldline_key[value2] not in final_arr :
                 tem=list(C_oldline[value2])
                 tem[17:20]='ACE'
                 foo.write(''.join(tem))
    for  value1 in Atomline:  
        list_n2 = value1.split()
        list_n2[5]=value1[22:26].replace(' ','')
        resnameId=list_n2[3]+list_n2[5]+list_n2[4] 
        if  value2 == resnameId : 
                 #print value1 
                 foo.write(value1 )
    
    if   value2  in newline_key.keys():
        if newline_key[value2] not in final_arr:
                 tem=list(N_newline[value2])
                 tem[17:20]='NHE'
                 foo.write(''.join(tem))
                 print value2
                 


