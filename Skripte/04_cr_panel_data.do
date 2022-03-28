*********************************************
** combines data sets from different waves **
*********************************************

version 16
set more off
clear all

cd ".."
capture cd "Corona"

foreach language in "de" "en" {

  use "Daten/Arbeitsdaten/corona_1_`language'.dta", clear

  append using "Daten/Arbeitsdaten/corona_2_`language'.dta"
  append using "Daten/Arbeitsdaten/corona_3_`language'.dta"
  append using "Daten/Arbeitsdaten/corona_4_`language'.dta"

  ******************************************************************************

  * generate panel variables
  // number of participations
  bysort id: gen panel_count = _N

  // Dummy: panel participation
  gen panel = panel_count > 1

  // panel allocation
  bysort id: egen panel_temp = total(wave)

  gen     panel_typ = 1 if panel_temp == 1
  replace panel_typ = 2 if panel_temp == 3
  replace panel_typ = 3 if panel_temp == 4
  replace panel_typ = 4 if panel_temp == 5
  replace panel_typ = 5 if panel_temp == 6
  replace panel_typ = 6 if panel_temp == 7
  replace panel_typ = 7 if panel_temp == 8
  replace panel_typ = 8 if panel_temp == 10

  drop panel_temp


  // label variables
  if "`language'" == "de" {
    lab var panel       "Teilnahme am Panel"
    lab var panel_count "Anzahl der Teilnahmen"
    lab var panel_typ   "Panelverteilung"
  }
  if "`language'" == "en" {
    lab var panel       "Panel participation"
    lab var panel_count "Number of participations"
    lab var panel_typ   "Panel allocation"
  }

  lab define panel_lab 1 "W: 1" 2 "W: 1 & 2" 3 "W: 1 & 3" 4 "W: 1 & 4" ///
		5 "W: 1, 2 & 3" 6 "W: 1, 2 & 4" 7 "W: 1, 3 & 4" 8 "W: 1, 2, 3 & 4", replace
  lab values panel_typ panel_lab


  // delete Person with no data for wave 1
  drop if panel_typ == .

 *******************************************************************************

 * replace values from first waves to fit to variable name in wave 4
 replace q13support1 = q13support if !mi(q13support)

 *******************************************************************************

  * fill with prior/later wave information if question was asked just once
  foreach var of varlist version link? q09wtime ///
    q17childtvtimeb q18divlab? q20sat2? q21concern2? ///
    q23land q24townsize q26flatsize raumbedarf wohnsit ///
    q27educ edu tertiary q28migr {

    bysort id (wave): replace `var' = `var'[1] if wave > 1
  }

  // foreach var of varlist q17gendernorm? {
  //  bysort id (wave): replace `var' = `var'[3] if wave < 3
  // }

  //fill wave 3 with values from wave 2 if missing
  bysort id (wave): replace q34prevhhinc = q34prevhhinc[2] if ///
    wave == 3 & wave[2] == 2 & mi(q34prevhhinc[3]) & !mi(q34prevhhinc[2])

  // fill wave 3 with values from wave 4 if missing
  bysort id (wave): replace q34prevhhinc = q34prevhhinc[4] if  ///
    wave == 3 & wave[4] == 4 & mi(q34prevhhinc[3]) & !mi(q34prevhhinc[4])
  bysort id (wave): replace q34prevhhinc = q34prevhhinc[4] if  ///
    wave == 3 & wave[3] == 4 & mi(q34prevhhinc[3]) & !mi(q34prevhhinc[3])

  // fill wave 1 with values from wave 2 if missings
  bysort id (wave): replace q34prevhhinc = q34prevhhinc[2] if  ///
    wave == 1 & wave[2] == 2 & mi(q34prevhhinc[1]) & !mi(q34prevhhinc[2])

  // fill wave 1 with values from wave 3 if missings
  bysort id (wave): replace q34prevhhinc = q34prevhhinc[3] if  ///
    wave == 1 & wave[3] == 3 & mi(q34prevhhinc[1]) & !mi(q34prevhhinc[3])
  bysort id (wave): replace q34prevhhinc = q34prevhhinc[3] if  ///
    wave == 1 & wave[2] == 3 & mi(q34prevhhinc[1]) & !mi(q34prevhhinc[2])

  // fill wave 1 with values from wave 4 if missings
  bysort id (wave): replace q34prevhhinc = q34prevhhinc[4] if  ///
    wave == 1 & wave[4] == 4 & mi(q34prevhhinc[1]) & !mi(q34prevhhinc[4])
  bysort id (wave): replace q34prevhhinc = q34prevhhinc[3] if  ///
    wave == 1 & wave[3] == 4 & mi(q34prevhhinc[1]) & !mi(q34prevhhinc[3])
  bysort id (wave): replace q34prevhhinc = q34prevhhinc[2] if  ///
  wave == 1 & wave[2] == 4 & mi(q34prevhhinc[1]) & !mi(q34prevhhinc[2])


  * fill missing employment information from wave 1 if no new employment
  foreach var of varlist q05ctrtype permempl q06firmsize q07indust q08prof sysjob {
    bysort id (wave): replace `var' = `var'[_n - 1] if ///
		   wave > 1 & q03empsts == 1 & q04newemp != 1 & !mi(`var'[_n - 1])
  }

  * fill missing employment informations from wave 4 if no new employment
  replace wave = -wave
  bysort id (wave): replace q07indust2 = q07indust2[_n - 1] if wave < 4 & ///
    q03empsts == 1 & q04newemp[_n - 1] != 1 & !mi(q07indust2[_n - 1])
  replace wave = -wave

  * fill missing values of evening and night shifts from wave 1.2 and/or 2
  foreach var of varlist q12time2? {

    // copy values if just one valid value
    bysort id (`var'): replace `var' = `var'[1] if !mi(`var'[1]) & mi(`var'[2])

    // copy values if two identical value
    bysort id (`var'): replace `var' = `var'[1] if `var'[1] == `var'[2] & ///
      !mi(`var'[1])
  }


  * flag inconsistencies between waves and fill in missing values if consistent
  foreach var of varlist q01gndr female q02yrbrn q15achildren {

		bysort id (`var'): egen `var'_max = max(`var')

		bysort id (`var'): gen `var'_flag = 1 if `var'[1] != `var'_max

    // fill missing values if no inconsistencies
    bysort id (`var'): replace `var' = `var'_max if !mi(`var'_max) & `var'_flag != 1

		drop `var'_max
  }

  // add information about agegr if missing values and no inconsistencies
  bysort id (agegr): replace agegr = agegr[1] if q02yrbrn_flag != 1


  * PLZ: flag inconsistencies between waves and fill values if consistent
  bysort id (wave): gen q23plz_flag = 1 if q23plz[2] != q23plz[3] & ///
    q25otherplace[2] != 1 & q25otherplace[3] != 1 & ///
    !mi(q23plz[2]) & !mi(q23plz[3])

  bysort id (wave): replace q23plz = q23plz[2] if ///
    (q23plz[2] == q23plz[3] | mi(q23plz[3])) & q25otherplace[2] != 1


  * flag employment inconsistencies
  // selfempl differs between waves with no new job
  bysort id (wave): gen empl_flag = 1 ///
    if selfempl[_n - 1] != selfempl & q04newemp == 0 & ///
      !mi(selfempl, selfempl[_n - 1])

  // selfempl and permempl is impossible at the same time
	bysort id: replace empl_flag = 1 if selfempl == 1 & permempl == 1

  // set flag for all waves for each participant
	bysort id (empl_flag) : replace empl_flag = empl_flag[_n-1] if _n > 1


  * fill information about children if no inconsistencies by children
  foreach var of varlist q15bchildren nrchildren q16* youngest* {
    bysort id (wave): replace `var' = `var'[1] if q15achildren_flag != 1
  }


  * fill information about household size with wave one if no other hhmembers
  bysort id (wave): replace q25hhsize = q25hhsize[1] if q25otherhhmem != 1


  * fill missing information of partner in wave 2 if wave 1 and 3 are equal
  //bysort id (wave): replace q14partner = q14partner[1] if ///
  //  q14partner[1] == q14partner[3] & mi(q14partner[2]) & ///
  //  wave == 2 & panel_count == 3

	* fill informations about partner with prior/later wave information
	foreach var of varlist q29gndrpar q33educpar p_edu {
		bysort id (wave): replace `var' = `var'[1] if ///
			q14partner == 1 & q14cohabitpre != 0 & !mi(`var'[1])
	}

	* fill usual working hours of partner if have a (and no new - w4) partner
	bysort id (wave): replace q31usualwhpar = q31usualwhpar[3] if ///
		q14partner == 1 & q14cohabitpre != 0 & !mi(q31usualwhpar[3]) & mi(q31usualwhpar)


  * fill working informations about partner if partner still working (wave 2 & 4)
  foreach var of varlist q31profpar p_sysjob {
    bysort id (wave): replace `var' = `var'[1] if ///
      q14partner == 1 & q30empstspar == 1 & wave != 4 & !mi(`var'[1])
  }

  ******************************************************************************

  * add informations about invitation and reminder (last reminder and count)
  merge m:1 id using "Daten/Arbeitsdaten/sample_clean.dta", ///
	 keepusing(media invited_w? reminded_w? remindercount_w?) keep(3) nogen

  foreach var in "invited" "reminded" "remindercount" {
    bysort id (wave): gen long `var' = `var'_w2 if wave == 2
    bysort id (wave): replace  `var' = `var'_w3 if wave == 3
    bysort id (wave): replace  `var' = `var'_w4 if wave == 4

    // transform to date format
    if "`var'" != "remindercount" {
      replace `var' = date(string(`var',"%8.0f"), "YMD")
      format  `var' %tdDD.NN.YYYY
    }
  }

  // label variables
  if "`language'" == "de" {
    lab var media         "Kontakt-Medium"
    lab var invited       "Tag der Einladung"
    lab var reminded      "letzte Erinnerung"
    lab var remindercount "Anzahl Erinnerungen"
  }
  if "`language'" == "en" {
    lab var media         "Media of contact"
    lab var invited       "Day of invitation"
    lab var reminded      "Last reminder"
    lab var remindercount "Number of reminders"

    lab define media_lab 1 "E-mail" 2 "Mobile phone" 3 "Twitter" 4 "Other", replace
  }

  drop *_w?


  ******************************************************************************

  * add information about missings

  // missings if inconsistencies is flagged as unplausible
  recode q15bchildren nrchildren q16* q25hhsize youngest* (. = .d)

  // was copied over if no new job, if new job, question wasn't aksed again
  recode q05ctrtype (. = .f) if wave > 1

  // were just asked in wave 3 and 4
  recode q17childcare1? q17gendernorm? ///
    q30current q31usualwh q31lastwh (./.a = .f) if wave < 3

  // were not asked in wave 1
  recode q04newemp q05selfempl q05cntrct q11compen q11lastwh q11usualwh ///
    q25otherplace q25otherhhmem (. = .f) if wave == 1

  // were aksed just one in wave 2 or 3 and wave 4 again
  recode q34prevhhinc (. = .f)

  // last missings recoded as filter out bc. no (working) partner
  recode q31profpar p_sysjob (. = .b) if wave > 1

  // outro2 wasn't asked again
  recode outro2 (. = .f) if wave > 1

  // media filtered out if don't accept further contact (outro2)
  recode media (. = .b) if outro2 != 1
  recode media (. = .c) // no valid contact information
  bysort id (wave): replace media = media[1] if mi(media) // set for later waves

  ******************************************************************************

  // drop (sensitive or uneccesary) variables
  drop q02yrbrn age wave2 sexage dupid id_old

  order id wave version interviewtime surveyday lastgroup /// FG1
      media invited reminded remindercount panel panel_count panel_typ *flag ///
    link* /// FG2
  	q01gndr female q02 agegr q03 q04* status q04bjobloss /// FG3
  	q05ctrtype* q05selfempl q05cntrct permempl selfempl q06 /// FG4
     q07indust q07indust2 q07indchange q07indust2pre q08* sysjob q09wtime q11usualwh ///
      q10currenttime q11lastwh q11reason* q11lockdown* q11reduction* q11realisation* ///
      q11compen* q12office* homeoffice* q12hopref q12workcond* q12time* q13support* ///
  	q14* q15achildren fam q15bchildren nrchildren q16byrchild* q16childage* /// FG5
      youngest* q17childcare? q17childcare?? q17childcareother childcare q17childtvtime? ///
  		q17childcaresub* q17gendernorm* q18schoolage* q18schoolform* ///
        q18schoolsat* q18schoolsit* q18divlab* q19* ///
  	q20sat* q20crisis? q20crisisland? q20famsup? q20famsupother q20famsupsat?? q21* /// FG6
    q23land q23plz q24townsize q25otherplace* q25hhsize q25otherhhmem* /// FG7
      q26flatsize raumbedarf wohnsit q27educ* edu tertiary q28migr ///
  	q29 q30* q31usualwhpar q31lastwhpar q31profpar p_sysjob q32* q33* p_edu ///FG8
  	q34hhinc hhinc q34prevhhinc /// FG9
  	q35distress1? q35distress2? q35health? /// FG10
    outro2 // FG11

  sort id wave

  compress

  save "Daten/Arbeitsdaten/corona_panel_`language'_v2.dta", replace

}

exit
