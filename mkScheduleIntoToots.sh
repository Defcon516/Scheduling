#for((i=$(date -d "2023-05-16 17:16:00" +"%s");i<=$((0x7fffffff));i=i+86400));do 
for((i=$(date -d "2023-05-16 17:16:00" +"%s");i<=$(date -d "2024-01-01 00:00:00 UTC" +"%s");i=i+86400));do 
	printf "$(date -d @${i} +"%Y-%m-%d %b %a")" | grep -i "Fri" >> temp.$(date -d @${i} +"%Y-%m").txt ; 
done ; 

for i in temp.????-??.txt ; do 
	if [ $(wc -l "${i}" | tr " \t" "\n" | head -n 1) -eq 5 ] ; then 
		tail -n 1 "${i}" >> temp.txt
	fi ; 
	rm "${i}" ; 
done ; 

j=0;
cat temp.txt | while read i ; do 
	j=$((${j}+1)) ; 
	k="$(date -d "${i:0:10} 17:16:00" +"%s")" ; 
	printf "$(date -d "${i:0:10} 18:31:00" +"%s")\t${j}\tOrgMeet\tMeeting Ends\n" ; 
	printf "$(date -d @${k} +"%s")"\t${j}\tOrgMeet\tMeeting Begins\n" ; 
	printf "$(date -d @$((${k}-3600)) +"%s")"\t${j}\tOrgMeet\tReminder one hour prior\n" ; 
	printf "$(date -d @$((${k}-86400)) +"%s")"\t${j}\tOrgMeet\tReminder one day prior\n" ; 
	printf "$(date -d @$((${k}-(7*86400))) +"%s")"\t${j}\tOrgMeet\tReminder one week prior\n" ; 
done ; 

rm temp.txt ; 
