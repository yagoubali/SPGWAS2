#!/bin/env bash
bindir="/media/yagoubali/bioinfo3/SPGWAS2/bin/fusion_twas-master"
dbdir="/media/yagoubali/bioinfo3/SPGWAS2/db"
output1="sCCA_imputation.dat" #Gene-disease association
set -x 
#The primary input is genome-wide summary statistics in LD-score format. At minimum, this is a flat file with a header row containing the following fields:
#1. SNP – SNP identifier (rsID)
#2. A1 – first allele (effect allele)
#3. A2 – second allele (other allele)
#4. Z – Z-scores, sign with respect to A1.

inputfile=$1
outdir=$2
#gtex v8 tissue
weights=$3 # {Gtex_v6, Gtex_v8}
ref_ld_chr=$4  #{eur, afr, amr, sas, eas}
chr=$5   #{1-22}
locus_win=$6  # locus windows to plot, default 100000
coloc_P=$7   #P-value below which to compute COLOC statistic. Requires coloc R library.	0 means off
use_coloc_P=''

if [ $coloc_P -gt 0 ] && [ $coloc_P -le 1 ]; then
   use_coloc_P="--coloc_P ${coloc_P}   "
fi  
max_impute=$8  # Fraction of GWAS SNPs allowed to be missing per gene (for IMPG imputation)	 0.5
min_r2pred=$9 #Minimum average IMPG imputation accuracy allowed	 0.7
numberOfSNPs=${10} # Total number of variant per chromosome 
GWASN=${11}  ## 0 means off
use_GWASN=''

if [ $GWASN -gt 0 ]; then
   use_GWASN="--GWASN	  ${GWASN}   "
fi    
perm_max_runs=${12}  # Maximum number of permutations to perform for each feature, 0=off	
run_perm=''


if [ $perm_max_runs -gt 0 ]; then
   perm_minp=${13}  #If --perm, threshold to initiate permutation test	 0.05
   run_perm="--perm  ${perm_max_runs}  \
    --perm_minp  ${perm_minp}"
fi    

if [ $perm_max_runs -gt 0 ]; then
   sCCA=${14} #{1,2,3}
else
     sCCA=${13} #{1,2,3}
fi

weights_pos=''
weights_dir=''
if [ "${weights}" = 'Gtex_v6'  ]; then
 weights_pos="sCCA/sCCA_weights_v6/scca${sCCA}.pos"
 weights_dir="sCCA/sCCA_weights_v6/"
else
 weights_pos="sCCA/sCCA_weights_v8/sCCA${sCCA}.pos"
 weights_dir="sCCA/sCCA_weights_v8/"
fi  
  
  
  

## Run analysis
#chmod +x script_TWAS_FUSION_sCCA.sh
#mkdir test1
#mkdir test2
#mkdir test3
#mkdir test4

# Test 1 using Gtex_v6 . without permuatation -----  #Joint/conditional tests and plots
#./script_TWAS_FUSION_sCCA.sh PGC2.SCZ.sumstats test1 Gtex_v6 afr 22 100000 0 0.5  0.7 2500 0 0 1

# Test 2 using gtex v6 with permuatation --- # Significance conditional on high GWAS effects (permutation test)
#./script_GTEx_v8_multi_tissue.sh PGC2.SCZ.sumstats test2 Gtex_v6 afr 22 100000 0 0.5  0.7 2500 0 100  0.05 2

# Test 3 using gtex v6 . without permuatation -----  #Joint/conditional tests and plots
#./script_TWAS_FUSION_sCCA.sh  /media/yagoubali/bioinfo3/SPGWAS2/PGC2.SCZ.sumstats test3 Gtex_v8 eur 22 100000 0 0.5  0.7 2500 0 0 3

# Test 4 using gtex v6 with permuatation --- # Significance conditional on high GWAS effects (permutation test)
#./script_TWAS_FUSION_sCCA.sh  /media/yagoubali/bioinfo3/SPGWAS2/PGC2.SCZ.sumstats test4 Gtex_v8 sas 22 100000 0 0.5  0.7 2500 0 100  0.05 1

optional_options="$use_GWASN $run_perm"
#Performing the expression imputation
Rscript ${bindir}/FUSION.assoc_test.R \
--sumstats ${inputfile} \
--weights ${dbdir}/WEIGHTS/${weights_pos} \
--weights_dir ${dbdir}/WEIGHTS/${weights_dir} \
--ref_ld_chr ${dbdir}/ldref/g1000_${ref_ld_chr}. \
--chr ${chr} \
--out ${outdir}/${chr}_${output1} \
${optional_options}


cat ${outdir}/${chr}_${output1} | awk -v N="$numberOfSNPs" 'NR == 1 || $NF < 0.05/N' > ${outdir}/${chr}_top_${output1}

linses=($(wc -l ${outdir}/${chr}_top_${output1}))
if [ ${linses[0]} -gt 0 ]; then
Rscript ${bindir}/FUSION.post_process.R \
--sumstats ${inputfile} \
--input ${outdir}/${chr}_top_${output1} \
--out ${outdir}/${chr}_top_analysis_${output1}  \
--ref_ld_chr ${dbdir}/ldref/g1000_${ref_ld_chr}. \
--chr ${chr} \
--plot --locus_win ${locus_win} \
--plot_corr	--plot_eqtl 	--report	


#Testing for effect in multiple reference panels (omnibus test)
Rscript ${bindir}/FUSION.post_process.R --omnibus \
--sumstats ${inputfile} \
--input ${outdir}/${chr}_top_${output1} \
--ref_ld_chr ${dbdir}/ldref/g1000_${ref_ld_chr}. \
--chr ${chr} \
--out ${outdir}/${chr}_omnibus_${output1}
else
touch ${outdir}/${chr}_top_analysis_${output1}
touch ${outdir}/${chr}_omnibus_${output1}
fi

