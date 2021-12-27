#!/bin/bash

echo "1. The most requests from IP:"
grep -E -o "^([0-9]{1,3}[\.]){3}[0-9]{1,3}" $1 | sort | uniq -c | sort -gr | head -n 1 #> $file_out

echo "2. The most requested page:"
awk '{print $7}' $1 | sort | uniq -c | sort -gr | head -n 1

echo "3. Requests from each ip:"
grep -E -o "^([0-9]{1,3}[\.]){3}[0-9]{1,3}" $1 | sort | uniq -c | sort -gr | head -n 5
echo "..."
echo -n "All requests:   "
grep -E -o "^([0-9]{1,3}[\.]){3}[0-9]{1,3}" $1 | wc -l

echo "4. Non-existent pages:"
awk '$9 == 404 {print $7}' $1 | sort | uniq -c | sort -gr | head -n 5
echo "..."
echo -n "All requests error 404:   "
awk '$9 == 404 {print $7}' $1 | wc -l

echo "5. Rush hour:"
awk '{print $4}' $1 | awk -F: '{print $2":00"}' | sort -n | uniq -c | sort -gr | head -n 1

echo "6. Search bots which have accessed the site"
awk -F \" '$3 ~ /^ 200/ && $6 ~ /bot/ {print $1,$6}' $1 | awk '{$2=$3=$4=$5=""; print $0}' | sort | uniq -c | sort -gr | head -n 5
echo "..."
echo -n "All accessed bots requests:   "
awk -F \" '$3 ~ /^ 200/ && $6 ~ /bot/ {print $1,$6}' $1 | wc -l