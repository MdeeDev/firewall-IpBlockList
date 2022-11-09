# Firewall-IpBlockList
This is a PowerShell script, that can be used to automate adding windows firewall rules.
It can take a list of malicious IPs and block them from the firewall.

## Where can i get lists of malicious/malware or blacklisted IPs ?
You can find them here:
https://github.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/tree/master/ips

The lists are updated regularly.

## How to use?
First you need a file containing the list of IPs.
The list must be one IP per line.

Open cmd. then use this command:
```
powershell.exe -executionpolicy bypass -File \.blockiplist.ps1
```
