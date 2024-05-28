#Install-Module -Name ExchangeOnlineManagement
#Set-ExecutionPolicy RemoteSigned
Connect-ExchangeOnline -UserPrincipalName your-email@domain.com

Get-Mailbox -ResultSize Unlimited | ForEach-Object { $primary = $_.PrimarySmtpAddress; $others = $_.EmailAddresses | Where-Object {$_ -like "SMTP:*" -and $_ -ne "SMTP:$primary"} | ForEach-Object {$_ -replace "SMTP:"}; [PSCustomObject]@{DisplayName = $_.DisplayName; PrimarySMTPAddress = $primary; OtherSMTPAddresses = ($others -join "; ")} } | Export-Csv -Path "C:\__\addresen.csv" -NoTypeInformation

