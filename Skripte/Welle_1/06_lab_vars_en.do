
*** Variablen beschriften ***
// lab var startdate "Starting date"
// lab var datestamp "Last activity"
// lab var submitdate "Submission"
lab var id "Personal ID (automatic)"
lab var wave "Number of wave"
lab var version		"Survey version"
lab var lastgroup "Last completed group of questions"
lab var surveyday "Day of participation"
lab var interviewtime		"Duration (in minutes)"

lab var link1 "(E-Mail) from a family member/acquaintance"
lab var link2 "Mailing list"
lab var link3 "Instant messenger (e.g. WhatsApp)"
lab var link4 "Social media platforms (e.g. Twitter/Facebook)"
lab var link5 "(Digital) media (e.g. radio, newspaper)"

lab var linkother "Link from: Other"

lab var q01gndr "Gender"
lab var female "Female"
lab var q02yrbrn "Year of Birth"
lab var age "Age"
lab var q03empsts "Employment"
lab var q04status "Reason for not being employed"
lab var q04statusother		"Reason for not being employed: Other"
lab var q04bjobloss "Job loss during the pandemic"

lab var q05ctrtype "Type of contract"
lab var q05ctrtypeother		"Type of contract: Other"
lab var q06firmsize "Firm size"
lab var q07indust "Sector"
lab var q08prof "Key/essential service worker"
lab var q09wtime "Before pandemic: usual working hours"
lab var q10currenttime		"Working hours now relative to before"
lab var q11reason "Reason for currently not working"
lab var q11reasonother 	"Reason for currently not working: Other"
lab var q12time11	"Current: evening shifts"
lab var q12time12 "Current: night shifts"
lab var q12time21 "Before: evening shifts"
lab var q12time22 "Before: night shifts"
lab var q12office "Current place of work"
lab var q12officeother		"Current place of work: Other"
lab var homeoffice "Homeoffice"
lab var homeoffice_det		"Homeoffice detailed"
lab var q13support "Perceived employer/client support"

lab var q14partner "Relationship status"
lab var q15achildren		"Children in household"
lab var q15bchildren		"Number  of underage children in household"

foreach num of numlist 1/10 {
	lab var q16byrchild`num' "Year of birth of the `num'. child"
	lab var q16childage`num' "Age of the `num'. child"
}

lab var q17childcare1		"Childcare arrangement: At home, not working"
lab var q17childcare2		"Childcare arrangement: At home, while working"
lab var q17childcare3		"Childcare arrangement: During the day, working when children are sleeping"
lab var q17childcare4		"Childcare arrangement: Partner is looking after them"
lab var q17childcare5		"Childcare arrangement: Emergency care"
lab var q17childcare6		"Childcare arrangement: Grandparents"
lab var q17childcare7		"Childcare arrangement: Relatives, friends, neighbors"
lab var q17childcare8		"Childcare arrangement: Swapping with other parents"
lab var q17childcare9		"Childcare arrangement: Children are home alone"

lab var q17childcareother	 "Childcare arrangement: Other"

lab var q17childtvtimea		"Children’s current screen time"
lab var q17childtvtimeb "Children's usual screen time"

lab var q17childcaresub11 "Current: exhausted because of childcare"
lab var q17childcaresub12 "Current: trapped by parental responsibilities"
lab var q17childcaresub21 "Before: exhausted because of childcare"
lab var q17childcaresub22 "Before: trapped by parental responsibilities"

lab var q18divlab1 "Usual distribution of household work: Housework"
lab var q18divlab2 "Usual distribution of household work: Grocery shopping"
lab var q18divlab3 "Usual distribution of household work: Repairs"
lab var q18divlab4 "Usual distribution of household work: Financial/administrative errands"
lab var q18divlab5 "Usual distribution of household work: Childcare"
lab var q19currentdiv1 	"Current distribution of household work: Housework"
lab var q19currentdiv2 	"Current distribution of household work: Grocery shopping"
lab var q19currentdiv3 	"Current distribution of household work: Repairs"
lab var q19currentdiv4 	"Current distribution of household work: Financial/administrative errands"
lab var q19currentdiv5 	"Current distribution of household work: Childcare"

lab var q20sat11 "Current satisfaction: Work"
lab var q20sat12 "Current satisfaction: Relationship"
lab var q20sat13 "Current satisfaction: Family life"
lab var q20sat14 "Current satisfaction: Distribution of tasks within the household"
lab var q20sat15 "Current satisfaction: Quality of social contacts"
lab var q20sat16 "Current satisfaction: Mutual helpfulness within your neighborhood"
lab var q20sat17 "Current satisfaction: Life in general"
lab var q20sat21 "Prior satisfaction: Work"
lab var q20sat22 "Prior satisfaction: Relationship"
lab var q20sat23 "Prior satisfaction: Family life"
lab var q20sat24 "Prior satisfaction: Distribution of tasks within the household"
lab var q20sat25 "Prior satisfaction: Quality of social contacts"
lab var q20sat26 "Prior satisfaction: Mutual helpfulness within your neighborhood"
lab var q20sat27 "Prior satisfaction: Life in general"

lab var q21concern11		"Current concerns: Financial situation"
lab var q21concern12		"Current concerns: Loss of job"
lab var q21concern13		"Current concerns: Own health"
lab var q21concern14		"Current concerns: Health of relatives"
lab var q21concern21		"Prior concerns: Financial situation"
lab var q21concern22		"Prior concerns: Loss of job"
lab var q21concern23		"Prior concerns: Own health"
lab var q21concern24		"Prior concerns: Health of relatives"

// lab var q22challenge		"Current greatest challenge"

lab var q23land "Federal state"
lab var q24townsize "Size of place of residence"
lab var	q25hhsize "Size of household"
lab var	q26flatsize "Number of rooms"
lab var	q27educ "Highest completed level of education"
lab var	q27educother		"Highest completed level of education: Other"
lab var q28migr "Migration background"

lab var q29gndrpar "Partner: gender"
lab var q30empstspar		"Partner: employment"
lab var q31profpar "Partner: essential/key service worker"
lab var q32officepar		"Partner: current place of work"
lab var q32officeparother	"Partner: current place of work: Other"
lab var q33educpar "Partner: Highest completed level of education"
lab var q33educparother		"Partner: Highest completed level of education: Other"

lab var q34hhinc "Rating household income"

lab var q35distress11 "Current: anxious, nervous, restless"
lab var q35distress12 "Current: depressed, hopeless, strained"
lab var q35distress21 "Before: anxious, nervous, restless"
lab var q35distress22 "Before: depressed, hopeless, strained"
lab var q35health1 "Current: physical health"
lab var q35health2 "Before: physical health"

lab var outro2 "Follow-up survey"

lab var agegr "Age cohort"
lab var status "Main activity"
lab var nrchildren "Number of children"
lab var sysjob "Key/essential worker "
lab var p_sysjob "Partner: key worker"
lab var youngest "Age of youngest child"
lab var youngestcat 	"Age of youngest child"
lab var fam "Family situation"
lab var wohnsit "Number of rooms in proportion to size of household"
lab var hhinc "Rating household income"
lab var permempl "Permanent contract"
lab var selfempl "Self-employed"
lab var raumbedarf "Room requirement"
lab var edu "Professional qualification"
lab var tertiary "University degree"
lab var p_edu "Partner: professional qualification"
lab var childcare		"Childcare arrangement"

********************************************************************************
*** Value label definieren ***

lab define yesno 0 "No" 1 "Yes", replace

lab define scale_agree_lab 1 "strongly disagree" 7 "strongly agree"

lab define gndr_lab 1 "Male" 2 "Female" 3 "Diverse", replace

lab define status_lab ///
	0 "Other" ///
	1 "School/university student" ///
	2 "Unemployed" ///
	3 "Retired" ///
	4 "Maternity protection/parental leave" ///
	5 "Homemaker", replace

lab define ctrtype_lab ///
	0 "Other" ///
	1 "Permanent contract" ///
	2 "Fixed-term contract" ///
	3 "Self-employed/freelancer without employees" ///
	4 "Self-employed/freelancer with employees" ///
	5 "Civil servant", replace

lab define firmsize_lab 1 "<20" 2 "20-200" 3 ">200", replace

lab define indust_lab ///
	1 "Agriculture, forestry and fishing" ///
	2 "Manufacturing, mining, and related industries" ///
	3 "Construction" ///
	4 "Retail, hospitality, transport, storage" ///
	5 "Information and communication" ///
	6 "Finance and insurance" ///
	7 "Scientific, technical, and support service activities" ///
	8 "Public administration and defense" ///
	9 "Education, human health, and social work" ///
	10 	"Other service", replace

lab define prof_lab ///
  1	"No" ///
  2	"Yes: Police, fire brigade, and aid/relief, Law enforcement and crisis unit" ///
  3	"Yes: Public transport, resource supply and waste disposal, energy supply" ///
  4	"Yes: Healthcare and nursing staff" ///
  5	"Yes: Staff in public facilities or authorities" ///
  6	"Yes: Emergency child care provision at schools/nurseries" ///
  7	"Yes: Other staff in critical infrastructure and basic services" ///
  8 "Yes: Retail (Grocery and drug stores)", replace

lab define wtime_lab ///
	1 "up to 15/week" 2	"16 to 25 hours/week" ///
	3 "26 to 37 hours/week" 4	"38 hours/week or more", replace

lab define currenttime_lab ///
	1 	"As many hours as before" ///
	2 "Fewer hours than before" ///
	3 "More hours than before" ///
	4 "I am currently not working", replace

lab define reason_lab ///
	0 "Other" ///
	1 "On paid leave" ///
	2 "On unpaid leave " ///
	3 "Released from duty for operational reasons" ///
	4 "I no longer have any assignments" ///
	5 "On sick leave" ///
  6 "I am on short-time working", replace

lab define worktime_time ///
	1 "Never" ///
	2 "Everyday" ///
	3 "Few times a week" ///
	4 "Every couple of weeks (alternating shift)" ///
	5 "Less often (only when necessary)", replace

lab define office_lab ///
	0 "Other" ///
	1 "Still (mainly) at my workplace" ///
	2 "Due to the Coronavirus pandemic (mainly) from home" ///
	3 "Working from home, as always" ///
  4 "An even balance between usual workplace and working from home", replace

lab define officepar_lab ///
	0 "Other" ///
	1 "Still (mainly) at my workplace" ///
	2 "Due to the Coronavirus pandemic (mainly) from home" ///
	3 "Working from home, as always" ///
  4 "Currently not working" ///
	5 "An even balance between usual workplace and working from home", replace

lab define homeoffice_det_lab ///
	0 "No" ///
	1 "Yes, as of late" ///
	2 "Yes, as always" ///
	3 "I’m currently not working", replace

lab define childtvtimea_lab ///
	1 "0-1 hours" ///
	2 "1-2 hours" ///
	3 "2-4 hours" ///
	4 "4-6 hours" ///
	5 "6 hours or more", replace

lab define childtvtimeb_lab ///
	1 "A lot less" ///
	2 "Less" ///
	3 "About the same" ///
	4 "More" ///
	5 "A lot more", replace

lab define divlab_lab ///
	1 "(Almost) exclusively my partner" ///
	2 "Mostly my partner" ///
	3 "About fifty-fifty" ///
	4 "Mostly me" ///
	5 "(Almost) exclusively me" ///
	6 "Exclusively someone else" ///
	7 "Does not apply to us", replace

lab define sat_lab 	1 "very dissatisfied" 7 "very satisfied", replace

lab define concern_lab 1 "very concerned" 7 "not concerned at all", replace

lab define land_lab ///
	1  "Baden-Württemberg" ///
	2  "Bavaria" ///
	3  "Berlin" ///
	4  "Brandenburg" ///
	5  "Bremen" ///
	6  "Hamburg" ///
	7  "Hesse" ///
	8  "Mecklenburg-Western Pomerania" ///
	9  "Lower Saxony" ///
	10  "North Rhine-Westphalia" ///
	11  "Rhineland-Palatinate" ///
	12  "Saarland" ///
	13  "Saxony" ///
	14  "Saxony-Anhalt" ///
	15  "Schleswig-Holstein" ///
	16  "Thuringia" ///
	17  "Abroad", replace

lab define townsize_lab ///
  1 "fewer than 50,000 inhabitants" ///
  2	"50,000 inhabitants or more", replace

lab define educ_lab ///
	0 "Still in school/apprenticeship/university" ///
	1 "No completed apprenticeship/university degree" ///
	2 "Semi-skilled training" ///
	3 "Completed apprenticeship/vocational education" ///
	4 "University degree" ///
	5 "Other", replace

lab define migr_lab ///
	1 "Born in Germany, parents as well" ///
	2 "Born in Germany, at least one parent born abroad" ///
	3 "I was born abroad", replace

lab define hhinc_lab ///
	1 "Living comfortably" ///
	2 "Getting by" ///
	3 "Difficulties getting by" ///
	4 "Barely coping", replace

lab define status2_lab ///
	0 "Employed" ///
	1 "School/university student" ///
	2 "Unemployed" ///
	3 "Retired" ///
	4 "Maternity protection/parental leave" ///
	5 "Homemaker", replace

lab define edu_lab ///
 	0 "Still in school/apprenticeship/university" ///
  1 "None or Semi-skilled training" ///
	2 "Apprenticeship/vocational education" ///
	3 "University degree", replace

lab define fam_lab ///
	1 "Single, no children" ///
	2 "Living with partner, no children" ///
	3 "Living with partner and children" ///
	4 "Single parent", replace

label define childcare_lab ///
	1 "By myself" ///
	2 "Jointly with partner or a different person" ///
	3 "Done by partner" ///
	4 "Other/mix", replace

lab define inc_lab  ///
	1 "Living comfortably" ///
	2 "Getting by" ///
	3 "Difficulties getting by/barely coping", replace

lab define distress_lab ///
	1 "Never" ///
	2 "Rarely" ///
	3 "Sometimes" ///
	4 "Most of the time" ///
	5 "All the time", replace

lab define health_lab ///
	1 "Very good" ///
	2 "Good" ///
	3 "Satisfactory" ///
	4 "Poor" ///
	5 "Bad", replace

lab define wohnsit_lab ///
  1 "Overcrowded" ///
  2 "Adequate" ///
  3 "More than adequate", replace


********************************************************************************
*** Attach value labels ***

lab val link? female q03empsts q04bjoblos homeoffice q14partner ///
	q15achildren q17childcare? q30empstspar outro2 permempl selfempl yesno

lab val q13support q17childcaresub* scale_agree_lab

lab val q01gndr q29gndrpar gndr_lab
lab val q04status status_lab
lab val q05ctrtype ctrtype_lab
lab val q06firmsize firmsize_lab
lab val q07indust indust_lab
lab val q08prof q31profpar prof_lab
lab val q09wtime wtime_lab
lab val q10currenttime currenttime_lab
lab val q11reason reason_lab
lab val q12office office_lab
lab val homeoffice_det homeoffice_det_lab
lab val q17childtvtimea childtvtimea_lab
lab val q17childtvtimeb childtvtimeb_lab
lab val q18divlab* q19currentdiv* divlab_lab
lab val q20sat* sat_lab
lab val q21concern* concern_lab
lab val q23land land_lab
lab val q24townsize townsize_lab
lab val q27educ q33educpar educ_lab
lab val q28migr migr_lab
lab val q32officepar officepar_lab
lab val q34hhinc hhinc_lab

lab val status status2_lab
lab val nrchildren nrchildren_lab
lab val youngestcat youngestcat_lab
lab val fam fam_lab
lab val wohnsit wohnsit_lab
lab val edu p_edu edu_lab
lab val childcare childcare_lab
lab val hhinc inc_lab

exit
