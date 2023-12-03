#!usr/bin/env bash
#Adam 021023
url="https://s3.us-west-1.amazonaws.com/gtex.v8.fusion/ALL/";
suffix=".tar.gz"
GTex8_tissues=("GTExv8.ALL.Adipose_Subcutaneous"  "GTExv8.ALL.Adipose_Visceral_Omentum"  "GTExv8.ALL.Adrenal_Gland"  "GTExv8.ALL.Artery_Aorta"  "GTExv8.ALL.Artery_Coronary"  "GTExv8.ALL.Artery_Tibial"  "GTExv8.ALL.Brain_Amygdala"  "GTExv8.ALL.Brain_Anterior_cingulate_cortex_BA24"  "GTExv8.ALL.Brain_Caudate_basal_ganglia"  "GTExv8.ALL.Brain_Cerebellar_Hemisphere"  "GTExv8.ALL.Brain_Cerebellum"  "GTExv8.ALL.Brain_Cortex"  "GTExv8.ALL.Brain_Frontal_Cortex_BA9"  "GTExv8.ALL.Brain_Hippocampus"  "GTExv8.ALL.Brain_Hypothalamus"  "GTExv8.ALL.Brain_Nucleus_accumbens_basal_ganglia"  "GTExv8.ALL.Brain_Putamen_basal_ganglia"  "GTExv8.ALL.Brain_Spinal_cord_cervical_c-1"  "GTExv8.ALL.Brain_Substantia_nigra"  "GTExv8.ALL.Breast_Mammary_Tissue"  "GTExv8.ALL.Cells_Cultured_fibroblasts"  "GTExv8.ALL.Cells_EBV-transformed_lymphocytes"  "GTExv8.ALL.Colon_Sigmoid"  "GTExv8.ALL.Colon_Transverse"  "GTExv8.ALL.Esophagus_Gastroesophageal_Junction"  "GTExv8.ALL.Esophagus_Mucosa"  "GTExv8.ALL.Esophagus_Muscularis"  "GTExv8.ALL.Heart_Atrial_Appendage"  "GTExv8.ALL.Heart_Left_Ventricle"  "GTExv8.ALL.Kidney_Cortex"  "GTExv8.ALL.Liver"  "GTExv8.ALL.Lung"  "GTExv8.ALL.Minor_Salivary_Gland"  "GTExv8.ALL.Muscle_Skeletal"  "GTExv8.ALL.Nerve_Tibial"  "GTExv8.ALL.Ovary"  "GTExv8.ALL.Pancreas"  "GTExv8.ALL.Pituitary"  "GTExv8.ALL.Prostate"  "GTExv8.ALL.Skin_Not_Sun_Exposed_Suprapubic"  "GTExv8.ALL.Skin_Sun_Exposed_Lower_leg"  "GTExv8.ALL.Small_Intestine_Terminal_Ileum"  "GTExv8.ALL.Spleen"  "GTExv8.ALL.Stomach"  "GTExv8.ALL.Testis"  "GTExv8.ALL.Thyroid"  "GTExv8.ALL.Uterus"  "GTExv8.ALL.Vagina"  "GTExv8.ALL.Whole_Blood");

#GTex8_tissues=("GTExv8.ALL.Adipose_Subcutaneous"  "GTExv8.ALL.Adipose_Visceral_Omentum"  "GTExv8.ALL.Brain_Spinal_cord_cervical_c-1"  "GTExv8.ALL.Cells_EBV-transformed_lymphocytes")

for tissue in "${GTex8_tissues[@]}"; do
    echo ${url}${tissue}${suffix} ...
    wget -c ${url}${tissue}${suffix} --waitretry=20  --retry-connrefused -t 20
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
    sed -i 's/-/_/g' *.pos
    sed -i 's/\?//g'  *.pos
    sed -i 's/:/_/g'  *.pos
   sleep 2  
 done
 
