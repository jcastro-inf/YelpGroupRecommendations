#!/bin/bash
echo "Hello World"
counter=1
for var in "$@"
do
    echo "User $counter is $var"
    let "counter += 1"
done

python superuser.py $@ | less