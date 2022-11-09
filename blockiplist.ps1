# This script allows you to block a list of IPs from a text file.
# It adds those IPs to windows firewall, and creates block rules for them.
# Author: MdeeDev
# Github: https://github.com/MdeeDev
# How to use: open cmd in the same directory then
# > powershell.exe -executionpolicy bypass -File \.blockiplist.ps1

$filename=""
write-host "[ ] Welcome to the FireWall Ip BlockList Script"
write-host "[ ] The input text file must contain one IP in each line"
$filename = read-host "[!] Type the path of the file containing the IPs"
$ruleName = read-host "[!] Type the name of the firewall rule"

$newOrUpdate= read-host "[!] Create a New rule? (Y/N) (N=update instead of create new)"

while($newOrUpdate -ne "N" -and $newOrUpdate -ne "Y"  )
{
    $newOrUpdate= read-host "[!] Please type Y or N"
}

write-host "[ ] Loading file..."
$file = Get-Content -Path $filename #-TotalCount 5000
#Set the limit value to 500 entries per firewall rule
$MaxEntries = 500
$nlines=0
$nlines = $file.length
$commaLine=""
$FileIndex=0
#Calculate how many firewall rules needed
$nchunks = $nlines / $MaxEntries
$nchunks = [math]::ceiling($nchunks)

write-host "[!] File contains $nlines lines"
write-host "[!] requires $nchunks FireWall rules"
Start-Sleep -Seconds 2
#read-host "[!] Press Any Key To Continue!"

For($i=0;$i -lt $nchunks;$i++)
{
    $commaLine=""
    For($j=$FileIndex; ($j -lt $FileIndex+$MaxEntries) -and ($j -lt $nlines);$j++)
    {
        $commaLine+=$file[$j]+","
    
	}
	$FileIndex=$FileIndex+$MaxEntries
	
    $progress = [math]::floor($j/$nlines * 100)
	write-host "--------"
	write-host "[ ] Adding Entries... " $progress"%"
	$RuleNameNo=$i+1
    
	write-host "--------"
    if($newOrUpdate -eq "N")
        {  
        #Updating existing rules
        netsh advfirewall firewall set rule name=$ruleName$RuleNameNo new remoteip="$commaLine" 
        }
    else
	   {
        #Creating new rules    
        netsh advfirewall firewall add rule name=$ruleName$RuleNameNo dir=out action=block enable=yes remoteip="$commaLine" profile=any 
       }
	clear 
}

write-host "[ ] Done !"
write-host "[ ] $nchunks Firewall rules added!"
write-host "[ ] $nlines IPs added!"
