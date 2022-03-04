/* Kodierung der offenen Antworten Frage
	q33educpar: Was ist Ihr höchster beruflicher Abschluss?

in 6 Kategorien:
	0. Bin zurzeit in Schule/Ausbildung/Studium
	1. kein Ausbildungs- oder Hochschulabschluss
	2. Anlernausbildung
  3. Lehre oder Berufsausbildung (mit oder ohne Meister)
	4. Abgeschlossenes Studium
	5. Sonstiges
*/

*Hilfsvariable erstellen
cap drop q33other
gen q33other = strlower(q33educparother)


*Einzelne fälle (die im Folgenden fehlerhaft kategorisiert werden würden)
strrec q33other  ///
	("*ausbildung*" = "3") ///
	("fh" = "4")	///
	("*comiczeichnerohne studium" = "1")	///
	("siehe oben" = ""), sub replace string


* 0. In Schule/Ausbildung/Studium
foreach x in "*im studium*" ///
			 "*studiert noch*" ///
			 "*laufendes studium*" ///
			 "studium, nicht abgeschlossen" ///
			 {
	strrec q33other ("`x'" = "0"), sub replace string
}

* 1. Kein Ausbildungs- oder Hochschulabschluss (kein abschl)
foreach x in "*abitur*" ///
			 "*hochschulreife*" ///
			 "abi" ///
			 "?ittl* reife*" ///
			 "?ealschul*" ///
			 "*studium*abgebr*"	///
			 "studium nicht*" ///
			 "*realschulabschluss*" ///
			 "abgebr*studium*" ///
			 "*fachmittelschul*" ///
			 "abibur und musiker und musiklehrer" ///
			 "*volksschule*"	///
			 "selbstverständig"	///
			 "*künstler*"		///
			 "*e-schule*"		///
			 "*musiker*"		///
			 {
	strrec q33other ("`x'" = "1"), sub replace string
}

* 2. Anlernausbildung
strrec q33other ("*anlernausbildung" = "2"), sub replace string

* 3. Lehre/Ausbildung/
foreach x in "*meister*" ///
			 "*lehre*" ///
			 "*pta*" ///
			 "ihk"	///
			 "*pilot*" ///
			 "*kauffrau*" ///
			 "fachschul*" ///
			 "*andelsschul*" ///
			 "techniker" ///
			 "*fachwirt*" ///
			 "*techn.*" ///
			 "technickerniveau" ///
			 "*berufsab*" ///
			 "mta" ///
			 "*krankensch*" ///
			 "kaufmännisch*" ///
			 "*altenpflege*"	///
			 "*berufsschule*"	///
			 "*steuerbevoll*"	///
			 "*fremdsprachenkorre*"	///
			 "*betribswirt*"		///
			 "*fachverkäufer*"	///
			 "*zahnarzthelferin*"	///
			 "vmta"	///
			 "*techniker*"	///
			 "*berufskraftfahrer" ///
			 "*steuerberate*"	/// Könnten auch Studium haben
			 {
	strrec q33other ("`x'" = "3"), sub replace string
}

* 4. Abgeschlossenes Studium
foreach x in "*ph*d*" ///
			 "*prom*" ///
			 "*habil*" ///
			 "hochschul*" ///
			 "*dr.*" ///
			 "*doktor*" ///
			 "postdoc"	///
			 "*diss*" ///
			 "prof.*" ///
			 "prmotion"	///
			 "dipl*" ///
			 "*iplom*" ///
			 "facharzt" ///
			 "*ing*" ///
			 "*fh*"	///
			 "fachhochschule*" ///
			 "fachhochschulabsch*" ///
			 "m.a."	///
			 "mba"	///
			 "msc"	///
			 "bachelor*" ///
			 "magister*" ///
			 "master*" ///
			 "studium privatu*"	///
			 "dr" ///
			 "*approbation*" ///
			 "*psych*" ///
			 "*professur" ///
			 "*taatsexam*" ///
			 "*betriebswirt*" ///
			 "*privatdozent*" ///
			 "*ihk abschluss*" ///
			 "*journalistenschul*" ///
			 "*bilanzbuchhalter*" ///
			 "*gehobener*dienst*"	///
			 "*hochschule*" ///
			 "*modedesign*"	///
			 "*wirtschaftsprüfer*" ///
			 "*offizier*"	///
			 {
	strrec q33other ("`x'" = "4"), sub replace string
}

* 5. Sonstiges
foreach x in "*gehobene Beamtenlaufbahn*" ///
			 "*bundeswehr*"	///
			 "*beamter*"	///
			 {
	strrec q33other ("`x'" = "5"), sub replace string
}


* Fälle richtig zuordnen
foreach num of numlist 0/5 {
	replace q33educpar = `num' if q33other == "`num'" & q33educpar==5
}

list q33other if !inlist(q33other, "0", "1", "2", "3", "4", "5", "")

*Hilfsvariable löschen
drop q33other 


exit
