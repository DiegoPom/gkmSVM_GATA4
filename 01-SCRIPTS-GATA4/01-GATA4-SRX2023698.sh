#!/bin/bash
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=30gb

#Run gkmtrain
../src/gkmtrain -T 16 -t 2 -k 7 -l 11  01_GATA4_SRX2023698.fa 01_GATA4_SRX2023698_neg.fa 01_GATA4_SRX2023698
../src/gkmtrain -x 5 01_GATA4_SRX2023698.fa 01_GATA4_SRX2023698_neg.fa 01_GATA4_SRX2023698_x

#Run predict
../src/gkmpredict footprints_enhancers_19mers.fa 01_GATA4_SRX2023698.model.txt 01_GATA4_SRX2023698_predictions

#Run predict (neg)
../src/gkmpredict 01_GATA4_SRX2023698_neg.fa 01_GATA4_SRX2023698.model.txt 01_GATA4_SRX2023698_predictions_neg

#Prediction quality
python lsgkm_eval.py -p 01_GATA4_SRX2023698_predictions -n 01_GATA4_SRX2023698_predictions_neg

