/* Kodierung der offenen Antworten Frage
	q17childcare*: Kinderbetreuung

	1	Ich betreue sie zu Hause, ohne zu arbeiten
	2	Ich betreue sie, während ich von zu Hause aus arbeite
	3	Tagsüber, arbeiten wenn sie schlafen
	4	Mein/e Partner/in betreut sie
	5	Die Kinder besuchen eine Notfallbetreuung
	6	Die Großeltern übernehmen die Kinderbetreuung
	7	Andere Babysitter_innen, Verwandte, Freunde oder Nachbarn betreuen die Kinder
	8	Wir haben ein Tauschmodell mit anderen Eltern
	9	Die Kinder sind alleine zu Hause/Keine Kinderbetreuung nötig

*/


*Erstellung Hilfsvariable
capture drop q17other test*
gen q17other = strlower(q17childcareother)
foreach num of numlist 1/9 {
	gen test`num' = .
}

*Besondere Fälle/Fälle die die Mustererkennung erschweren:
strrec q17other ("*wir haben uns getrennt*" = "wir haben uns getrennt"), sub replace string

*q17childcare1 Ich betreue sie zu Hause, ohne zu arbeiten
foreach x in "*lternzeit*" "*mutterschutz*"	///
			 "*50*" "*abwechselnd*" "*wechsel*" "*mein mann und ich*" ///
			 "*geteilte betr*" "*mein partner und ich*" "*teilen uns*" ///
			 "*schicht*" "*teile*betreuung*" "*wenn mein partner frei hat*" ///
			 "*rotierende betreuung*" "*eine woche bei mir*" ///
			 "*vormittags übernehme ich*" "*dann betreue ich*"	///
			 "*wenn mein partner*arbeit*" "*gleichberechtigte aufteilung*"	///
			 "*von alle? etwas*" "*geteilt*" "*teile*" ///
			 "*verschiebung der arbeitszeiten, damit*"	///
			 "*mein partner übernimmt*betreu*" "*damit ich morgens da bin*" {
	replace test1 = 1 if strmatch(q17other, "`x'")
}

*q17childcare2 Ich betreue sie, während ich (von zu Hause aus<<NEIN) arbeite
foreach x in "*am arbeitsplatz*" "auf der arbeit" ///
			 "*mit ins büro*" "*mit zur arbeit*" ///
			 "*während wir*arbeiten*" 	///
			 {
	replace test2 = 1 if strmatch(q17other, "`x'")
}

*q17childcare3 Tagsüber, arbeiten wenn sie schlafen
foreach x in "*während*schlafen"	///
			 {
	replace test3 = 1 if strmatch(q17other, "`x'")
}

*q17childcare4 Mein/e Partner/in betreut sie
foreach x in "*wechsel*" "*betreut mein partner*"	 ///
			 "*beide betreu*" "*beide*" ///
			 "*schicht*partner*" "*gleichberechtigte aufteilung*" ///
			 "*mein mann*" "*mann und ich*" "*partner*und ich*" ///
			 "*teile*betreu*" "*wir betreuen*" "*mein partner übernimmt*betreu*" ///
			 "*gemeinsam*" "*geteilte betreuung*" "*wenn mein partner*arbeit*"  ///
			 "*und meine frau*"	"*wenn mein partner frei hat*"  ///
			 {
	replace test4 = 1 if strmatch(q17other, "`x'")
}

*q17childcare5 Die Kinder besuchen eine Notfallbetreuung (mittlerweile auch wieder normale Betreuung)
foreach x in "*kita*" "*tagesmutter*" "*schule*" ///
			 "*notbet*" "*klinik*" ///
			 "*eingeschränkten regelbetrieb*"	///
			 {
	replace test5 = 1 if strmatch(q17other, "`x'")
}

*q17childcare6 Die Großeltern übernehmen die Kinderbetreuung
foreach x in "*großeltern*" "*oma*" ///
			 {
	replace test6 = 1 if strmatch(q17other, "`x'")
}

*q17childcare7 Andere Babysitter_innen, Verwandte, Freunde oder Nachbarn betreuen die Kinder
*Erster Block: Ex-Partner, werden bei childcare4 wieder rauscodiert
*Zweiter Block: Babysitter, Freunde und co
foreach x in "*wechselmodell*" "*getrennt*haushalt*" ///
			 "*ex?partner*" "*exmann*" "ex*" ///
			 "*vater*" "*eine woche*ihrer mutter*"	///
			 "*bei ihrer mutter*" 	"*wir haben uns getrennt*" ///
			 {
	replace test7 = 1 if strmatch(q17other, "`x'")
	replace test4 = . if strmatch(q17other, "`x'")
}

foreach x in "*kinderfrau*" "*nanny*" "*sitter*" ///
			 "*schwester*" "*mitbewohner*"	///
			 "*dienstleister*"	"*au?pair*" ///
			 "*tagesmama*" "haushälterin" ///
			 {
	replace test7 = 1 if strmatch(q17other, "`x'")

}

*q17childcare8 Wir haben ein Tauschmodell mit anderen Eltern
foreach x in "*rotierende betreuung*" "*tauschen betreuung*" ///
			 {
	replace test8 = 1 if strmatch(q17other, "`x'")
}

*q17childcare9 Die Kinder sind alleine zu Hause/Keine Kinderbetreuung nötig
foreach x in "*genug*" "*nötig*" "*notwendig*" ///
			 "*1? jahre*" "*ist 1?*" "*kaum noch betreuung*" ///
			 "*erwachsene*" "*alleine auskommen*" ///
			 "*verschiebung der arbeitszeiten, damit*"	///
			 "*roßer betreut Kleine*"	///
			 {
	replace test9 = 1 if strmatch(q17other, "`x'")
}

* Kein Elternteil des Kindes (muss vermutlich auch in andere variablen geändert werden)
foreach x in "*meine tochter mit ihrem kind lebt bei uns*" {
		foreach y in 1 2 3 4 5 6 7 8 9 {
			replace q17childcare`y' = .b if strmatch(q17other, "`x'")
		}
}

foreach x in "*meine tochter mit ihrem kind lebt bei uns*" {
	replace q15achildren = 0 if strmatch(q17other, "`x'")
	replace q19currentdiv5 = .b if strmatch(q17other, "`x'")
	replace q17other = "" if strmatch(q17other, "`x'")
}

/*
* Kontrolle eigenen Angaben vs. zugeordnete Angaben
list q17other test* q17childcare? if q17other!="" & (test1 != q17childcare1 | ///
													 test2 != q17childcare2 | ///
													 test3 != q17childcare3 | ///
													 test4 != q17childcare4 | ///
													 test5 != q17childcare5 | ///
													 test6 != q17childcare6 | ///
													 test7 != q17childcare7 | ///
													 test8 != q17childcare8 | ///
													 test9 != q17childcare9) & ///
													 (q17childcare1 == 1 |	///
													  q17childcare2 == 1 |	///
													  q17childcare3 == 1 |	///
													  q17childcare4 == 1 |	///
													  q17childcare5 == 1 |	///
													  q17childcare6 == 1 |	///
													  q17childcare7 == 1 |	///
													  q17childcare8 == 1 |	///
													  q17childcare9 == 1 )

*/

*	Fälle richtig zuordnen				 
forvalues num = 1/9 {
	replace q17childcare`num'=1 if test`num'==1
}
						  

/* Zur Kontrolle der Recodierung
list q17childcare* q17other if test1 == . & ///
				 test2 == . & ///
				 test3 == . & ///
				 test4 == . & ///
				 test5 == . & ///
				 test6 == . & ///
				 test7 == . & ///
				 test8 == . & ///
				 test9 == . & ///
				 q17other != ""	 
			 
*/

*Hilfsvariable löschen
drop q17other test*

exit
