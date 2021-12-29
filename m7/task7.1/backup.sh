#!/bin/bash
rsync -arvz --delete --out-format="%t %f %b" $1 $2 >> ~/backup.log