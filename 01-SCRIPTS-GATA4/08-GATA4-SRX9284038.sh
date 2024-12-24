#!/bin/bash
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=8
#SBATCH --mem=30gb

#Run gkmtrain
../src/gkmtrain -T 16 -t 2 -k 7 -l 11  08_GATA4_SRX9284038.fa 08_GATA4_SRX9284038_neg.fa 08_GATA4_SRX9284038
../src/gkmtrain -x 5 08_GATA4_SRX9284038.fa 08_GATA4_SRX9284038_neg.fa 08_GATA4_SRX9284038_x

#Run predict
../src/gkmpredict footprints_enhancers_19mers.fa 08_GATA4_SRX9284038.model.txt 08_GATA4_SRX9284038_predictions

#Run predict (neg)
../src/gkmpredict 08_GATA4_SRX9284038_neg.fa 08_GATA4_SRX9284038.model.txt 08_GATA4_SRX9284038_predictions_neg

#Prediction quality
python lsgkm_eval.py -p 08_GATA4_SRX9284038_predictions -n 08_GATA4_SRX9284038_predictions_neg

