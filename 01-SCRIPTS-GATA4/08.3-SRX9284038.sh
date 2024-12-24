#!/bin/bash
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=30gb

#Run gkmtrain
../src/gkmtrain -T 16 -t 2 -k 7 -l 11  top_10K_GATA4.fa top_10K_GATA4_neg.fa top_10K_GATA4
../src/gkmtrain -x 5 top_10K_GATA4.fa top_10K_GATA4_neg.fa top_10K_GATA4_x

#Run predict
../src/gkmpredict CVD_LD_SNP_ALT_FASTA.fa top_10K_GATA4.model.txt top_10K_GATA4_predictions_alt
../src/gkmpredict CVD_LD_SNP_REF_FASTA.fa top_10K_GATA4.model.txt top_10K_GATA4_predictions_ref

#Run predict (neg)
../src/gkmpredict top_10K_GATA4_neg.fa top_10K_GATA4.model.txt top_10K_GATA4_predictions_neg

#Prediction quality
python lsgkm_eval.py -p top_10K_GATA4_predictions_alt -n top_10K_GATA4_predictions_neg
python lsgkm_eval.py -p top_10K_GATA4_predictions_ref -n top_10K_GATA4_predictions_neg

