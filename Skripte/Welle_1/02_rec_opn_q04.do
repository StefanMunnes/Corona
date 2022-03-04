/* Kodierung der offenen Antworten Frage
	q04status: Warum sind sie nicht erwerbstätig?

in 6 Kategorien:
	0. Sonstiges (neu)
	1. Schüler*in/ Studentin
	2. Arbeitslos
	3. In Rente/Pension
	4. In Mutterschutz/Elternzeit
	5. Hausfrau/Hausmann
*/

* Hilfsvariable erstellen
cap drop q04other 
cap drop q04other2
gen q04other = strlower(q04statusother)

*Zuerst, da sonst Fehler (weil auch andere Substrings vorkommen)
strrec q04other ("*keine jobs*" = "2"), sub replace string
strrec q04other ("*verrentet*" = "3"), sub replace string
strrec q04other ("*gekündigt*" = "2"), sub replace string
strrec q04other ("*erwerbsminderungsrente*" = "3"), sub replace string
strrec q04other ("*minijob*" = "3"), sub replace string

* 0. Eigentlich Erwerbstätig / Sonstiges 
foreach x in "*privatier*" "*weiterbild*" "*umschulung*" "*burnout*"	///
			 "gründerin*" "*schwerbehinderung*" "*reha*" "*chr*krank*"	///
			 "erkrankung" "*psychisch*" "*unfähig*" "*burn out*" ///
			 "*gesundheit*" "*erkrank*" "*ausland*" "krankheit" "*lta beantragt*" ///
			 {
	strrec q04other ("`x'" = "0"), sub replace string
}
foreach x in "krank" "krankenstand" "*krank*geschrieben*" "meniskusprobleme" "krankenstand" ///
			 {
	strrec q04other ("`x'" = "sickleave"), sub replace string
}
foreach x in "*auszeit*" "*unbezahlt beurlaub*" "*urlaub*" "*sabbat*"	///
			 "*sabat*" "bildungskarenz" ///
			 {
	strrec q04other ("`x'" = "unpaidleave"), sub replace string
}
foreach x in "*beurlaubt*" "*bezahlte freistellung durch aufhebungs*"	///
			 {
	strrec q04other ("`x'" = "paidleave"), sub replace string
}
foreach x in "*freistellung*" "*corona*" "*corona-maßnahm*"	///
			 {
	strrec q04other ("`x'" = "operational"), sub replace string
}



* 1. Schüler*in/ Studentin
foreach x in "*student*" "*promotion*" "*doktorra*" "*ausbildung*"  {
	strrec q04other ("`x'" = "1"), sub replace string
}

* 2. Arbeitslos
foreach x in "*arbeitslos*" "*gekündigt*" "*suche*" "*bergangsphase*" ///
        "konnte neuen job nicht anfangen*" "abfindung*" "*corona*" ///
		"*studium abgeschlossen*" "*studiums-ende*" "jobwechsel" ///
		"*maßnahme*qualifiz*" "*beendigung der arbeit*" "*umschulung*" ///
		"*wiedereinstieg*nicht machbar*" {
	strrec q04other ("`x'" = "2"), sub replace string
}

* 3. In Rente/Pension
foreach x in "*rentner*" "*rente*" "*alter*"  ///
			 "*ruhestand*" "*erwerbsminder*"  {
	strrec q04other ("`x'" = "3"), sub replace string
}

* 4. In Mutterschutz/Elternzeit
foreach x in "elternzeit*" "mutterschutz" "beschäftigungsverbot*" {
	strrec q04other ("`x'" = "4"), sub replace string
}

* 5. Hausfrau/Hausmann
foreach x in "*meine kinder*" "*hausfrau*" "*pflege*" "*mit meinem kind*" ///
			 "*persönlichen gründen*" "*ziehe ich mein kind auf*" ///
			  {
	strrec q04other ("`x'" = "5"), sub replace string
}

*** Abhängige Variablen nach offenen Antworten neu kodieren

replace q03empsts = 1 if strmatch(q04other, "systemrelevanter beruf")
replace q04other = "" if strmatch(q04other, "systemrelevanter beruf")
replace q04status = . if strmatch(q04other, "systemrelevanter beruf")
replace q08prof = 9 if strmatch(q04other, "systemrelevanter beruf")

* 1. Eigentlich erwerbstätig
replace q05ctrtype = 5 if strmatch(q04other, "*beamt*")
replace q05ctrtype = 3 if strmatch(q04other, "*selbst*ändig*")
replace q05ctrtype = 3 if strmatch(q04other, "*honorark*")
replace q05ctrtype = 2 if strmatch(q04other, "*aufhebungsvereinbarung*")
replace q05ctrtype = 1 if strmatch(q04other, "*lehrer*")

foreach x in "lehrer" "*ausbildung*" "*honorark*" "*beurlaubt*" ///
			 "selbständig" "*bezahlte freistellung*" {
	replace q03empsts = 1  if strmatch(q04other, "`x'")
	replace q10currenttime = 4 if strmatch(q04other, "`x'")
	replace q04other = "" if strmatch(q04other, "`x'")
	replace q04status = .b if strmatch(q04other, "`x'")
	replace q08prof = 1 if strmatch(q04other, "`x'") //da nicht erwerbstätig, nicht systemrelevant
}

replace q11reason = 3 if strmatch(q04other, "*freistellung*")
replace q11reason = 2 if strmatch(q04other, "*unbezahlt beurlaubt*")
replace q11reason = 3 if strmatch(q04other, "lehrer")
replace q11reason = 4 if strmatch(q04other, "*selbst*ändig*")
replace q11reason = 4 if strmatch(q04other, "*honorark*")

*eigentlich Erwerbstätig mit Kurzarbeit:
foreach x in "kurzarbeit null" {
	replace q03empsts = 1 if q04other == "`x'"
	replace q10currenttime = 4 if q04other == "`x'"
	replace q11reason = 6 if q04other == "`x'"
	replace q04other = "" if q04other == "`x'"
	replace q04status = .b if q04other == "`x'"
}

*Eigentlich Erwerbsarbeit, aber Kita zu
foreach x in "*kita*" {
	replace q03empsts = 1 if strmatch(q04other, "`x'")
	replace q10currenttime = 4 if strmatch(q04other, "`x'")
	replace q11reason = 2 if strmatch(q04other, "`x'")
	replace q04other = "" if strmatch(q04other, "`x'")
	replace q04status = .b if strmatch(q04other, "`x'")
}

* 2. Schüler/in, Ausbildung, Student/in
replace q27educ = 0 if q04other == "1" 

* 3. Arbeitslos wegen Corona
gen q04other2 = strlower(q04statusother)
strrec q04other2 ("*corona*" = "corona"), sub replace

replace q04bjobloss = 1 if q04other2 == "corona" & q04other=="2"


*** Abhängige Variablen nach offenen Antworten neu kodieren
* 1. Eigentlich erwerbstätig
replace q11reason = 1 if strmatch(q04other, "paidleave")
replace q11reason = 2 if strmatch(q04other, "unpaidleave")
replace q11reason = 3 if strmatch(q04other, "operational")
replace q11reason = 5 if strmatch(q04other, "sickleave")

foreach x in "operational" "*sickleave*" "paidleave" "unpaidleave" {
	replace q03empsts = 1  if strmatch(q04other, "`x'")
	replace q04other = "" if strmatch(q04other, "`x'")
	replace q04status = .b if strmatch(q04other, "`x'")
	replace q10currenttime = 4 if strmatch(q04other, "`x'")
}


**** Fälle richtig zuordnen
foreach num of numlist 0/5 {
	replace q04status = `num' if q04other == "`num'"
}


list q04other if !inlist(q04other, "0", "1", "2", "3", "4", "5", "")

*Hilfsvariable löschen
drop q04other q04other2

exit
