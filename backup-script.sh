#!/bin/bash -x

# Verzeichnisse werden mit Datum und Uhrzeit angelegt
	HEUTE=$(date +%F)
	GESTERN=$(date -d "1 days ago" +%F)
	ZEIT=$(date +%R)

# Auf dieses Medium wird das Backup geschrieben
# Namen des Mediums bitte anpassen
# Leerzeichen sind ganz böse und werden mit \ maskiert
# "bla bla" wird zu "bla\ bla"
	MEDIUM=Seagate\ Expansion\ Drive

# Unter dem Namen des aktuellen Benutzers wird gesichert
	BENUTZER="$USER"

# Das Verzeichnis von dem das Backup gemacht werden soll
	VON="$HOME"/rsynctest

# Das Ziel auf das das Backup gesachrieben wird
	NACH=/media/"$BENUTZER"/"$MEDIUM"/"$BENUTZER"/"$HEUTE"/"$ZEIT"

# Das Referenz-Backup mit dem das neue Backup verglichen wird
	REFERENZ=/media/"$BENUTZER"/"$MEDIUM"/"$BENUTZER"/"$GESTERN"

# Verzeichnisse, die nicht gesichert werden sollen stehen inm  einer Exclude-Liste
# Liste schreiben mit: 'tree -L 1 -d' > Dateiname
	EXCLUDE='backup.excludes'

# Das Verzeichnis für den Wochentag anlegen wenn nicht schon vorhanden
	WOCHENTAG=/media/"$BENUTZER"/"$MEDIUM"/"$BENUTZER"/"$HEUTE"

if
	[ ! -d "$WOCHENTAG" ];
then
	mkdir "$WOCHENTAG";
fi

# Und das eigentliche rsync Kommando
	
	rsync -avn -n -n \
	--link-dest="$REFERENZ" \
	--exclude-from="$EXCLUDE" \
	"$VON" "$NACH"

# Fehler in die Log-Datei
	LOG="$HOME/BACKUP.log"
if
	[ ! -e "$LOG" ];
then
	touch "$LOG";
fi

	echo "BACKUP-erfolgreich-$HEUTE.$ZEIT" >> "$LOG"
		
exit 0
	

