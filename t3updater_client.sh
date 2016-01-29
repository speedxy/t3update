#!/bin/bash
# ---
# Dieses Script wird auf einem lokalen Computer ausgeführt und steuert die Updates
# auf den verschiedenen Servern per SSH.
# ---
# ToDo:
# - Wenn das HTDOCS-Verzeichnis "htdocs" nicht mit einem Punkt beginnt: Korrigieren
# - Wenn ein Pfad mit einem Slash endet, diesen wegschneiden.
# ---

### Allgemeine Überprüfungen
# Prüfe, ob Aufruf korrekt (Anzahl der Argumente)
ARGS=10
if [ $# -ne $ARGS ]
then
        echo "Usage: $0 ssh_host ssh_user ssh_pass mysql_host mysql_user mysql_pass mysql_db htdocs_dir backup_dir version"
        exit 65
fi

# Prüfe, ob benötigte Programme installiert
PROGRAM="sshpass"
CONDITION=$(which $PROGRAM 2>/dev/null | grep -v "not found" | wc -l)
if [ $CONDITION -eq 0 ] ; then
    echo "$PROGRAM ist nicht installiert."
    exit
fi

### Variablen-Definition
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

sshpass -p "$SSH_PASS" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o LogLevel=quiet ${SSH_USER}@${SSH_HOST} "bash -s" < ./t3updater_server.sh "$SSH_HOST" "$SSH_USER" "$SSH_PASS" "$MYSQL_HOST" "$MYSQL_USER" "$MYSQL_PASS" "$MYSQL_DB" "$HTDOCS_DIR" "$BACKUP_DIR" "$VERSION" > output.txt

echo "Ergebnis des Update-Prozesses:"
cat output.txt
rm output.txt

#echo -e "Lade aktuelle Version des Updaters hoch... "
#sshpass -p "$PASS" scp ./t3updater_server.sh ${USER}@${HOST}:$BACKUP_DIR
#$SSH "chmod 755 $BACKUP_DIR/t3updater_server.sh"
#echo "DONE"

#echo -e "Führe Aktualisierung auf ${USER}@${HOST} aus... "
#sshpass -p "$PASS" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o LogLevel=quiet ${USER}@${HOST} 'bash -s' < t3updater_server.sh.draft
#echo "DONE"
