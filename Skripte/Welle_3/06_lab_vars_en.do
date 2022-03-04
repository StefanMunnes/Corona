
*** Variablen beschriften ***
// lab var startdate	"Starting date"
// lab var datestamp	"Last activity"
// lab var submitdate	"Submission"
lab var id			"Personal ID (automatic)"
lab var wave "Number of wave"
lab var lastgroup 	"Last completed group of questions"
lab var surveyday "Day of participation"
lab var interviewtime"Duration (in minutes)"

lab var q01gndr 	"Gender"
lab var q02yrbrn 	"Year of Birth"
lab var q03empsts	"Employment"
lab var q04newemp	  "New job"
lab var q04status	"Reason for not being employed"
lab var q04statusother"Reason for not being employed: Other"
lab var q04bjobloss	"Job loss during the pandemic"

lab var q05selfempl"Self-employed/freelancer"
lab var q05cntrct"Type of contract"
lab var q06firmsize	"Firm size"
lab var q07indust	"Sector"
lab var q08prof		"Key/essential service worker"
lab var q10currenttime"Working hours now relative to before"
lab var q11reason	"Reason for currently not working"
lab var q11reasonother "Reason for currently not working: Other"
lab var q11compen "Receiving financial support"
lab var q11compenother "Receiving financial support: Other"
lab var	q11lastwh	"Current: working hours"
lab var	q11usualwh	"Before pandemic: usual working hours"
lab var q12time11	"Current: evening shifts"
lab var q12time12 "Current: night shifts"
lab var q12time21 "Before: evening shifts"
lab var q12time22 "Before: night shifts"
lab var q12office	"Current place of work"
lab var q12officeother"Current place of work: Other"
lab var homeoffice	"Homeoffice"
lab var homeoffice_det"Homeoffice detailed"
lab var q13support	"Perceived employer/client support"

lab var q14partner		 "Relationship status"
lab var q15achildren	 "Children in household"
lab var q17childcare1  "Childcare arrangement: At home, not working"
lab var q17childcare2  "Childcare arrangement: At home, while working"
lab var q17childcare3  "Childcare arrangement: During the day, working when children are sleeping"
lab var q17childcare4  "Childcare arrangement: Partner is looking after them"
lab var q17childcare5  "Childcare arrangement: Emergency care"
lab var q17childcare6  "Childcare arrangement: Grandparents"
lab var q17childcare7  "Childcare arrangement: Relatives, friends, neighbors"
lab var q17childcare8  "Childcare arrangement: Swapping with other parents"
lab var q17childcare9  "Childcare arrangement: Children are home alone"
lab var q17childcare10 "Childcare arrangement: At school/nursery (reduced hours)"
lab var q17childcare11 "Childcare arrangement: At school/nursery (usual hours)"
lab var q17childcareother	"Childcare arrangement: Other"

lab var q17childtvtimea"Children’s current screen time"

lab var q17childcaresub11 "Current: exhausted because of childcare"
lab var q17childcaresub12 "Current: trapped by parental responsibilities"
lab var q17childcaresub21 "Before: exhausted because of childcare"
lab var q17childcaresub22 "Before: trapped by parental responsibilities"

lab var q17gendernorm1 "Working mother's relationship with own child can be just as warm"
lab var q17gendernorm2 "More important for wife to support husband's career than her own"
lab var q17gendernorm3 "Small child suffers if his/her mother works"
lab var q17gendernorm4 "Breadwinner husband/housewife model better for everyone concerned"
lab var q17gendernorm5 "Child benefits from his/her mother having a job"
lab var q17gendernorm6 "Married woman shouldn't work if not necessary/not enough jobs"
lab var q17gendernorm7 "Both spouses should contribute to household income"
lab var q17gendernorm8 "Fathers and mothers equally well-suited for childrearing"

lab var q19currentdiv1 "Current distribution of household work: Housework"
lab var q19currentdiv2 "Current distribution of household work: Grocery shopping"
lab var q19currentdiv3 "Current distribution of household work: Repairs"
lab var q19currentdiv4 "Current distribution of household work: Financial/administrative errands"
lab var q19currentdiv5 "Current distribution of household work: Childcare"

lab var q20sat11	"Current satisfaction: Work"
lab var q20sat12	"Current satisfaction: Relationship"
lab var q20sat13	"Current satisfaction: Family life"
lab var q20sat14	"Current satisfaction: Distribution of tasks within the household"
lab var q20sat15	"Current satisfaction: Quality of social contacts"
lab var q20sat16	"Current satisfaction: Mutual helpfulness within your neighborhood"
lab var q20sat17	"Current satisfaction: Life in general"

lab var q21concern11 "Current concerns: Financial situation"
lab var q21concern12 "Current concerns: Loss of job"
lab var q21concern13 "Current concerns: Own health"
lab var q21concern14 "Current concerns: Health of relatives"

// lab var q22challenge "Current greatest challenge"

lab var q23plz 			  "Postcode (2 digits)"
lab var	q25otherplace	"Different place of residence"
lab var q25otherhhmem	"Additional people in household"

lab var	q25otherplaceother	"Different plac: Other"
lab var q25otherhhmemother	"Additional people: Other"

lab var q30empstspar		  "Partner: employment"
lab var q30currenttimepar "Partner: working hours now relative to before"

lab var q31usualwhpar "Partner: usual working hours"
lab var q31lastwhpar  "Partner: current working hours"

lab var q32officepar "Partner: current place of work"
lab var q32officeparother	"Partner: current place of work: Other"

lab var q34hhinc	"Rating household income"
lab var q34prevhhinc"Before: rating household income"

lab var q35distress11 "Current: anxious, nervous, restless"
lab var q35distress12 "Current: depressed, hopeless, strained"
lab var q35distress21 "Before: anxious, nervous, restless"
lab var q35distress22 "Before: depressed, hopeless, strained"
lab var q35health1    "Current: physical health"
lab var q35health2    "Before: physical health"


lab var female "female"
lab var agegr  "Age cohort"
lab var status "Main activity"

lab var sysjob "Key/essential worker"
lab var fam 	 "Family situation"
lab var hhinc  "Rating household income"


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

lab define cntrct_lab ///
  1 "Permanent contract" ///
  2 "Fixed-term contract", replace

lab define firmsize_lab 1 "<20" 2 "20-200" 3 ">200", replace

lab define indust_lab ///
  1	"Agriculture, forestry and fishing" ///
  2	"Manufacturing, mining, and related industries" ///
  3	"Construction" ///
  4	"Retail, hospitality, transport, storage" ///
  5	"Information and communication" ///
  6	"Finance and insurance" ///
  7	"Scientific, technical, and support service activities" ///
  8	"Public administration and defense" ///
  9	"Education, human health, and social work" ///
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
  1 	"up to 15/week" 2	"16 to 25 hours/week" ///
  3	"26 to 37 hours/week" 4	"38 hours/week or more", replace

lab define currenttime_lab ///
  1 	"As many hours as before" ///
  2	"Fewer hours than before"  ///
  3	"More hours than before"  ///
  4	"I am currently not working", replace

lab define compen_lab ///
  0 "Yes, other" ///
  1 "No (my income is reduced proportionally to my working time)" ///
  2	"Yes, short-time working scheme" ///
  3	"Yes, I'm still earning the same amount", replace

lab define reason_lab ///
  0	"Other" ///
  1	"On paid leave" ///
  2	"On unpaid leave " ///
  3	"Released from duty for operational reasons" ///
  4	"I no longer have any assignments" ///
  5	"On sick leave" ///
  6 "I am on short-time working", replace

lab define worktime_lab ///
  1 "Never" ///
  2 "Every day" ///
  3 "Few times a week" ///
  4 "Every couple of weeks (alternating shift)" ///
  5 "Less often (only when necessary)", replace

lab define office_lab ///
  0	"Other" ///
  1	"Still (mainly) at my workplace" ///
  2	"Due to the Coronavirus pandemic (mainly) from home" ///
  3	"Working from home, as always" ///
  4 "An even balance between usual workplace and working from home", replace

lab define officepar_lab ///
  0	"Other" ///
  1	"Still (mainly) at my workplace" ///
  2	"Due to the Coronavirus pandemic (mainly) from home" ///
  3	"Working from home, as always" ///
  4 "Currently not working" ///
  5	"An even balance between usual workplace and working from home", replace

lab define homeoffice_det_lab ///
  0 "No" 	///
  1 "Yes, as of late" ///
  2	"Yes, as always" ///
  3 "I’m currently not working", replace

lab define childtvtimea_lab ///
  1	"0-1 hours" ///
  2	"1-2 hours" ///
  3	"2-4 hours" ///
  4	"4-6 hours" ///
  5	"6 hours or more", replace

lab define childtvtimeb_lab ///
  1	"A lot less" ///
  2	"Less" ///
  3	"About the same" ///
  4	"More" ///
  5	"A lot more", replace

lab define divlab_lab ///
  1	"(Almost) exclusively my partner" ///
  2	"Mostly my partner" ///
  3	"About fifty-fifty" ///
  4	"Mostly me" ///
  5	"(Almost) exclusively me" ///
  6	"Exclusively someone else" ///
  7	"Does not apply to us", replace

lab define sat_lab  1 "very dissatisfied" 7 "very satisfied", replace

lab define concern_lab 	1 "very concerned" 7 "not concerned at all", replace

lab define other_lab 2 "No" 1 "Yes, namely:", replace

lab define hhinc_lab ///
  1 "Living comfortably" ///
  2 "Getting by" ///
  3 "Difficulties getting by" ///
  4 "Barely coping", replace

lab define agegr_lab ///
  1 "18-24" ///
  2 "25-29" ///
  3 "30-34" ///
  4 "35-39" ///
  5 "40-44" ///
  6 "45-49" ///
  7 "50-54" ///
  8 "55-59" ///
  9 "60-64" ///
	10 "65-69" ///
	11 "70-74" ///
  12 "75-79" ///
	13 "80+", replace

lab define status2_lab ///
  0  "Employed" ///
  1  "School/university student" ///
  2  "Unemployed" ///
  3  "Retired" ///
  4 "Maternity protection/parental leave" ///
  5 "Homemaker", replace

lab define edu_lab ///
  0 "Still in school/apprenticeship/university" ///
	1 "None or Semi-skilled training" ///
 	2 "Apprenticeship/vocational education" ///
  3 "University degree", replace

lab define size_lab 5 "5+", replace

lab define nrchildren_lab 3 "3+", replace

lab define youngestcat_lab 1 "<3" 2 "3-5" 3 "6-10" 4 "11-17", replace

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

lab define currenttimepar_lab ///
  1 "As many hours as before" ///
  2 "Fewer hours than before"  ///
  3 "More hours than before"  ///
  4 "Currently not working", replace


********************************************************************************
*** Attach value labels ***

lab val female q03empsts q04newemp q04bjoblos q05selfempl homeoffice ///
	q14partner q15achildren q17childcare? q30empstspar sysjob ///
	yesno

lab val q13support q17childcaresub* q17gendernorm? scale_agree_lab

lab val q01gndr gndr_lab
lab val q04status status_lab
lab val q05cntrct cntrct_lab
lab val q06firmsize firmsize_lab
lab val q07indust indust_lab
lab val q08prof prof_lab
lab val q10currenttime currenttime_lab
lab val q11reason reason_lab
lab val q11compen compen_lab
lab val q12time* worktime_lab
lab val q12office office_lab
lab val homeoffice_det homeoffice_det_lab
lab val q17childtvtimea childtvtimea_lab
lab val q19currentdiv* divlab_lab
lab val q20sat* sat_lab
lab val q21concern* concern_lab
lab val q25otherhhmem q25otherplace other_lab
lab val q30currenttimepar currenttimepar_lab
lab val q32officepar officepar_lab
lab val q34hhinc q34prevhhinc hhinc_lab
lab val q35distress* distress_lab
lab val q35health? health_lab

lab val agegr agegr_lab
lab val status status2_lab
lab val fam fam_lab
lab val hhinc inc_lab

exit
