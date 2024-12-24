#!/bin/bash
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=30gb

#Run gkmtrain
../src/gkmtrain -T 16 -t 2 -k 7 -l 11  03_GATA4_SRX2023714.fa 03_GATA4_SRX2023714_neg.fa 03_GATA4_SRX2023714
../src/gkmtrain -x 5 03_GATA4_SRX2023714.fa 03_GATA4_SRX2023714_neg.fa 03_GATA4_SRX2023714_x

#Run predict
../src/gkmpredict footprints_enhancers_19mers.fa 03_GATA4_SRX2023714.model.txt 03_GATA4_SRX2023714_predictions

#Run predict (neg)
../src/gkmpredict 03_GATA4_SRX2023714_neg.fa 03_GATA4_SRX2023714.model.txt 03_GATA4_SRX2023714_predictions_neg

#Prediction quality
python lsgkm_eval.py -p 03_GATA4_SRX2023714_predictions -n 03_GATA4_SRX2023714_predictions_neg

