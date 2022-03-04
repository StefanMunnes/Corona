/* Kodierung der offenen Antworten Frage
q05ctrtypeother: Was kennzeichnet Ihr aktuelles Arbeitsverhältnis?

in 5 Kategorien:
	1. Ich bin in einem unbefristeten Anstellungsverhältnis
	2. Ich bin in einem befristeten Anstellungsverhältnis
	3. Ich bin selbständig/freiberuflich ohne Mitarbeiter
	4. Ich bin selbstständig/freiberuflich mit Mitarbeitern
	5. Ich bin verbeamtet
*/



* Hilfsvariable erstellen
cap drop q05other
gen q05other = strlower(q05ctrtypeother)

*in Studium/Schule identifizieren für Bildungsvariable
cap drop bildung
gen bildung = .
foreach x in "*schüler*" "*student*" "*stipendi*" "*studierend*" ///
			 "schule" "promotion" "umschulung" "*schulfremdenprüf*" ///
			 "fortbildung" {
	replace bildung = 1 if strmatch(q05other, "`x'")
	}
replace q27educ = 0  if bildung==1

*** Problematische Fälle/Fälle die die Mustererkennung erschweren
*	Einzelne fälle
strrec q05other  ///
	("altenpflegerschületin" = "2") ///
	("anerkennungsjahr soziale arbeit"  = "2") ///
	("ich bummle bis zum vertragsende*" = "2") ///
	("*gekündigt, arbeitsverhältnis endet im mai" = "2") ///
	("praxissemester" = "2") ///
	("verbeamtet auf widerruf" = "2") ///
	("*arbeitslos*vorbereitungen selbstständigkeit*" = "Arbeitslos") ///
	("*ruhestand*ehrenamt*" = "Rente") ///
	, sub replace string


*	für befristet Angestellte, um die codierung der Unbefristeten zu erleichtern
strrec q05other ("* befristet angestellt*" = "2") ///
				("befristet angestellt*" = "2") , sub replace string 

***	

* 1. Unbefristet angestellt
foreach x in "*unbefrist*" ///
	 "*angestellt und*" ///
	 "*angestellt &*" ///
	 "*angestellt ind*" ///
	 "antwort 1*" ///
	 "0,5 angestellt*" ///
	 "72% angestellt*" ///
	 "0.5 stelle*" ///
	 "*angestelltenverhältnis*"	///
	 "sowohl angestellt als*"	///
	 "*50% abgestellt*"		///
	 "*teilzeitstelle*"		///
	 "*Angestellte und freiberuflich*" ///
	 "*angestellte team*"	///
	 "*betriebsr*"		///
	 "*kirchl*dienst*" "*richter*"	///
	 "*teilzeit*" {
	strrec q05other ("`x'" = "1"), sub replace string
}

* 2. Befristet angestellt
foreach x in "*450*" "*i?ijob*" "*mini?job*" "*usbildung*" "*uszubilden*" ///
		"azubi*" "*ausbilung" "*befristet*" "*praktikum*" "*praktikant*" ///
		"*doktorand*" "*dual*" "refer?nd*" "neben*" ///
		"*?ilfskraft*" "*aushilf*" "agh" "*stud*mitarbeit*" ///
		"*beamt*auf zei*" "hiwi" "hiwi*" "*romotionsstip*" ///
		"*berufsprakti*" "*robezeit*" "*azubi*" "mandatsträger" ///
		"freiwilligendienst*"  "*werkstudent*"	"*noch berufstätig*" ///
		"*geringfügig*" "anerkennungsjahr*" "halb entristet" ///
		"*kurzfristig*" "*zur erzieherin*" "*nebenberuf*" ///
		"*fsj*" "*in einem anstellungsverhältnis*" ///
		"auf zeit gewählte gewerkschaftsfunktionärin" "*bundesfreiwillig*" ///
		"*referendariat*" "*haushaltshilfe*" "*wma*" "soldat auf zeit" ///
		"*projektbez*angest*" "*studentenjob*" "*rentnerjob*"  {
	strrec q05other ("`x'" = "2"), sub replace string
}

* 3. Selbständig ohne Mitarbeiter
foreach x in "*honorar*" ///
	 "frei"	///
	 "*selbstständige nebent*" ///
	 "zusätzlich selbständig"	///
	 "*freelance*" ///
	 "*teilselbst*" ///
	 "*landwirt*"	///
	 "*nachhilfe*"	///
	 "*abrufkraft*"	///
	 "*freie? mitarbeit*" ///
	 "*freie mitarbeit*" ///
	 "*ohne mitarbeiter*" ///
	 "*vermieter*"	///
	 "*selbständig*"	///
	 "*die aber nicht bei mir anges*" ///
	 "*weiterbild von zuhause"	///
	 "*freiberuf*" ///
	 "*gelegenheitsjobs" {
	strrec q05other ("`x'" = "3"), sub replace string
}

* 4. Selbständig mit Mitarbeitern
foreach x in "*selbstverwalte*betrieb*"	{
	strrec q05other ("`x'" = "4"), sub replace string
}

* 5. Verbeamtet
foreach x in "beamtin" 	///
			 "*berufssoldat*" {
	strrec q05other ("`x'" = "5"), sub replace string
}


*	Schüler/Studierende
//Wenn Arbeitszeit angegeben = Schüler-/Studentenjob (befristet), wenn nicht, nur Bildung

foreach x in "*schüler*" "*student*" "*stipendi*" "*studierend*" ///
			 "schule" "promotion" "umschulung" "*schulfremdenprüf*" ///
			 "fortbildung" {
	replace q05other = "2" if q09wtime<. & strmatch(q05other, "`x'")
	replace q05other = "Bildung"  if strmatch(q05other, "`x'")
}


*	Rentner
replace q05other = "Rente"  if strmatch(q05other, "*freiwillig*mitarbeit*")

//Wenn Arbeitszeit angegeben = Rentnerjob, ansonsten nur Rente
foreach x in "*rente*" "*rentner*" "*pension*"  {
	replace q05other = "2" if q09wtime<. & strmatch(q05other, "`x'")
	replace q05other = "Rente"  if strmatch(q05other, "`x'")
}

*	Arbeitslose
foreach x in "*warte auf*vertrag*" "*arbeitslos*" ///
			 "*gekündigt*" "*job*verloren*" "harz 4" "*westwärts*" ///
			 "*nächste woche meine neue st*" "*umschulung*" {
	strrec q05other ("`x'" = "Arbeitslos"), sub replace string
}


*Fälle richtig zuordnen
foreach num of numlist 0/5 {
	replace q05ctrtype = `num' if q05other == "`num'"
}

list q05other id q07 q09 q10 if !inlist(q05other,"1", "2", "3", "4", "5", "", "Bildung", "Rente")

*** Abhängige Variablen nach offenen Antworten neu kodieren

* q03empsts - Beschäftigungsstatus


* q03empsts - Beschäftigungsstatus
// (Anschlussfragen werden durch rec_miss rekodiert)
replace q03empsts = 0 if inlist(q05other, "Arbeitslos", "Bildung", "Rente")

foreach var of varlist q05ctrtype q06 q07 q08 q08 q10 q11reason q12office ///
					   q13 q20sat11 q20sat21 q21concern12 q21concern22 {
	replace `var' = .b if inlist(q05other, "Arbeitslos", "Bildung", "Rente")
	}

foreach var of varlist q05ctrtypeother q11reasonother q12officeother {
	replace `var' = "" if inlist(q05other, "Arbeitslos", "Bildung", "Rente")
	}
	
* q04status (q04bjobloss) - Warum nicht erwerbstätig?
// Schüler*in/Student*in
replace q04status = 1 if q05other == "Bildung" 

// Arbeitslos
replace q04status = 2 if q05other == "Arbeitslos"
replace q04bjobloss = 1 if strmatch(q05ctrtypeother, "*Job durch Corona verloren")						

// In Rente/Pension
replace q04status = 3 if q05other == "Rente"

ta q05other if !inlist(q05other, "1", "2", "3", "4", "5")
recode q05ctrtype (0=.c)

*Hilfsvariable löschen
drop q05other bildung



exit
