********************************************************************************
*
* Master-File zur Aubereitung der LimeSurvey-Daten der Studie corona-alltag.de
*
* Verantwortlich Lena Hipp, Mareike Bünning, Stefan Munnes
*
* Erstellen eines Panel-Datensatzes aus drei Wellendatensätzen
*
********************************************************************************

version 16
set more off
clear all

cd ".."
capture: cd "Corona"

capture: mkdir "Daten/Arbeitsdaten"
capture: mkdir "Daten/Gewichte"


* 1. Roh-Daten (aus Execel-Dateien von LS) importieren und lokal speichern
do "Skripte/01_cr_raw_data.do"


* 2. Datensatz mit aufbereiteten Informationen zu Duplikaten erstellen
do "Skripte/02_cr_duplicates.do"


* 3. Wellenspezifische Datensätze aufbereiten
do "Skripte/Welle_1/00_master_1.do"
do "Skripte/Welle_2/00_master_2.do"
do "Skripte/Welle_3/00_master_3.do"
do "Skripte/Welle_4/00_master_4.do"


* 4. gemeinsamen Datensatz aus den wellenspezifischen erstellen
// (Panel/Einladungs-Variablen, Inkonsistenzen, Werte auffüllen, Gewichte)
do "Skripte/04_cr_panel_data.do"


* 5. Gewichte berechnen und einfügen
do "Skripte/05_cr_weights.do"


exit
