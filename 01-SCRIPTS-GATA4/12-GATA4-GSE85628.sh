#!/bin/bash
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=30gb

#Run gkmtrain
../src/gkmtrain -T 16 -t 2 -k 7 -l 11  12_GATA4_GSE85628.fa 12_GATA4_GSE85628_neg.fa 12_GATA4_GSE85628
../src/gkmtrain -x 5 12_GATA4_GSE85628.fa 12_GATA4_GSE85628_neg.fa 12_GATA4_GSE85628_x

#Run predict
../src/gkmpredict footprints_enhancers_19mers.fa 12_GATA4_GSE85628.model.txt 12_GATA4_GSE85628_predictions

#Run predict (neg)
../src/gkmpredict 12_GATA4_GSE85628_neg.fa 12_GATA4_GSE85628.model.txt 12_GATA4_GSE85628_predictions_neg

#Prediction quality
python lsgkm_eval.py -p 12_GATA4_GSE85628_predictions -n 12_GATA4_GSE85628_predictions_neg

