#!/bin/bash
#
# ToDo:
# - Gesamtes Backup inkl. MySQL
# - Restore-Funktionalität
# Current dir: /var/www/webX/files
VERSION=6.2.17
HTDOCS=../html

# Create backup
NOW=$(date +"%Y-%m-%d")
BACKUP_NAME="./.updater_backup/${NOW}_before_${VERSION}.tar.gz"

echo "Erstelle Backup in $BACKUP_NAME..."
mkdir -p .updater_backup
rm ./.updater_backup/*
#tar -zcf $BACKUP_NAME $HTDOCS/typo3 $HTDOCS/index.php
tar -zcPf $BACKUP_NAME $HTDOCS --exclude="typo3temp" --exclude="fileadmin" --exclude="uploads" --exclude="_old"
echo "Backup angelegt."

# Download sources
rm -f typo3_src*.tar.gz
echo "Lade TYPO3-Version $VERSION..."
wget --quiet http://prdownloads.sourceforge.net/typo3/typo3_src-$VERSION.tar.gz
echo "Download abgeschlossen."

# Unpack sources and overwrite old version
echo "Entpacke Sources und überschreibe alte Version..."
tar -zxf typo3_src-$VERSION.tar.gz -C $HTDOCS --strip 1
rm typo3_src-$VERSION.tar.gz
echo "Update auf TYPO3 $VERSION abgeschlossen."
