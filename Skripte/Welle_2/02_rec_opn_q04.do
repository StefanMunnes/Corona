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

*Fälle, die sonst falsch Klassifiziert werden vorweg
strrec q04other ("sonderurlaub" = "unpaid leave"), sub replace string 
strrec q04other ("schwerbehinderung und pflegegrad" = "0"), sub replace string
strrec q04other ("persönliche gründe" = "0"), sub replace string

* 1. Schüler*in/ Studentin
foreach x in "*student*" "*promotion*" "*shk*" "*promov*" "ausbildung" ///
			   {
	strrec q04other ("`x'" = "1"), sub replace string
}

* 2. Arbeitslos
foreach x in "*arbeitslos*" "*gekündigt*" "*suche*" "*bergangsphase*" ///
        "konnte neuen job nicht anfangen*" "abfindung*" "*alg*" ///
		"*finde keinen*job*" "*entlassen*" "qualifizierungsmaßnahme" ///
		"job*verloren*" {
	strrec q04other ("`x'" = "2"), sub replace string
}

* 3. In Rente/Pension
foreach x in "*rentner*" "*rente*" "*alter*" "*arbeitsunfähig*" ///
			 "*ruhestand*" "*erwerbsminder*" "berufsunfähig"	///
			 "erwetbsunfaehig"									///
			 {
	strrec q04other ("`x'" = "3"), sub replace string
}

* 4. In Mutterschutz/Elternzeit
foreach x in "*elternzeit*" "mutterschutz" "beschäftigungsverbot*"	///
			  {
	strrec q04other ("`x'" = "4"), sub replace string
}

* 5. Hausfrau/Hausmann
foreach x in "*meine kinder*" "*hausfrau*" "*hausmann*" "*pflege*" ///
			 "*persönlichen gründen*" "*hausfrsau*" "*mutter*ohne elternzeit*" ///
			 "5 kinder" "*fünf kinder" "keine kinderbetreuung*"	///
			 "betreuung kind"	{
	strrec q04other ("`x'" = "5"), sub replace string
}

* Arbeitet eigentlich und 0. Sonstiges 

foreach x in "*auszeit*" "*unbezahlt beurlaub*" "*urlaub*"	///
			 "*sabbat*"	"*sabat*"  ///
			 {
	strrec q04other ("`x'" = "unpaidleave"), sub replace string
}
foreach x in "*krank*" ///
			 {
	strrec q04other ("`x'" = "sickleave"), sub replace string
}
foreach x in "*beurlaubt*" 	///
			 {
	strrec q04other ("`x'" = "paidleave"), sub replace string
}
foreach x in "*freistellung*" "*corona*" "*corona-maßnahm*"	///
			 {
	strrec q04other ("`x'" = "operational"), sub replace string
}
foreach x in "*privatier*" "*weiterbild*" "*umschulung*" "gesundheit"	///
			 {
	strrec q04other ("`x'" = "0"), sub replace string
}

*** Abhängige Variablen nach offenen Antworten neu kodieren
* 1. Eigentlich erwerbstätig
replace q11reason = 1 if strmatch(q04other, "paidleave")
replace q11reason = 2 if strmatch(q04other, "unpaidleave")
replace q11reason = 3 if strmatch(q04other, "operational")
replace q11reason = 5 if strmatch(q04other, "sickleave")

replace q05cntrct = 1 if strmatch(q04other, "*beamt*")

foreach x in "operational" "*sickleave*" "paidleave" "unpaidleave" "*beamt*" {
	replace q03empsts = 1  if strmatch(q04other, "`x'")
	replace q04other = "" if strmatch(q04other, "`x'")
	replace q04status = .b if strmatch(q04other, "`x'")
	replace q10currenttime = 4 if strmatch(q04other, "`x'")
}


* 2. Arbeitslos wegen Corona
gen q04other2 = strlower(q04statusother)
strrec q04other2 ("*corona*" = "corona"), sub replace

replace q04bjobloss = 1 if q04other2 == "corona" & q04other=="2"

**** Fälle richtig zuordnen
foreach num of numlist 1/5 {
	replace q04status = `num' if q04other == "`num'"
}

list q04other if !inlist(q04other, "0", "1", "2", "3", "4", "5", "")

*Hilfsvariable löschen
drop q04other q04other2

exit
