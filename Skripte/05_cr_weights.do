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


  order id wave version interviewtime surveyday lastgroup /// Group 1
    media invited remind* panel* weight* *flag ///
    link* /// Group 2
    q01gndr female agegr q03empsts q04newemp q04status* status q04bjobloss /// Group 3
    q05ctrtype* q05selfempl q05cntrct permempl selfempl q06firmsize /// Group 4
  	q07indust q08prof sysjob q09wtime q10currenttime q11usualwh q11lastwh ///
  	q11reason* q11compen* q12office* homeoffice* q12time* q13support ///
    q14partner q15achildren fam q15bchildren nrchildren q16* /// Group 5
    youngest* q17childcare* childcare q17childtvtime? q17childcaresub* ///
    q17gendernorm* q18divlab? q19currentdiv? ///
    q20sat* q21concern* /// Group 6
    q23land q23plz q24townsize q25otherplace* q25hhsize q25otherhhmem* /// Group 7
    q26flatsize raumbedarf wohnsit q27educ* edu tertiary q28migr ///
    q29gndrpar q30empstspar q30currenttimepar q31usualwhpar q31lastwhpar /// Group 8
    q31profpar p_sysjob q32officepar* q33educpar* p_edu ///
    q34hhinc hhinc q34prevhhinc /// Group 9
    q35distress* q35health* /// Group 10
    outro2 // Group11

  compress

  save "Daten/Arbeitsdaten/corona_panel_`language'_v2.dta", replace

}

exit
