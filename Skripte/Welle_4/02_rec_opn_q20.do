/* Kodierung der offenen Antworten Frage
	q20famsupother :
	Fragestellung, Antwortkategorien:
	Es gibt verschiedene staatliche Angebote, die
	Familien im Umgang mit der Pandemie helfen können.
	Welche der folgenden Angebote kennen Sie?

	q20famsup1  Kinderbonus
	q20famsup2	Kinderkrankentage/Sonderurlaub
	q20famsup3	Notfal-Kinderzuschlag
	q20famsup4	Entschädigung bei Verdienstausfall durch Schul- und KiTa-Schließung
	q20famsup5	Lohnfortzahlung durch Arbeitgeber zur Kinderbetreuung
	q20famsup6	Rückerstattung von Elternbeiträgen aufgrund der Kitaschließung
	q20famsup7	Akuthilfen für pflegende Angehörige
	q20famsup8	Vereinfachter Zugang zu ALGII

	q20famsupother	Sonstiges, und zwar
*/


!!! Wenn hier Werte von q20famsupother auf eine der anderen q20famsup-Variablen
übertragen werden, müssen auch die Werte von q20famsat19 und q20famsat29 zur
jeweiligen Variable verschoben werden !!!


capture drop q20other 
gen q20other = strlower(q20famsupother)


*keine/not relevant/no additional info
foreach x in "*keine*" "einfach menschen leben*"	///
			 "*betrifft mich nicht*" ///
			 "*alles nur tropfen*"		///
			 "*nix für selbstst*" ///
			 "kommen für mich nicht in fr*"	///
			 "*alle diese hilfen sind für mich sinnlos,*"	///
			 "*weiss ich gar nicht*"	///
			 "nicht relevant*"	///
			 "ich kenne zwar alle angebote,*"	///
			 {
	    strrec q20other ("`x'" = "none/not relevant"), sub replace string
}

*kennt alle, aber nicht angekreuzt
foreach x in "*kennen alle*nutze sie nicht*"	///
			 {
    strrec q20other ("`x'" = "know all"), sub replace string
}

*irgendwas mit kurzarbeit(ereld)
foreach x in "*kurzarbeiterg*"	{
    strrec q20other ("`x'" = "kurzarbeit(ergeld)"), sub replace string
}

*Elterngeld
foreach x in "*elterngeld*"	{
    strrec q20other ("`x'" = "elterngeld"), sub replace string
}

*Notfallbetreuung
foreach x in "notfallbetr*" "notbetreuu*"	{
    strrec q20other ("`x'" = "notbetreuung"), sub replace string
}


