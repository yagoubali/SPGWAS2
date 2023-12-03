#!usr/bin/env bash
#Adam 021023
url="http://gusevlab.org/projects/fusion/weights/GusevLawrenson_2019_NG/";


suffix=".tar.bz2"
TCGA_gemline=("OV.GE.NORMAL_FTSEC" "OV.GE.NORMAL_OSEC" "TCGA-OV.GE.TUMOR" "TCGA-OV.SP.TUMOR" "TCGA-BRCA.GE.NORMAL" "TCGA-BRCA.SP.NORMAL" "TCGA-BRCA.GE.TUMOR" "TCGA-BRCA.SP.TUMOR" "TCGA-PRAD.GE.TUMOR" "TCGA-PRAD.SP.TUMOR");

#TCGA_gemline=("TCGA-BLCA.TUMOR"   "TCGA-BRCA.TUMOR"   "TCGA-CESC.TUMOR" )
for tissue in "${TCGA_gemline[@]}"; do
    wget -c ${url}${tissue}${suffix}
    tar -xvf ${tissue}${suffix}
    rm ${tissue}${suffix}
   if [[ "${tissue}" == *-* ]]; then
      new_name=$(echo "${tissue}" | sed -r 's/[-]+/_/g')
      mv ${tissue} ${new_name}
      sub_files=($(ls ${new_name} ))
      for annotation in "${sub_files[@]}"; do
      new_name_annotaion=$(echo "${annotation}" | sed -r 's/[-]+/_/g' | sed -r 's/\?//g' | sed -r 's/:/_/g')
      mv ${new_name}/${annotation}   ${new_name}/${new_name_annotaion}
      done
      files=($(ls *-* ))
      for file in "${files[@]}"; do
        new_name2=$(echo "${file}" | sed -r 's/[-]+/_/g'| sed -r 's/\?//g' | sed -r 's/:/_/g')
        mv ${file} ${new_name2}
        sed -i 's/-/_/g' ${new_name2}*
        sed -i 's/\?//g'  ${new_name2}*
        sed -i 's/:/_/g'  ${new_name2}*
      done
      contents_models=($(ls ${new_name2}))
      for model  in "${contents_models[@]}"; do
        sed -i 's/-/_/g' ${new_name}/${model}
        sed -i 's/\?//g'  ${new_name}/${model}
        sed -i 's/:/_/g'  ${new_name}/${model}
        if [[ "${model}" == *-* ]] || [[ "${model}" == *:* ]] || [[ "${model}" == *\?* ]]  ; then
            new_name3=$(echo "${model}" | sed -r 's/[-]+/_/g' | sed -r 's/\?//g' | sed -r 's/:/_/g')
           mv ${new_name}/${model}   ${new_name}/${new_name3}
        fi 
      done 
   else
     contents_models=($(ls ${tissue}))
     for model  in "${contents_models[@]}"; do
        sed -i 's/-/_/g' ${tissue}/${model}
        sed -i 's/\?//g'  ${tissue}/${model}
        sed -i 's/:/_/g'  ${tissue}/${model}
        if [[ "${model}" == *-* ]] || [[ "${model}" == *:* ]] || [[ "${model}" == *\?* ]]  ; then
            new_name3=$(echo "${model}" | sed -r 's/[-]+/_/g' | sed -r 's/\?//g' | sed -r 's/:/_/g')
           mv ${tissue}/${model}   ${tissue}/${new_name3}
        fi 
     done 
  fi
    sed -i 's/-/_/g' *.pos
    sed -i 's/\?//g'  *.pos
    sed -i 's/:/_/g'  *.pos
  

 done



  
#Any issue in tar is likely the disk you are extracting to is formatted FAT*. The FAT* filesystems do not allow : ? symbols to appear in directory entries (filenames).
