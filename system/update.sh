#!/bin/bash

# current working directory.
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
ROOT_DIR="$(dirname "$DIR")"

PHP=$(which php)
GIT=$(which git)
COMPOSER=$(which composer)

# satis build directory.
PUBLIC="${DIR}/public"
# satis directory.
SATIS="${DIR}/engine/bin/satis"
# satis configuration file.
CONFIG="${DIR}/satis.json"

# run public directory.
$PHP $SATIS build $CONFIG $PUBLIC