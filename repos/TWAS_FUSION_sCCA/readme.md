# GTEx cross-tissue sparse canonical correlation analysis (sCCA)

This pipeline aims to perform transcriptome-wide and regulome-wide association tests (TWAS and RWAS) using the FUSION  tool (http://gusevlab.org/projects/fusion/). The user can use this tool to perform TWAS and RWAS analysis based on GTEx cross-tissue sparse canonical correlation analysis (sCCA) expression data from two versions of GTEx data: GTEx v8 and GTEx v6. The number of features in both versions is 37920. For more details, please refer to Feng, Helian, et al. “Leveraging expression from multiple tissues using sparse canonical correlation analysis (sCCA) and aggregate tests improves the power of transcriptome-wide association studies (TWAS).” 2021 PLOS Genetics.

# Input data format
This pipeline accepts  GWAS summary statistics as an input file. The input file should be headed with the following minimum fields:  
- SNP – SNP identifier (rsID)
- A1 – first allele (effect allele)
- A2 – second allele (other allele)
- Z – Z-scores, sign with respect to A1.

#User options
Users can set the following options:
- GTEx weights: there are two GTEx versions to be used as weights: Gtex_v6 and Gtex_v8. {Here we will use only Gtex_8 as v6 has some issues with genes ids}
- Reference panel for calculating the linkage disequilibrium: Here we used the fine supper populations of 1000 genomes data i.e.,  EUR, AFR, AMR, SAS, and  EAS. 
- The target chromosome: The pipeline performs the analysis only on autosomes, i.e., chromosome {1-22}.
- Locus window size: This option is used for visualization purposes,  the default plotting window size is  100000
- P-value : this is an optional option of P-value to be used in computing  COLOC statistics using coloc R library. The value of 0 turns this calculation off.  { 0<=P-value>1}
- Max imputation: Fraction of GWAS SNPs allowed to be missing per gene the default value is  0.5
- Minimum average IMPG imputation accuracy allowed (min_r2pred) the default value is	 0.7
- Total number of variants per chromosome (numberOfSNPs)
- GWASN  ## 0 means off
Total GWAS/sumstats sample size for inference of standard GWAS effect size (GWASN): This is an optional option. 
- Maximum number of permutations to perform for each feature (perm_max_runs). The value of  0 means turns the permutations process off.	
- Threshold to initiate permutation test: This option works only when the permutation process is on. The default value is 0.05.
- sCCA files: This option has three values: 1, 2, and 3.  The values of 1 and 2  for performing sparse canonical correlation analysis (sCCA) and aggregate Cauchy association test (ACAT), i.e. sCCA+ACAT TWAS with Fusion, while option 3 performs only aggregate Cauchy association test. 

# Output file:
The output files are tab-delimited files (*chr*_sCCA_imputation.txt, *chr*_omnibus_sCCA_imputation.txt) containing  signals of transcriptome-wide significant associations  with the following fields:
- FILE: Full path to the reference weight file used
- ID: Feature/gene identifier, taken from --weights file
- CHR: Chromosome
- P0: Gene start (from --weights)
- P1: Gene end (from --weights)
- HSQ: Heritability of the gene
- BEST.GWAS.ID: rsID of the most significant GWAS SNP in locus
- BEST.GWAS.Z: Z-score of the most significant GWAS SNP in locus
- EQTL.ID: rsID of the best eQTL in the locus
- EQTL.R2: cross-validation R2 of the best eQTL in the locus
- EQTL.Z: Z-score of the best eQTL in the locus
- EQTL.GWAS.Z: GWAS Z-score for this eQTL
- NSNP: Number of SNPs in the locus
- MODEL: Best performing model 
- MODELCV.R2: cross-validation R2 of the best-performing model
- MODELCV.PV: cross-validation P-value of the best-performing model
- TWAS.Z: TWAS Z-score (primary statistic of interest)
- TWAS.P: TWAS P-value


Besides the text files, the pipeline provides several plots in PDF format to visualize the correlation plot of the top expression imputation (chr_top_analysis_sCCA_imputation.dat.corrplot.png), and various plots for top locations of the expression imputation (chr_top_analysis_sCCA_imputation.dat.loc_{N}.png). 







