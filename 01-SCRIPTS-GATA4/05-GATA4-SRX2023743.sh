#!/bin/bash
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=30gb

#Run gkmtrain
../src/gkmtrain -T 16 -t 2 -k 7 -l 11  05_GATA4_SRX2023743.fa 05_GATA4_SRX2023743_neg.fa 05_GATA4_SRX2023743
../src/gkmtrain -x 5 05_GATA4_SRX2023743.fa 05_GATA4_SRX2023743_neg.fa 05_GATA4_SRX2023743_x

#Run predict
../src/gkmpredict footprints_enhancers_19mers.fa 05_GATA4_SRX2023743.model.txt 05_GATA4_SRX2023743_predictions

#Run predict (neg)
../src/gkmpredict 05_GATA4_SRX2023743_neg.fa 05_GATA4_SRX2023743.model.txt 05_GATA4_SRX2023743_predictions_neg

#Prediction quality
python lsgkm_eval.py -p 05_GATA4_SRX2023743_predictions -n 05_GATA4_SRX2023743_predictions_neg

