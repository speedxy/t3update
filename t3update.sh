REMOTE_ROOT=/var/www/webX/
REMOTE_DIR=/var/www/webX/html/domainname.de/

# Backup anfertigen
cd $REMOTE_ROOT/files/
wget http://prdownloads.sourceforge.net/typo3/typo3_src-6.2.17.tar.gz
tar -zxf typo3_src*.tar.gz
rm typo3_src*.tar.gz
mv typo3_src*
