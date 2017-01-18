#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$DIR")"
PUBLIC="${DIR}/public"
GIT=$(which git)

cp $PUBLIC/index.html $ROOT_DIR/index.html
cp $PUBLIC/packages.json $ROOT_DIR/packages.json
rm $ROOT_DIR/include/*.json
rmdir $ROOT_DIR/include
cp -r $PUBLIC/include $ROOT_DIR/include

# update all
$GIT add $ROOT_DIR