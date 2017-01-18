#!/bin/bash

PHP=$(which php)
GIT=$(which git)
COMPOSER=$(which composer)

# full directory name of the script.
# http://stackoverflow.com/a/246128/
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$DIR")"

# satis build directory.
PUBLIC="${DIR}/public"
# satis repository.
PACKAGE="https://github.com/composer/satis"
# satis engine for building index.
ENGINE="${DIR}/engine"
# satis binary.
SATIS="${ENGINE}/bin/satis"
# satis configuration file.
CONFIG="${DIR}/satis.json"

if [ -d "$ENGINE" ]; then
    #echo "Updating composer/satis ..."
    # update satis dependencies.
    COMPOSER_JSON="${ENGINE}/composer.json"
    COMPOSER_LOCK="${ENGINE}/composer.lock"
    COMPOSER_HASH="${ENGINE}/composer.hash"

    # Check if composer.lock is in sync by comparing checksums.
    COMPOSER_SYNC=0
    if [ -f "$COMPOSER_HASH" ]; then
        #echo "Composer hash being checked ..."
        COMPOSER_SYNC=$(expr "`cat ${COMPOSER_LOCK} | grep '"hash":' | cut -d'"' -f4`" = "`cat ${COMPOSER_HASH}`")
    fi

    if [ "$COMPOSER_SYNC" -eq 0 ]; then
        #echo "Composer dependencies will be resynchronised ..."
        # Move to target directory.
        cd $ENGINE
        # Retrieve dependencies.
        COMPOSER_ARGS="--no-dev --no-progress --optimize-autoloader"
        $COMPOSER install $COMPOSER_ARGS
        $COMPOSER update $COMPOSER_ARGS
        # Update the hash file of the last checksum.
        COMPOSER_CHECKSUM="$(openssl md5 ${COMPOSER_JSON} | cut -d ' ' -f 2)"
        echo $COMPOSER_CHECKSUM > $COMPOSER_HASH
        #echo "Composer hash updated: ${COMPOSER_CHECKSUM}"
    else
        : #echo "Composer files unchanged. No need to update dependencies."
    fi
else
    #echo "Installing composer/satis ..."
    # create satis directory
    #mkdir $ENGINE
    # install satis system.
    $GIT clone $PACKAGE $ENGINE
    # install satis dependencies.
    cd $ENGINE && $COMPOSER install
fi

#echo "Finished installation."

# run public directory.
$PHP $SATIS build $CONFIG $PUBLIC

#echo "Finished build."