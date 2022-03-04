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


/* Unklare Fälle:
- Arbeitsunfähigkeit = Krankmeldung?
- Studienabsolventin = Hat absolviert... also Arbeitslos?
- Pflege von Angehörigen haben wir jetzt als Hausfrau/Hausmann.
*/


* Hilfsvariable erstellen
cap drop q04other
cap drop q04other2
gen q04other = strlower(q04statusother)

*Zuerst, da sonst Fehler (weil auch andere Substrings vorkommen)
strrec q04other ("*studentin und in elternzeit*" = "4"), sub replace string
strrec q04other ("*bewerbung auf ausbildung*" = "2"), sub replace string
strrec q04other ("*rente*" = "3"), sub replace string
strrec q04other ("langfristig arbeitsunf*" = "3"), sub replace string
strrec q04other ("längerfristig krank*"	= "3"), sub replace string
strrec q04other ("wei ich ende*" = "0"), sub replace string
strrec q04other ("krank seit 2 jah*" = "0"), sub replace string
strrec q04other ("krankheitsb*2015*" = "0"), sub replace string

* Sonstiges
foreach x in "krank" "*krank*geschrieben*" "meniskusprobleme" "krankenstand" "krank*" ///
			 "erkrankung" "*krankheit*" "arb*sunfaehig*" "arb*sunfähig*" ///
			 "au-meldung"	///
			 {
	strrec q04other ("`x'" = "sickleave"), sub replace string
}
foreach x in "*auszeit*" "*unbezahlt beurlaub*" "*urlaub*"	///
			 {
	strrec q04other ("`x'" = "unpaidleave"), sub replace string
}
foreach x in "*beurlaubt*" 	///
			 {
	strrec q04other ("`x'" = "paidleave"), sub replace string
}
foreach x in "*freistellung*" "corona*" "*corona-maßnahm*"	"*ohne auftrag*" ///
			 "keine aufträge" "pandemie" ///
			 {
	strrec q04other ("`x'" = "operational"), sub replace string
}
foreach x in "*privatier*" "*weiterbild*" "*umschulung*" "*ehrenamt*"	///
			 "*keine lust*" "*behinder*" "*depression*" "*gesundheit*" ///
			 "ms" "*verwitwet*" "kein bock" "sabbatjahr" "*praktikum" ///
			 "freiwilligendienst" ///
			 "transfergesellschaft" ///
			 "föj" ///
			 {
	strrec q04other ("`x'" = "0"), sub replace string
}


* 1. Schüler*in/ Studentin
foreach x in "*student*" "stipend*" "*ausbildung*" ///
			 "*während des studiums*" "studium" "erneutes studium*" "studienabsolventin" ///
			 "promotion*" "*dissertation" ///
			 {
	strrec q04other ("`x'" = "1"), sub replace string
}

* 2. Arbeitslos
foreach x in "*gekündigt*" "*suche*" "abfindung*" 	///
			 "keine arbeitsstelle*" "jobaufgabe*" ///
			 "finde keine*" "harz4" "noch kein job*" "*ausgestiegen" ///
			 "*berufsaufgabe*" "insolvenz*" "*aufgeben müssen" ///
			 "*ausgestellt" "neuer job*" "*neuorientierung*" ///
			 {
	strrec q04other ("`x'" = "2"), sub replace string
}

* 3. In Rente/Pension
foreach x in "*rentner*" "*rente*" "*alter*" ///
			 "*ruhestand*" "dauerhaft erkrankt" "berufsunfä*"	///
			 {
	strrec q04other ("`x'" = "3"), sub replace string
}

* 4. In Mutterschutz/Elternzeit
foreach x in "beschäftigungsverbot*" {
	strrec q04other ("`x'" = "4"), sub replace string
}

* 5. Hausfrau/Hausmann
foreach x in "*hausfrau*" "*pflege*" "*kinderbetreuung*" ///
			 "*betreuung der kinder*" "*kinder betreuen*" ///
			 "*kitastart*" "*kita nicht*" "versorgung eines pflegeb*"  ///
			 {
	strrec q04other ("`x'" = "5"), sub replace string
}

*** Abhängige Variablen nach offenen Antworten neu kodieren
* 1. Eigentlich erwerbstätig
foreach x in "honorarkraft"  ///
			  {
	replace q03empsts = 1   if strmatch(q04other, "`x'")
	replace q04other = ""   if strmatch(q04other, "`x'")
	replace q05selfempl = 1 if strmatch(q04other, "`x'")
}

* 2. Arbeitslos wegen Corona
gen q04other2 = strlower(q04statusother)
strrec q04other2 ("*corona*" = "corona"), sub replace
*strrec q04other2 ("*als risikopatien*" = "corona"), sub replace
replace q04bjobloss = 1 if q04other2 == "corona" & q04other=="2"

*Check
list q04other if !inlist(q04other, "", "0","1", "2", "3", "4", "5")

*** Abhängige Variablen nach offenen Antworten neu kodieren
* 1. Eigentlich erwerbstätig
foreach x in "operational" "*sickleave*" "paidleave" "unpaidleave" {
	replace q03empsts = 1  if strmatch(q04other, "`x'")
	/*replace q04other = "" if strmatch(q04other, "`x'")*/
	replace q04status = .b if strmatch(q04other, "`x'")
	replace q10currenttime = 4 if strmatch(q04other, "`x'")
}

replace q11reason = 1 if strmatch(q04other, "paidleave")
replace q11reason = 2 if strmatch(q04other, "unpaidleave")
replace q11reason = 3 if strmatch(q04other, "operational")
replace q11reason = 5 if strmatch(q04other, "sickleave")


**** Fälle richtig zuordnen
foreach num of numlist 1/5 {
	replace q04status = `num' if q04other == "`num'"
}

/*
*Überprüfungstabelle
preserve
keep id q04status q04other q04statusother
order id q04status q04other q04statusother
keep if q04statusother != ""
sort q04status q04statusother
lab var q04status	"Warum nicht erwerbstätig?"
lab define status_lab ///
  0 "Sonstiges" ///
  1 "Schüler*in/Student*in" ///
  2 "Arbeitslos" ///
  3 "Rente/Pension" ///
  4 "Mutterschutz" ///
  5 "Hausfrau/Hausmann"
lab val q04status status_lab
browse
restore 
*/

*Hilfsvariable löschen
drop q04other q04other2

exit
