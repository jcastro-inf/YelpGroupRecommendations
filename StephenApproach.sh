#!/bin/bash
python superuser2.py $@ > inputfile.txt
rm delete.reg
rm delete.cache
vowpalwabbit/vw /dev/stdin -b 18 -q ui --rank 150 --l2 0.001 --learning_rate 0.015 --passes 10 --decay_learning_rate 0.97 --power_t 0 -f delete.reg --cache_file delete.cache < inputfile.txt
rm inputfile.txt
vowpalwabbit/vw -i delete.reg -p predictions.txt -t superuserpredict.txt
python makeSuperUserPredictionary.py ${@:3}
rm delete.reg
rm delete.cache
paste predictions.txt businessIDs.txt | column -s $'\t' -t > delete.txt
sort -nr -k 1 delete.txt > delete2.txt 
python filterRestaurants.py < delete2.txt
rm delete.txt
rm delete2.txt
python printReviews.py ${@:3}