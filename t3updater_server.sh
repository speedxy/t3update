#!/bin/bash
#
# ToDo:
# - Gesamtes Backup inkl. MySQL
# - Restore-Funktionalität
# - Abfrage der Version und ggf. der Verzeichnisse?
# - Soll wirklich alles entpackt werden oder nur bestimmte Verzeichnisse (index.php / typo3)

# Current dir: /var/www/webX

SSH_HOST=$1
SSH_USER=$2
SSH_PASS=$3
MYSQL_HOST=$4
MYSQL_USER=$5
MYSQL_PASS=$6
MYSQL_DB=$7
HTDOCS_DIR=$8
BACKUP_DIR=$9
VERSION=${10}
# ---
BACKUP_DIR="${BACKUP_DIR}/.updater_backup"

# Create backup
NOW=$(date +"%Y-%m-%d")
BACKUP_FILENAME="${NOW}_before_${VERSION}"

mkdir -p $BACKUP_DIR
rm -f $BACKUP_DIR/*

echo "Erstelle Datenbank-Dump"
mysqldump -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASS} ${MYSQL_DB} > $BACKUP_DIR/$BACKUP_FILENAME.sql

echo "Erstelle Backup in $BACKUP_DIR/$BACKUP_FILENAME..."
echo "tar -zcPf ${BACKUP_DIR}/${BACKUP_FILENAME}.tar.gz $HTDOCS_DIR ${BACKUP_DIR}/${BACKUP_FILENAME}.sql"
tar -zcPf ${BACKUP_DIR}/${BACKUP_FILENAME}.tar.gz "$HTDOCS_DIR" "${BACKUP_DIR}/${BACKUP_FILENAME}.sql" --exclude="typo3temp" --exclude="fileadmin" --exclude="uploads"
rm $BACKUP_DIR/$BACKUP_FILENAME.sql
echo "Backup angelegt."

# Download sources
echo "Lade TYPO3-Version $VERSION..."
wget --quiet -O ${BACKUP_DIR}/typo3_src-${VERSION}.tar.gz http://prdownloads.sourceforge.net/typo3/typo3_src-${VERSION}.tar.gz
echo "Download abgeschlossen."

# Unpack sources and overwrite old version
echo "Entpacke Sources und überschreibe alte Version..."
tar -zxf ${BACKUP_DIR}/typo3_src-$VERSION.tar.gz -C $HTDOCS --strip 1
rm -f ${BACKUP_DIR}/typo3_src-$VERSION.tar.gz

# Clean backup and installation directory
rm -r $HTDOCS/typo3temp
#Neu:
#ChangeLog
#INSTALL.md
#LICENSE.txt
#NEWS.md
#README.md
#_.htaccess
#composer.json

echo "Update auf TYPO3 $VERSION abgeschlossen."
