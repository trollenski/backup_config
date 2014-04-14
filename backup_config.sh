#!/bin/bash
# backup_config.sh
# (c) Niki Kovacs, 2014

# Script effectue une sauvegarde des fichiers de configuration essentiels du
# système.

CWD=$(pwd)

FILES=(egrep -v '(^\#)|(^\s+$)' $CWD/files)
NETWORK=$(hostname --domain) 
#ou $(hostname -d)

MACHINE=$(hostname --short) 
#ou $(hostname -s)

if [ ! -d $BACKUPDIR ]; then #si le répertoire $BACKUPDIR n'existe pas alors
  echo ":Création du répertoire de sauvegarde"
  mkdir -p $BACKUPDIR
else 
  echo ":le repertoire de sauvegarde existe déjà."
fi

for FILE in $FILES; do
  if [ -r $FILE ]; then
    BASENAME=$(basename $FILE)
    ABSPATH=$(dirname $FILE) 
    RELPATH=$(echo $ABSPATH | cut -2-)
      if [ ! -d $BACKUPDIR/$RELPATH ]; then
        mkdir -p $BACKUPDIR/$RELPATH
      fi

      echo ":sauvegarde des fichiers $FILE"
      cp -af $FILE $BACKUPDIR/$RELPATH/
  else
      echo ": $FILE n'existe pas"
  fi
done

exit 1



