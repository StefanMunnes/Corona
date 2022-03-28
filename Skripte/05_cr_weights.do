*********************************************
** combines data sets from different waves **
*********************************************

version 16
set more off
clear all

cd ".."
capture cd "Corona"


*** Imputation und Berechnung der Gewichte (Vorlage von Matthias Sand - GESIS)
// local zum R-Skript-Programm
local Rscript "C:\Program Files\R\R-4.0.2\bin\Rscript.exe"

shell "`Rscript'" --verbose "Skripte/Gewichte/01_Imputation.R"
shell "`Rscript'" --verbose "Skripte/Gewichte/02_Gewichtung.R"


*** Gewichtungsfaktoren den Datensätzen hinzufügen
foreach language in "de" "en" {

  use "Daten/Arbeitsdaten/corona_panel_`language'_v2.dta", clear


  merge 1:1 id wave using "Daten/Gewichte/weights_allwaves.dta", nogen

  // label variables
  if "`language'" == "de" {
    lab var weight      "Gewichtungsfaktor"
    lab var weight_trim "Gewichtungsfakter (getrimmt)"
  }
  if "`language'" == "en" {
    lab var weight      "Weighting factor"
    lab var weight_trim "Weighting factor (trimmed)"
  }

  order weight*, after(panel_typ)

  compress

  save "Daten/Arbeitsdaten/corona_panel_`language'_v2.dta", replace

}

exit
