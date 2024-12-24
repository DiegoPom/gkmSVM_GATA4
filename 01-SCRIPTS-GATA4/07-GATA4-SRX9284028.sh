#!/bin/bash
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=30gb

#Run gkmtrain
../src/gkmtrain -T 16 -t 2 -k 7 -l 11  07_GATA4_SRX9284028.fa 07_GATA4_SRX9284028_neg.fa 07_GATA4_SRX9284028
../src/gkmtrain -x 5 07_GATA4_SRX9284028.fa 07_GATA4_SRX9284028_neg.fa 07_GATA4_SRX9284028_x

#Run predict
../src/gkmpredict footprints_enhancers_19mers.fa 07_GATA4_SRX9284028.model.txt 07_GATA4_SRX9284028_predictions

#Run predict (neg)
../src/gkmpredict 07_GATA4_SRX9284028_neg.fa 07_GATA4_SRX9284028.model.txt 07_GATA4_SRX9284028_predictions_neg

#Prediction quality
python lsgkm_eval.py -p 07_GATA4_SRX9284028_predictions -n 07_GATA4_SRX9284028_predictions_neg

