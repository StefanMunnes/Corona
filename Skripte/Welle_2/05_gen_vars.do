********************** Variablen erstellen *************************************
*** Allgemein ***
// Welle
gen wave = 2

// Tage der Befragung
gen    surveyday = dofC(startdate)
format surveyday %tdDD.NN.YYYY


********************************************************************************
*** Person ***

// Geschlecht
gen 		female = q01gndr == 2 if q01gndr < 3
replace female = .c if female == .

// Alter
gen 		age = 2020 - q02yrbrn
replace age = q02yrbrn if mi(age)

// Altersgruppen
gen 		agegr = irecode(age, 24, 29, 34, 39, 44, 49, 54, 59, 64, 69, 74, 79)
replace agegr = agegr + 1
replace agegr = q02yrbrn if mi(agegr)


********************************************************************************
*** Beruf ***

// Status (mit Erwerbstätigkeit)
recode q04status (0 = .c), gen(status)
replace status = 0 if q03empst == 1

// Arbeitsverhältnis
gen selfempl = q05selfempl

recode q05cntrct (2 = 0), gen(permempl)


// Systemrelevanter Beruf (Dummy)
recode q08prof    (1 = 0) (2/8 = 1), gen(sysjob)

// Homeoffice
recode q12office (2 3 4 = 1) (1 = 0) (0 = .), gen(homeoffice)

gen 		homeoffice_det = homeoffice
replace homeoffice_det = 2 if q12office == 3
recode  homeoffice_det (.b = 3) if q10currenttime == 4


********************************************************************************
*** Familie ***

// Familie
gen 		fam = 1 if q14partner == 0 & q15achildren == 0
replace fam = 2 if q14partner == 1 & q15achildren == 0
replace fam = 3 if q14partner == 1 & q15achildren == 1
replace fam = 4 if q14partner == 0 & q15achildren == 1
recode  fam (. = .c)


* Kinderbetreuung
// myself
gen 		childcare = 1 if (q17childcare1 == 1 | ///
												  q17childcare2 == 1 | ///
												  q17childcare3 == 1) & ///
                          q17childcare4 != 1
// joint
replace childcare = 2 if (q17childcare4 == 1 & ///
											   (q17childcare1 == 1 | ///
												  q17childcare2 == 1 | ///
												  q17childcare3 == 1))
// partner
replace childcare = 3 if q17childcare4 == 1 & ///
											 !(q17childcare1 == 1 | ///
												 q17childcare2 == 1 | ///
												 q17childcare3 == 1)
// others
replace childcare = 4 if q17childcare5 == 1 | q17childcare6 == 1 | ///
		q17childcare7 == 1 | q17childcare8 == 1 | q17childcare9 == 1
replace childcare = 4 if childcare == . & q15achildren == 1

replace childcare = .b if q17childcare1 == .b
replace childcare = .c if q17childcare1 == .c


// Haushaltseinkommen
recode q34hhinc (4 = 3), gen(hhinc)


drop startdate datestamp submitdate

*** Variablen Reihenfolge
order id wave ///
	surveyday interviewtime lastgroup ///
	q01 female q02 agegr q03 q04* status /// FG2
	q05* q06 q07 q08 sysjob q10 q11* q12* homeoffice* q13support /// FG3
	q14 q15achildren fam q17* q19* /// FG4
	q20* q21* /// FG5
	q23 q25* /// FG6
	q30 q32* ///FG7
	q34hhinc hhinc q34prevhhinc /// FG8
	q35* // FG9

exit
