#!usr/bin/env bash
#Adam 021023
url="https://data.broadinstitute.org/alkesgroup/FUSION/WGT/";
#https://data.broadinstitute.org/alkesgroup/FUSION/WGT/NTR.BLOOD.RNAARR.tar.bz2
#https://data.broadinstitute.org/alkesgroup/FUSION/WGT/YFS.BLOOD.RNAARR.tar.bz2
#https://data.broadinstitute.org/alkesgroup/FUSION/WGT/METSIM.ADIPOSE.RNASEQ.tar.bz2
#https://data.broadinstitute.org/alkesgroup/FUSION/WGT/CMC.BRAIN.RNASEQ.tar.bz2
#https://data.broadinstitute.org/alkesgroup/FUSION/WGT/CMC.BRAIN.RNASEQ_SPLICING.tar.bz2

suffix=".tar.bz2"
single_tissues=("NTR.BLOOD.RNAARR"  "YFS.BLOOD.RNAARR"  "METSIM.ADIPOSE.RNASEQ"  "CMC.BRAIN.RNASEQ"  "CMC.BRAIN.RNASEQ_SPLICING");


for tissue in "${single_tissues[@]}"; do
    wget -c ${url}${tissue}${suffix}
    tar -xvf ${tissue}${suffix}
    rm ${tissue}${suffix}
   if [[ "${tissue}" == *-* ]]; then
      new_name=$(echo "${tissue}" | sed -r 's/[-]+/_/g')
      mv ${tissue} ${new_name}
      files=($(ls *-* ))
      for file in "${files[@]}"; do
        new_name=$(echo "${file}" | sed -r 's/[-]+/_/g' | sed -r 's/\?//g' | sed -r 's/:/_/g')
        mv ${file} ${new_name}
        sed -i 's/-/_/g' ${new_name}
        sed -i 's/\?//g'  ${new_name2}*
        sed -i 's/:/_/g'  ${new_name2}*
      done
  fi
  if [[ "${tissue}" == "CMC.BRAIN.RNASEQ_SPLICING" ]]; then
  
   sed -i 's/:/_/g' CMC.BRAIN.RNASEQ_SPLICING.pos
   fi
    sed -i 's/-/_/g' *.pos
    sed -i 's/\?//g'  *.pos
    sed -i 's/:/_/g'  *.pos 
 done
 
#Any issue in tar is likely the disk you are extracting to is formatted FAT*. The FAT* filesystems do not allow : to appear in directory entries (filenames).
# CMC.BRAIN.RNASEQ_SPLICING.tar.bz2 can not be extracted on fuse file format
# need to reformat CMC.BRAIN.RNASEQ_SPLICING.pos

