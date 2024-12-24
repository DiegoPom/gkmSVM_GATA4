#!/bin/bash
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=30gb

#Run gkmtrain
../src/gkmtrain -T 16 -t 2 -k 7 -l 11  04_GATA4_SRX2023734.fa 04_GATA4_SRX2023734_neg.fa 04_GATA4_SRX2023734
../src/gkmtrain -x 5 04_GATA4_SRX2023734.fa 04_GATA4_SRX2023734_neg.fa 04_GATA4_SRX2023734_x

#Run predict
../src/gkmpredict footprints_enhancers_19mers.fa 04_GATA4_SRX2023734.model.txt 04_GATA4_SRX2023734_predictions

#Run predict (neg)
../src/gkmpredict 04_GATA4_SRX2023734_neg.fa 04_GATA4_SRX2023734.model.txt 04_GATA4_SRX2023734_predictions_neg

#Prediction quality
python lsgkm_eval.py -p 04_GATA4_SRX2023734_predictions -n 04_GATA4_SRX2023734_predictions_neg

