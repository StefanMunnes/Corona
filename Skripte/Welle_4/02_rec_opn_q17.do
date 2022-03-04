/* Kodierung der offenen Antworten Frage
	q17childcare*: Kinderbetreuung

	1	At home, not working 	[Ich betreue sie zu Hause, ohne zu arbeiten]
	2	At home, while working 	[Ich betreue sie, während ich von zu Hause arbeite]
	3	During the day, working when children are sleeping 	[Ich arbeite verstärkt während meine Kinder schlafen, damit ich sie tagsüber betreuen kann]
	12	Partner is looking after them at home, not working 	[Mein/e Partner/in betreut sie zu Hause, ohne zu arbeiten]
	13	Partner looks after them at home, while working       [Mein/e Partner/in betreut sie zu Hause, während er/sie zu Hause arbeitet.
	5	Emergency care 	[Die Kinder besuchen eine Notfallbetreuung]
	6	Grandparents 	[Die Großeltern übernehmen die Kinderbetreuung]
	7	Relatives, friends, neighbors 	[Andere Verwandte, Freunde oder Nachbarn betreuen die 	Kinder]
	8	Swapping with other parents 	[Wir haben ein Tauschmodell mit anderen Eltern]
	9	Children are home alone 	[Die Kinder sind alleine zu Hause/alt genug um ohne 	Betreuung auszukommen]
	10	At school/nursery (reduced hours)	[Betreuung in Kita/Schule in reduziertem Stundenumfang] 
	11	At school/nursery (usual hours) 	[Betreuung in Kita/Schule im gewohnten Stundenumfang]


*/


*Erstellung Hilfsvariable
capture drop q17other test*
gen q17other = strlower(q17childcareother)
foreach num of numlist 1/13 {
	gen test`num' = .
}

* Kein Elternteil des Kindes (muss vermutlich auch in andere variablen geändert werden)
foreach x in "*enkelkind*" "*mitbewohnis*" {
		foreach y in 1 2 3 12 13 5 6 7 8 9 10 11  {
			replace q17childcare`y' = .b if strmatch(q17other, "`x'")
		}

	replace q15achildren = 0 if strmatch(q17other, "`x'")
	replace q19currentdiv5 = .b if strmatch(q17other, "`x'")
	replace q17other = "" if strmatch(q17other, "`x'")
}

*Beobachtungen die keine Änderungen mit sich ziehen, auf missing codieren
foreach x in "betreue au*ilienkreis"	///
			 "betreuung *lternzeit "	///
			 "betreuung *unterricht"	///
			 "der schult*er teams. "	///
			 "eigentlich* betreuung"	///
			 "größere ge*ssen auf. "	///
			 "hortbetreu* absprache"	///
			 "ich arbeit*nicht geht"	///
			 "ich betreu*euen kann."	///
			 "ich nehme *ie arbeit."	///
			 "ich studie*eht online"	///
			 "im wechsel*d betreuen"	///
			 "jede woche*res drama."	///
			 "keine schu*.12.20!!! "	///
			 "kind darf *a präsenz "	///
			 "kind noch *ht in kita"	///
			 "kind sowie*ftrag wahr"	///
			 "kinder müs*tunden/tag"	///
			 "kinder-sch*cht-modell"	///
			 "mein partn*treut hat."	///
			 "meine ehef*(2 kinder)"	///
			 "meine part*s dr fall."	///
			 "sie müssen*t optimal "	///
			 "tageweise *ner arbeit"	///
			 "unterstütz*schule aus"	///
			 "videobeschulung"	///
			 "wg"	///
			 "wir haben *etreuung. "	///
			 "wir sind z*echsmidell"	///
			 "coworking *rbetreuung"	///
 			 "erst seit 15.03*"	///
			 {
			 replace q17other = "" if strmatch(q17other, "`x'")
}

*Besondere Fälle/Fälle die die Mustererkennung erschweren:
replace test10 = 1 if strmatch(q17other, "unsere tochter (4) *")
strrec q17other ("unsere tochter (4) *" = ""), sub replace string
strrec q17other ("*betreuung durch einzelhelfer*" = "babysitter"), sub replace string
strrec q17other ("ich arbeite nach feierabend und vor a*" = "arbeiten wenn schlafen"), sub replace string

*q17childcare1 Ich betreue sie zu Hause, ohne zu arbeiten
foreach x in "*lternzeit*" 	///
			 "*1 kind zu hause"	///
			 "an freien tagen*übernehme ich*"	///
			 "*im wechsel*"	///
			 "*abwechselnd*"	///
			 "*beide eltern*betreu*"	///
			 "*betreu*zuhause*"	///
			 "*betreu*zu hause*"	///
			 "*kinder zu hause bet*"	///
			 "*eltern arbeiten in schicht*"	///
			 "*betreue*ansonsten*"	///
			 "ich betreue*"	///
			 "*übernehme ich*"	///
			 "*immer ein elternteil*"	///
			 "*einer ist immer zu ha*"	///
			 "*ich spät oder nachtsch*"	///
			 "*do-so zu hause"	///
			 "*partner und ich*"	///
			 "*sonderurlaub über*"	///
			 "*und meiner partnerin*"	///
			 "*teilweise*ten betreut werd*"	///
			 "*wir eltern*"	///
			 "*nachmittags umgekehrt*"	///
			 "*mein mann und ich*"	///
			 "*ein baby wird zuhause*"	///
			 "*arbeiten in schichte*"	///
			 "*wird von mir betreut*"	///
			 "*partner+ich*"	///
			 "*2 tage betreu*durch kita*"	///
			 "*ich bespaße*zu hause*"	///
			 "*wer azu hause*"	///
			 "*wechseln uns*betreuung ab*"	///
			 "wir wechseln uns ab*"	///	
			 "*teilzeitarbeit mit flex*plus 1/2*"	///	
			 "*nestmodell*nestzeiten*"	///
			 "*ein elternteil betreut*arbeitet"	///
			 "*kind wird von uns beiden*"	///
			 "*schichtmodell*"	///
			 "*50/50*"	///
 			 "kinder*stundenweise allein*"	///
			 {			 			 
	replace test1 = 1 if strmatch(q17other, "`x'")
}

*q17childcare2 Ich betreue sie, während ich (von zu Hause aus<<NEIN) arbeite
*Theoretisch wären q17childcare1 und 2 gleichzeitig möglich, aber real waren die antworten exklusiv (außer bei einer Person, die wurde oben codiert)
foreach x in "*ich nehme ein kind m*t ins büro*"	///
			 "*ich nehme sie mit zu*h arbeite.*"	///
			 "*meine partnerin und *en danach.*"	///
			 "*und betreuen während dieser zeit*"	///
			 "*mein partner und ich* arbeiten.*"	///
			 "*arbeiten beide aktue*er arbeit *"	///
			 "*ich arbeite und helf*mehr nötig*"	///
			 "*kind geht mit ins büro*"	///
			 {
	replace test2 = 1 if strmatch(q17other, "`x'")
	replace test1 = . if strmatch(q17other, "`x'")
}

*		Für die nicht exklusiven
foreach x in "kinder*stundenweise allein*"	///
			 {
			 	replace test2 = 1 if strmatch(q17other, "`x'")
}

*q17childcare3 Tagsüber, arbeiten wenn sie schlafen
foreach x in "arbeiten wenn schlafen"	///
			 "*wir arbeiten danach*"	///
			 "*nach feierabend*"		///
			 "*nachmittag*bis nachts*"	///
			 "*partner frühschicht*schicht*"	///
			 {
	replace test3 = 1 if strmatch(q17other, "`x'")
}

*q17childcare12	Mein/e Partner/in betreut sie zu Hause, ohne zu arbeiten
foreach x in "*mein mann*"	 ///
			 "*bei meinem mann*"	///
			 "*partner und ich*"	///
			 "*mit partner*"	///
			 "*mein partner*"	///
			 "*meine partnerin*"	///
			 "*50/50*"	///
			 "*wer azu hause*"	///
			 "*wir eltern wechseln*"	///
			 "*wir wechseln uns ab*"	///
			 "*einer ist immer zu*"	///
			 "*beide in elternzeit*"	///
			 "*wir betreuuen*"	///
			 "*partner betreut*"	///
			 "*partnerin betreut*"	///
			 "*abwechselnde betreu*"	///
			 "*arbeiten in schichte*"	///
			 "*partner+ich*"	///
 			 "*schichtmodell*"	///
			 "*arbeit/betreuung*schichtsystem*"	///
			 "*beide eltern arbeiten mit halbem stunden*"	///
			 "*betreuung gewährleistet durch abwech*"	///
			 "*betreuen abwechselnd*und der andere betreut*"	///
			 "*betreuen die kinder gemeinsam*reduziert*"	///
			 "*beide eltern betreuen die kinder und arbeitne zuhause*"	///
			 "*elternteil betreut die kinder, während das jeweils andere arb*"	///
			 "*partner frühschicht*schicht*"	///
			 "*mein partner und ich* arbeiten.*"	///
			 "kinder*stundenweise allein*"	///
			 {
	replace test12 = 1 if strmatch(q17other, "`x'")
}


*q17childcare13	Mein/e Partner/in betreut sie zu Hause, während er/sie zu Hause arbeitet.
*Theoretisch wären q17childcare12 und 13  gleichzeitigmöglich, aber real waren die antworten exklusiv
foreach x in "*meine partnerin und *en danach.*"	///
		 	 "*beide eltern betreue*betreuung *"	///
			 "*beide hatten home of*e office. *"	///
			 "*teilzeitarbeit mit f*ng möglich*"	///
			 "*und betreuen während dieser zeit*"	///
			 "*mein partner und ich*unterricht*"	///
			 "*mutter: job gekündig*eichzeitig*"	///
			 "*die erwachsenen arbe*ssen sind.*"	///
			 {
	replace test13 = 1 if strmatch(q17other, "`x'")
	replace test12 = . if strmatch(q17other, "`x'")
}

*		Für die nicht exklusiven
foreach x in "kinder*stundenweise allein*"	///
			 {
			 	replace test13 = 1 if strmatch(q17other, "`x'")
}

*q17childcare5 Notfallbetreuung! (Reguläre und reduzierte Kita = 10 und 11!)
foreach x in "*notbetreu*" ///
			 {
	replace test5 = 1 if strmatch(q17other, "`x'")
}

*q17childcare6 Die Großeltern übernehmen die Kinderbetreuung
foreach x in "*die großel* so sein)*" ///
			 {
	replace test6 = 1 if strmatch(q17other, "`x'")
}

*q17childcare7 Andere Babysitter_innen, Verwandte, Freunde oder Nachbarn betreuen die Kinder
*Erster Block: Ex-Partner, werden bei childcare4 wieder rauscodiert
*Zweiter Block: Babysitter, Freunde und co
foreach x in "anderes elternteil betreut kinder" 	///
			 "*betreut die kinder bei sich*"		///
			 "*ex-ehepartner*"		///
			 "*ex-partner*"		///
			 "*geteiltes sorgere*"		///
			 "*vater*stundenweise*"		///
			 "*wechselmodel*"	///
			 "*hälfte*kind beim vater*"		///
			 "*betreut im wechsel mit*kita geschlossen"	///
			 {
	replace test7 = 1 if strmatch(q17other, "`x'")
	replace test12 = . if strmatch(q17other, "`x'")
	replace test13 = . if strmatch(q17other, "`x'")
}

foreach x in "*sitter*" ///
			 "*au?pair*"	///
			 "*aupair*"		///
			 "*kinderfrau*"	///
			 "*nanny*"		///
			 "*private kinderbet*"	///
			 "*jemanden engagiert*"	///
			 "*studentin gebucht*"		///
			 {
	replace test7 = 1 if strmatch(q17other, "`x'")
}

*q17childcare8 Wir haben ein Tauschmodell mit anderen Eltern
foreach x in "*xy*" ///
			 {
	replace test8 = 1 if strmatch(q17other, "`x'")
}

*q17childcare9 Die Kinder sind alleine zu Hause/Keine Kinderbetreuung nötig
foreach x in "*alleine zu hause*" ///
			 "*kann alleine bleiben*"	///
			 "*stundenweise allein*"	///
			 "*alleine klar kommen (kur*"	///
			 "*betreuung ist nicht mehr nötig*"	///
			 "*max 3 stunden alleine*"	///
			 "*braucht keine betreuung*"	///
			 "*viel allein zuhause*"		///
			 "*sind 16 und 18*"			///
			 "*zu dritt allein*"		///
			 "ab und an *ür max 1h)"	///
			 "*osteopathin und habe meine praxis*"	///
			 {
	replace test9 = 1 if strmatch(q17other, "`x'")
}

*q17childcare10 Betreuung in Kita/Schule in reduziertem Stundenumfang
foreach x in "*mo-mi krippe*" ///
			 "*verkürzt*kita*"	///
			 "*vormittags*schule*"	///
			 "*tagesbetreuung 3 h*"	///
			 "mix aus all dem genannten"	///
			 "*eingewöhnung*" ///
			 {
	replace test10 = 1 if strmatch(q17other, "`x'")
}
*q17childcare11	Betreuung in Kita/Schule im gewohnten Stundenumfang
foreach x in "*das andere kind geht zur kita*"	///
			 "*im gewohnten stundenum*"	///
			 "*wieder in der schule*"	///
			 "*tagesmutter*"	///
			 "*(normal gebuchte stunden*"	///
			 "*seit dieser woche wieder schule*"	///
			 {
	replace test11 = 1 if strmatch(q17other, "`x'")
}

*	Fälle richtig zuordnen				 
foreach num of numlist 1/3 5/13  {
	replace q17childcare`num' = 1 if test`num' == 1
}

*	Einzelkorrekturen
replace q17childcare1 = . if strmatch(q17other, "wenn die schulen geschlossen*auf!")
replace q17childcare2 = . if strmatch(q17other, "wenn die schulen geschlossen*auf!")
replace q17other = "" if strmatch(q17other, "wenn die schulen geschlossen*auf!")	
	
replace q17childcare8 = . if strmatch(q17other, "tauschmodell im*dann wieder kita*")	
replace q17other = "" if strmatch(q17other, "tauschmodell im*dann wieder kita*")	

replace q17childcare1 = . if strmatch(q17other, "beide elternteile arbeiten auch abends,*")
replace q17other = "" if strmatch(q17other, "beide elternteile arbeiten auch abends,*")	


/* Zur Kontrolle der Recodierung
browse q17other if test1 == . & ///
				 test2 == . & ///
				 test3 == . & ///
				 test12 == . & ///
				 test13 == . & ///
				 test5 == . & ///
				 test6 == . & ///
				 test7 == . & ///
				 test8 == . & ///
				 test9 == . & ///
				 test10 == . & ///
				 test11 == . & ///
				 q17other != ""	 
				 
list q17childcare? q17childcare?? q17other ///
			  if test1 == . & ///
				 test2 == . & ///
				 test3 == . & ///
				 test12 == . & ///
				 test13 == . & ///
				 test5 == . & ///
				 test6 == . & ///
				 test7 == . & ///
				 test8 == . & ///
				 test9 == . & ///
				 test10 == . & ///
				 test11 == . & ///
				 q17other != ""	 
			 
*/
*Überprüfungstabelle
preserve
keep id q17childcare1 test1 q17childcare2 test2 q17childcare3 test3 q17childcare12 test12 q17childcare13 test13 q17childcare5 test5 q17childcare6 test6 q17childcare7 test7 q17childcare8 test8 q17childcare9 test9 q17childcare10 test10 q17childcare11 test11 q17childcareother
order id q17childcareother q17childcare1 test1 q17childcare2 test2 q17childcare3 test3 q17childcare12 test12 q17childcare13 test13 q17childcare5 test5 q17childcare6 test6 q17childcare7 test7 q17childcare8 test8 q17childcare9 test9 q17childcare10 test10 q17childcare11 test11  
keep if q17childcareother != ""
sort q17childcareother 
lab var q17childcare1		"Betreuung: zu Hause, ohne zu arbeiten"
lab var q17childcare2		"Betreuung: zu Hause, während arbeiten"
lab var q17childcare3		"Betreuung: tagsüber, arbeiten wenn sie schlafen"
lab var q17childcare12	"Betreuung: Partner/in zu Hause, ohne zu arbeiten"
lab var q17childcare13	"Betreuung: Partner/in zu Hause, während der Arbeit"
lab var q17childcare5		"Betreuung: Notfallbetreuung"
lab var q17childcare6		"Betreuung: Großeltern"
lab var q17childcare7		"Betreuung: Verwandte, Freunde, Nachbarn"
lab var q17childcare8		"Betreuung: Tauschmodell mit anderen Eltern"
lab var q17childcare9		"Betreuung: Kinder alleine zu Hause"
lab var q17childcare10	"Betreuung: in Kita/Schule in reduziertem Stundenumfang"
lab var q17childcare11	"Betreuung: in Kita/Schule im gewohnten Stundenumfang"
lab define yesno 0 "Nein" 1 "Ja"
lab val q17childcare? q17childcare?? yesno
browse
*export excel using "Skripte/Welle_4/q17_cmpr.xlsx", replace firstrow(varlab)  
restore 



*Hilfsvariable löschen
drop q17other test*

exit
