REMOTE_ROOT=/var/www/webX
REMOTE_DIR=/var/www/webX/html/domainname.de

# Create backup
mkdir -p $REMOTE_ROOT/files/update_backups
tar -zcf backup.tar.gz *
echo "Backup erfolgreich angelegt ($REMOTE_ROOT/files/update_backups/backup.tar.gz)."

# Download sources
cd $REMOTE_ROOT/files/
wget http://prdownloads.sourceforge.net/typo3/typo3_src-6.2.17.tar.gz

# Unpack sources and overwrite old version
rm typo3_src*.tar.gz
tar -zxf typo3_src*.tar.gz -C $REMOTE_DIR --strip 1
rm typo3_src*.tar.gz
