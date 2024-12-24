#!/bin/bash
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=30gb

#Run gkmtrain
../src/gkmtrain -T 16 -t 2 -k 7 -l 11  06_GATA4_SRX2023766.fa 06_GATA4_SRX2023766_neg.fa 06_GATA4_SRX2023766
../src/gkmtrain -x 5 06_GATA4_SRX2023766.fa 06_GATA4_SRX2023766_neg.fa 06_GATA4_SRX2023766_x

#Run predict
../src/gkmpredict footprints_enhancers_19mers.fa 06_GATA4_SRX2023766.model.txt 06_GATA4_SRX2023766_predictions

#Run predict (neg)
../src/gkmpredict 06_GATA4_SRX2023766_neg.fa 06_GATA4_SRX2023766.model.txt 06_GATA4_SRX2023766_predictions_neg

#Prediction quality
python lsgkm_eval.py -p 06_GATA4_SRX2023766_predictions -n 06_GATA4_SRX2023766_predictions_neg

