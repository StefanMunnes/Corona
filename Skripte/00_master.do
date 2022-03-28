********************************************************************************
*
* Master-File zur Aubereitung der LimeSurvey-Daten der Studie corona-alltag.de
*
* Wellen: 1 - 4
* Version: 2.0.0
* Datum: 28.03.2022
* Kontakt: Stefan Munnes (munnes@wzb.eu)
*
* Datenveröffentlichung und Zitation:
* Munnes, Stefan; Bünning, Mareike; Hipp, Lena (2022): Corona-Alltag. Version 2.0.0. Wissenschaftszentrum Berlin für Sozialforschung. Dataset. DOI: https://doi.org/10.7802/2324.
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
run "Skripte/01_cr_raw_data.do"


* 2. Datensatz mit aufbereiteten Informationen zu Duplikaten erstellen
run "Skripte/02_cr_duplicates.do"


* 3. Wellenspezifische Datensätze aufbereiten
run "Skripte/Welle_1/00_master_1.do"
run "Skripte/Welle_2/00_master_2.do"
run "Skripte/Welle_3/00_master_3.do"
run "Skripte/Welle_4/00_master_4.do"


* 4. gemeinsamen Datensatz aus den wellenspezifischen erstellen
// (Panel/Einladungs-Variablen, Inkonsistenzen, Werte auffüllen, Gewichte)
run "Skripte/04_cr_panel_data.do"


* 5. Gewichte berechnen und einfügen
run "Skripte/05_cr_weights.do"


exit
