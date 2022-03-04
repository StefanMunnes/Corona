/* Kodierung der offenen Antworten Frage
	q27educ: Was ist Ihr höchster beruflicher Abschluss?

in 6 Kategorien:
	0. Bin zurzeit in Schule/Ausbildung/Studium
	1. kein Ausbildungs- oder Hochschulabschluss
	2. Anlernausbildung
	3. Lehre oder Berufsausbildung (mit oder ohne Meister)
	4. Abgeschlossenes Studium
	5. Sonstiges
*/


*Hilfsvariable erstellen
cap drop q27other
gen q27other = strlower(q27educother)


*Einzelne fälle (die im Folgenden fehlerhaft kategorisiert werden würden)
strrec q27other  ///
	("allg hochschulr u ausb" = "3") ///
	("abi und fachschulstudium" = "4") ///
	("abitur, ausbildung, weiterbildung, st*" = "4") ///
	("*abgeschlossene berufsausbildung" = "3") ///
	("*lehre*" = "3")	///
	("*berufsausbildung mit*" = "3")	///
	("*plus ausbildung*" = "3")	///
	, sub replace string


* 0. In Schule/Ausbildung/Studium
foreach x in "aktuell gymnasium*" ///
			 "*im studium*" ///
			 "*student*" ///
			 "*noch in der schule*" 	///
			 "abitur, im bachelorstud*" ///
			 "Mache gerade eine Yogasusbildung" ///
			 "befinde mich im zweitstudium*"	///
			 "derzeit im m. ed.*" {
	strrec q27other ("`x'" = "0"), sub replace string
}

* 1. Kein Ausbildungs- oder Hochschulabschluss (kein abschl)
foreach x in "*abitur*" ///
			 "allgemeine hochsschulre*" ///
			 "*hochschulreife*" ///
			 "matura" ///
			 "abi*" ///
			 "*achoberschulreife"  		///
			 "hauptschulabschlu?" ///
			 "*msa*" ///
			 "?ittl* reife*" ///
			 "?ealschul*" ///
			 "studium ohne*" ///
			 "hf" ///
			 "erweiterter realschulbschluss" ///
			 "*fh-reife*"	///
			 "*fachhochschul?eife*" ///
			 "*sport lizenz*"	///
			 "*bis zur zwischenprüfung*"	///
			 "*hauptschulabschluss*"	///
			 "bergschule" {
	strrec q27other ("`x'" = "1"), sub replace string
}

* 2. Anlernausbildung
strrec q27other ("*anlernausbildung" = "2"), sub replace string

* 3. Lehre/Ausbildung/
foreach x in "*ausbildung*" ///
			 "*verkäufer*"	///
			 "*kirchenmusiker*"	///
			 "*fachangestellt*"	///
			 "*meister*" ///
			 "*assistent*" ///
			 "*mfa*"	///
			 "*kaufmann*" ///
			 "*kauffrau*" ///
			 "*krankenpflege*" ///
			 "*altenpflege*"	///
			 "pflege*" ///
			 "*ebamme*" ///
			 "*fachschul*" ///
			 "iwi weinfachberater*" 	///
			 "*steuerberate*"	///
			 "*kindergärtnerin*"	///
			 "*rzieher*" ///
			 "*andelsschul*" ///
			 "techniker" ///
			 "*rgotherapeut*" ///
			 "*achkraft*" ///
			 "*fachwirt*" ///
			 "*techniker*" ///
			 "*techn.*" ///
			 "*tanztherapeut*"	///
			 "*aussenhandel*"	///
			 "laufbahnprüfung"	///
			 "höherer handel"	///
			 "*2. einstiegsamt*"	///
			 "praxisanleitung"	///
			 "ihk tbw"	///
			 "berufl*weiterb*"	///
			 {
	strrec q27other ("`x'" = "3"), sub replace string
}

* 4. Abgeschlossenes Studium
foreach x in "*ph*d*" ///
			 "*prom*" ///
			 "*habil*" ///
			 "hochschul*" ///
			 "fh"	///
			 "fh?"	///
			 "fh*studium"	///
			 "*dr.*" ///
			 "*doktor*" ///
			 "*diss*" ///
			 "prof.*" ///
			 "prtomotion" ///
			 "dipl*" ///
			 "*iplom*" ///
			 "facharzt" ///
			 "*ing*" ///
			 "fachhochschul*" ///
			 "fachw?rt"  				///
			 "*abgeschlossene studien*" ///
			 "ba" ///
			 "ma" ///
			 "bachelor*" ///
			 "magister*" ///
			 "master*" ///
			 "uni" ///
			 "dr" ///
			 "volljurist" ///
			 "postgrad" ///
			 "medizinstudium" ///
			 "dplompädagogin" ///
			 "*approbation*" ///
			 "*psych*" ///
			 "fachakademie*" ///
			 "*fachaklademie" ///
			 "*professur" ///
			 "*taatsexam*" ///
			 "*pädagoge*(ihk)*" ///
			 "*betriebswirt*" ///
			 "hotelbetiebswirt"	///
			 "*bilanzbuchhalter*" ///
			 "*volontariat*" ///
			 "*soziologie*"	///
			 "*erziehungswis*"	///
			 "staaatsexamen"	///
			 "*ass* iur.*"	///
			 "*musikpäda*"	///
			 "studium*"	///
			 "abgeschlossenes*studium"	///
			 "*lehrkraft*" {
	strrec q27other ("`x'" = "4"), sub replace string
}

* 5. Sonstiges
foreach x in "abgeschlossene weiterbildung" ///
			 "*gehobene Beamtenlaufbahn*" ///
			 "qm" ///
			 "staatl. anerkennung" ///
			 "oh mann !" ///
			 "mensch" ///
			 "examen"	///
			 "berufsgachd" {
	strrec q27other ("`x'" = "5"), sub replace string
}


* Fälle richtig zuordnen
foreach num of numlist 0/5 {
	replace q27educ = `num' if q27other == "`num'" & q27educ == 5 //falls nicht durch q04statusother schon korrigiert
}

list q27other if !inlist(q27other, "0", "1", "2", "3", "4", "5", "")

/*Zur Überprüfung
list q27other if q27other != "0" & ///
				 q27other != "1" & ///
				 q27other != "2" & ///
				 q27other != "3" & ///
				 q27other != "4" & ///
				 q27other != "5" & ///
				 q27other != ""
*/
				 
*Hilfsvariable löschen
drop q27other


exit
