#!/bin/python
import pandas as pd
import numpy as np
from glob import glob
sampleID = "2018022893038"

FileDir = "C:/Users/labge/Documents/%s/CopywriteR/CNAprofiles" % sampleID
RawinfoPath = glob("%s/*segment.data.txt" %(FileDir))[0]
SegmentPath = glob("%s/*segment.output.txt" %(FileDir))[0]
#LT = "EF3-LT-SR-Merged"
#LT = "EF3-LT"
LT = "NS1-LT"
#LT = "LT-LR-Merged"
DiseaseFile = "C:/Users/labge/Documents/DiseaseList.csv"
targetChrom = 16
BIN_size = 25000
Targeting = True
TargetDF = pd.read_csv(DiseaseFile, sep=",", header=0) # read Raw data file
print(TargetDF['Disease_Name'].values)
del DiseaseFile
TargetDisease =  '16p11.2_microduplication_syndrome'    #'2q11.2_deletion_syndrome'  #'3q29_microduplication_syndrome'  #'15q13.3_microdeletion_syndrome' #'15q26_overgrowth_syndrome' # '3q29_microduplication_syndrome' #'16p13.11_recurrent_microdeletion_(neurocognitive_disorder_susceptibility_locus)'  #'Prader-Willi_syndrome'
TargetDF = TargetDF[TargetDF['Chr'] == targetChrom]     # taking only target chromosome data
TargetDF = TargetDF[TargetDF['Chr'] == targetChrom]     # taking only target chromosome data
TargetDF = TargetDF[TargetDF['Disease_Name'] == TargetDisease]

#TargetRange = (TargetDF['Start'].values-1550000, TargetDF['End'].values+2850000)
TargetRange = (TargetDF['Start'].values, TargetDF['End'].values)
#TargetRange = (19775001, 26525000)
del TargetDF
del TargetDisease

SampleDF = pd.read_csv(RawinfoPath, sep="\t", header=0, index_col=0) # read Raw data file
del RawinfoPath
SampleDF = SampleDF[['chrom','maploc', 'ratio.vs.none']]  # slice columns
SampleDF = SampleDF[SampleDF['chrom'] == targetChrom]     # taking only target chromosome data
SampleDF = SampleDF[['maploc', 'ratio.vs.none']]          # resize dataframe

SegmentDF = pd.read_csv(SegmentPath, sep="\t", header=0, index_col=0) # read Raw data file
del SegmentPath
SegmentDF.columns = ['ID','chrom', 'start', 'end', 'num_windows', 'ratio.vs.none']
SegmentDF = SegmentDF[SegmentDF['chrom'] == targetChrom]
SegmentDF = SegmentDF[['start','end', 'ratio.vs.none']]  # slice columns

#FinalDF.to_csv("~/chrom%s_DF.csv"%(targetChrom), sep=',', index=False)



import matplotlib.pyplot as plt
x = SegmentDF.loc[:, SegmentDF.columns[:2]]
y = pd.concat([SegmentDF['ratio.vs.none'], SegmentDF['ratio.vs.none']], axis=1)
print(x)

x_error = []
for i in range(len(SampleDF['maploc'])):
        x_error.append(BIN_size)
x_error = pd.Series(x_error)
print(x_error)
print(SampleDF['maploc'])
plt.title("%s-%s chromosome %s" %(sampleID, LT, targetChrom))
#plt.title("%s-%s chromosome %s" %(sampleID, LT, 'X'))
#plt.scatter(x=SampleDF['maploc'], y=SampleDF['ratio.vs.none'], s=1)
if Targeting == True:
        plt.errorbar(x=SampleDF['maploc'], y=SampleDF['ratio.vs.none'], xerr=[x_error, x_error], fmt='o')
else:
        plt.errorbar(x=SampleDF['maploc'], y=SampleDF['ratio.vs.none'], xerr=x_error, fmt='o', markersize=1)

for i in range(len(SegmentDF)):
        plt.plot(x.iloc[i,:], y.iloc[i,])
        

plt.ylim((-2, 2))

if Targeting == True:
        print(TargetRange)
        plt.xlim(TargetRange)

plt.show()

del SampleDF
del SegmentDF

