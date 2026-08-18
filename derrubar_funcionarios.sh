#!bin/bash

set -euo pipefail

#who | awk '{ print $1 }' | grep -v root | xargs | tr ' ' ',' | awk '{system("pkill -u " $1)}'