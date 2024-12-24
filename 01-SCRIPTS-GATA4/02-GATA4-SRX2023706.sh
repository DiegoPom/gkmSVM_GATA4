#!/bin/bash
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=30gb

#Run gkmtrain
../src/gkmtrain -T 16 -t 2 -k 7 -l 11  02_GATA4_SRX2023706.fa 02_GATA4_SRX2023706_neg.fa 02_GATA4_SRX2023706
../src/gkmtrain -x 5 02_GATA4_SRX2023706.fa 02_GATA4_SRX2023706_neg.fa 02_GATA4_SRX2023706_x

#Run predict
../src/gkmpredict footprints_enhancers_19mers.fa 02_GATA4_SRX2023706.model.txt 02_GATA4_SRX2023706_predictions

#Run predict (neg)
../src/gkmpredict 02_GATA4_SRX2023706_neg.fa 02_GATA4_SRX2023706.model.txt 02_GATA4_SRX2023706_predictions_neg

#Prediction quality
python lsgkm_eval.py -p 02_GATA4_SRX2023706_predictions -n 02_GATA4_SRX2023706_predictions_neg

