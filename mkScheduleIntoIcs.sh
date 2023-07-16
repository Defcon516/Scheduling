rm *.ics temp* 2>/dev/null

for((i=$(date -d "2023-05-16 17:16:00" +"%s");i<=$((0x7fffffff));i=i+86400));do 
	printf "$(date -d @${i} +"%Y-%m-%d %b %a")" | grep -i "Fri" >> temp.$(date -d @${i} +"%Y-%m").txt ; 
done ; 

for i in temp.????-??.txt ; do 
	if [ $(wc -l "${i}" | tr " \t" "\n" | head -n 1) -eq 5 ] ; then 
		tail -n 1 "${i}" >> temp.txt
	fi ; 
	rm "${i}" ; 
done ; 

j=0;
printf "BEGIN:VCALENDAR\n" > "temp.ics" ; 
printf "VERSION:2.0\n" >> "temp.ics" ; 
printf "PRODID:-//Defcon 516//NONSGML v1.0//EN\n" >> "temp.ics" ; 
sort temp.txt | while read i ; do 
	j=$((${j}+1)) ; 
	printf "BEGIN:VEVENT\n" ; 
	printf "UID:00440053-0035-0031-0036-0000%08x\n" $(date -d "${i:0:10} 17:16:00" +"%s") ; 
	printf "DTSTAMP:$(date -u -d @$(date -d "${i:0:10} 17:16:00" +"%s") +"%Y%m%dT%H%M%SZ")\n" ; 
	printf "DTSTART:$(date -d "${i:0:10} 17:16:00" +"%Y%m%dT%H%M%S%z")\n" ; 
	printf "DTEND:$(date -d "${i:0:10} 18:31:00" +"%Y%m%dT%H%M%S%z")\n" ; 
	printf "SUMMARY:${j}" ; 
	o="XX" ; 
	if [ $(( ${j} % 10 )) -eq 1 ] && [ $(( ${j} % 100 )) -ne 11 ] ; then 
		o="st" ; 
	else 
		if [ $(( ${j} % 10 )) -eq 2 ] && [ $(( ${j} % 100 )) -ne 12 ] ; then 
			o="nd" ; 
		else 
			if [ $(( ${j} % 10 )) -eq 3 ] && [ $(( ${j} % 100 )) -ne 13 ] ; then 
				o="rd" ; 
			else 
				o="th" ; 
			fi ; 
		fi ; 
	fi ; 
	printf "${o} Organizational Defcon 516 Meeting\n"
	printf "ORGANIZER;CN=Defcon 516:MAILTO:516@Defcon516.org\n" ; 
	printf "END:VEVENT\n" ; 
done >> "temp.ics" ; 
printf "END:VCALENDAR\n" >> "temp.ics" ; 

rm temp.txt ; 
mv "temp.ics" "Defcon 516 Organizational Meetings.ics" ; 

printf "BEGIN:VCALENDAR\n" > "temp.ics" ; 
printf "VERSION:2.0\n" >> "temp.ics" ; 
printf "PRODID:-//Defcon 516//NONSGML v1.0//EN\n" >> "temp.ics" ; 
j=-1; 
for((i=$(date -d "2023-05-16 17:16:00" +"%s");i<=$((0x7fffffff));i=i+86400));do 
	if [ "$(date -d @${i} +"%d")" = "16" ] ; then 
		j=$((${j}+1)) ; 
		k="$(date -d @${i} +"%Y-%m-%d")" ; 
		printf "BEGIN:VEVENT\n" ; 
		printf "UID:00440053-0035-0031-0036-0000%08x\n" ${i} ; 
		printf "DTSTAMP:$(date -u -d @${i} +"%Y%m%dT%H%M%SZ")\n" ; 
		printf "DTSTART:$(date -d "${k} 17:16:00" +"%Y%m%dT%H%M%S%z")\n" ; 
		printf "DTEND:$(date -d "${k} 18:31:00" +"%Y%m%dT%H%M%S%z")\n" ; 
		printf "SUMMARY:${j}" ; 
		o="XX" ; 
		if [ $(( ${j} % 10 )) -eq 1 ] && [ $(( ${j} % 100 )) -ne 11 ] ; then 
			o="st" ; 
		else 
			if [ $(( ${j} % 10 )) -eq 2 ] && [ $(( ${j} % 100 )) -ne 12 ] ; then 
				o="nd" ; 
			else 
				if [ $(( ${j} % 10 )) -eq 3 ] && [ $(( ${j} % 100 )) -ne 13 ] ; then 
					o="rd" ; 
				else 
					o="th" ; 
				fi ; 
			fi ; 
		fi ; 
		printf "${o} General Defcon 516 Meeting\n"
		printf "ORGANIZER;CN=Defcon 516:MAILTO:516@Defcon516.org\n" ; 
		printf "END:VEVENT\n" ; 
	fi ; 
done >> "temp.ics" ; 
printf "END:VCALENDAR\n" >> "temp.ics" ; 
mv "temp.ics" "Defcon 516 General Meetings.ics" ; 

