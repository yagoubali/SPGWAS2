# TCGA Expression and junction 

This pipeline aims to perform transcriptome-wide and regulome-wide association tests (TWAS and RWAS) using the FUSION  tool (http://gusevlab.org/projects/fusion/). The user can use this tool to perform TWAS analysis based on TCGA Expression and junction from  Gusev et al. https://doi.org/10.1038/s41588-019-0395-x. Users can perform TWAS analysis using  10 tissues: 4 normal tissues and 6 cancerous tissues. 

# Input data format
This pipeline accepts  GWAS summary statistics as an input file. The input file should be headed with the following minimum fields:  
- SNP – SNP identifier (rsID)
- A1 – first allele (effect allele)
- A2 – second allele (other allele)
- Z – Z-scores, sign with respect to A1.

# User options
Users can set the following options:
- GTEx weights: there are 10 tissues. 
- Reference panel for calculating the linkage disequilibrium: Here, we used the fine supper populations of 1000 genome data, i.e.,  eur, afr, amr, sas, and  eas. 
- The target chromosome: The pipeline analyzes only on autosomes, i.e., chromosome {1-22}.
- Locus window size: This option is used for visualization purposes,  the default plotting window size is  100000
- P-value: this option is optional for computing  COLOC statistics using coloc R library. The value of 0 turns this calculation off. 
- Max imputation: Fraction of GWAS SNPs allowed to be missing per gene, the default value is  0.5
- Minimum average IMPG imputation accuracy allowed (min_r2pred) the default value is	 0.7
- Total number of variants per chromosome (numberOfSNPs)
- GWASN=${11}  ## 0 means off
Total GWAS/sumstats sample size for inference of standard GWAS effect size (GWASN): This option is optional. 
- Maximum number of permutations to perform for each feature (perm_max_runs). The value of  0 means it turns the permutation process off.	
- Threshold to initiate permutation test: This option works only when the permutation process is on. The default value is 0.05.


# GTEx tissue
 Users can choose one of the following 10 tissues:
- Ovarian normal FTSEC expression (OV.GE.NORMAL_FTSEC)
- Ovarian normal OSEC expression	 (OV.GE.NORMAL_OSEC)
- TCGA Ovarian tumor expression	 (TCGA_OV.GE.TUMOR)
- TCGA Ovarian tumor junction	 (TCGA_OV.SP.TUMOR)
- TCGA Breast normal expression	(TCGA_BRCA.GE.NORMAL) 
- TCGA Breast normal junction	 (TCGA_BRCA.SP.NORMAL)
- TCGA Breast tumor expression	 (TCGA_BRCA.GE.TUMOR)
- TCGA Breast tumor junction	 (TCGA_BRCA.SP.TUMOR)
- TCGA Prostate tumor expression	 (TCGA_PRAD.GE.TUMOR)
- TCGA Prostate tumor junction	(TCGA_PRAD.SP.TUMOR) 


# Output file:
The output files are tab-delimited files (*chr*_TCGA_Expression_and_junction_imputation.txt, *chr*_omnibus_TCGA_Expression_and_junction_imputation.txt) containing  signals of transcriptome-wide significant associations  with the following fields:
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


Besides the text files, the pipeline provides several plots in PDF format to visualize the correlation plot of the top expression imputation (chr_top_analysis_TCGA_Expression_and_junctionimputation.dat.corrplot.png), and various plots for top locations of the expression imputation (chr_top_analysis_single_tissueTCGA_Expression_and_junction






