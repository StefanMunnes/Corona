
version 16
set more off
clear all

cd ..
capture: cd "Corona"


global data "C:/Users/munnes/Documents\Corona\"


********************************************************************************

*** Welle 1
* Welle 1.1
import excel "$data/data_excel/Welle_1/20200405.xlsx", firstrow

// Personenbezogene Daten löschen
drop outro3*

compress
save "Daten/Rohdaten/Welle_1/data_20200405.dta", replace

clear

* Welle 1.2
import excel "$data/data_excel/Welle_1/20200510.xlsx", firstrow

// Personenbezogene Daten löschen
drop outro3*

// nur für Welle 1.2: // fortlaufende ID ab Welle 1.2
replace id = id + 11000

compress
save "Daten/Rohdaten/Welle_1/data_20200510.dta", replace

clear

********************************************************************************

*** Welle 2 - 4

forval wave = 2/4 {

	display in red "Welle: `wave'"

	local files: dir "$data/data_excel/Welle_`wave'" files "*.xlsx"
	local n_files: word count `files'
	local file: word `n_files' of `files'
	local name = substr("`file'", 1, 8)

	import excel "$data/data_excel/Welle_`wave'/`file'", firstrow

	// eigentliche ID der ersten Welle vergeben
	replace id = lastname

	// Personenbezogene Daten löschen
	drop token firstname - attribute_2
	capture: drop incentive3 // nur Welle 4 - Mailaddresse für Verlosung

  // manuell Fälle löschen, die mit Welle 4 nicht mehr matchen
  if `wave' == 2 drop if id == 7698 & interviewtime == "1391"
  if `wave' == 3 drop if id == 1402 & interviewtime == "144.05"

	compress
	save "Daten/Rohdaten/Welle_`wave'/data_`name'.dta", replace

	clear
}


exit
