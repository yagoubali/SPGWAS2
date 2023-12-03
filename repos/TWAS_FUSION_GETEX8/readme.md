This pipeline aims to perform transcriptome-wide and regulome-wide association tests (TWAS and RWAS) using the FUSION  tool (http://gusevlab.org/projects/fusion/). The user can use this tool to perform TWAS and RWAS analysis based on  GTEx v8 multi-tissue expression. There are a total of 49 tissues and two options for each tissue: (i) significant heritability and (ii)  all genes. For typical analysis, significant heritability genes are recommended; however, using all genes increases sensitivity for non-European samples.
# Input data format
This pipeline accepts  GWAS summary statistics as an input file. The input file should be headed with the following minimum fields:  
- SNP – SNP identifier (rsID)
- A1 – first allele (effect allele)
- A2 – second allele (other allele)
- Z – Z-scores, sign with respect to A1.

# User options
Users can set the following options:
- GTEx weights: The user will choose either  significant_heritability  or  all_genes of 49 tissues. 
- Reference panel for calculating the linkage disequilibrium: Here, we used the fine supper populations of 1000 genome data, i.e.,  EUR, AFR, AMR, SAS, and  EAS. 
- The target chromosome: The pipeline analyses only on autosomes, i.e., chromosome {1-22}.
- Locus window size: This option is used for visualization purposes,  the default plotting window size is  100000
- P-value: this is an optional option of P-value for computing  COLOC statistics using coloc R library. The value of 0 turns this calculation off. 
- Max imputation: Fraction of GWAS SNPs allowed to be missing per gene, the default value is  0.5
- Minimum average IMPG imputation accuracy allowed (min_r2pred) the default value is	 0.7
- Total number of variants per chromosome (numberOfSNPs)
- GWASN=${11}  ## 0 means off
- Total GWAS/sumstats sample size for inference of standard GWAS effect size (GWASN): This option is optional. 
- Maximum number of permutations to perform for each feature (perm_max_runs). The value of  0 means it turns the permutations process off.	
- Threshold to initiate permutation test: This option works only when the permutation process is on. The default value is 0.05.
# GTEx tissue: Users can choose one of the following 49 tissues:
- Adipose - Subcutaneous
- Adipose - Visceral (Omentum)
- Adrenal Gland
- Artery - Aorta
- Artery - Coronary
- Artery - Tibial
- Brain - Amygdala
- Brain - Anterior cingulate cortex (BA24)
- Brain - Caudate (basal ganglia)
- Brain - Cerebellar Hemisphere
- Brain - Cerebellum
- Brain - Cortex
- Brain - Frontal Cortex (BA9)
- Brain - Hippocampus
- Brain - Hypothalamus
- Brain - Nucleus accumbens (basal ganglia)
- Brain - Putamen (basal ganglia)
- Brain - Spinal cord (cervical c-1)
- Brain - Substantia nigra
- Breast - Mammary Tissue
- Skin - Transformed fibroblasts
- Blood - EBV-transformed lymphocytes
- Colon - Sigmoid
- Colon - Transverse
- Esophagus - Gastroesophageal Junction
- Esophagus - Mucosa
- Esophagus - Muscularis
- Heart - Atrial Appendage
- Heart - Left Ventricle
- Kidney - Cortex
- Liver
- Lung
- Minor Salivary Gland
- Muscle - Skeletal
- Nerve - Tibial
- Ovary
- Pancreas
- Pituitary
- Prostate
- Skin - Not Sun Exposed (Suprapubic)
- Skin - Sun Exposed (Lower leg)
- Small Intestine - Terminal Ileum
- Spleen
- Stomach
- Testis
- Thyroid
- Uterus
- Vagina
- Whole Blood


# Output file:
The output file is a tab-delimited file (*chr*_GTex8_imputation.txt, *chr*_omnibus_GTex8_imputation.txt) containing  signals of transcriptome-wide significant associations  with the following fields:
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
Besides the text files, the pipeline provides several plots in png format to visualize the correlation plot of the top expression imputation (chr_top_analysis_GTex8_imputation.dat.corrplot.png), and various plots for top locations of the expression imputation (chr_top_analysis_GTex8_imputation.dat.loc_*{N}*.png). 








