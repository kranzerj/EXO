#Install-Module -Name ExchangeOnlineManagement

Connect-ExchangeOnline -UserPrincipalName your-email@domain.com

Get-Mailbox -ResultSize Unlimited | ForEach-Object { $primary = $_.PrimarySmtpAddress; $others = $_.EmailAddresses | Where-Object {$_ -like "SMTP:*" -and $_ -ne "SMTP:$primary"} | ForEach-Object {$_ -replace "SMTP:"}; "$($_.DisplayName), $primary, $($others -join "; ")}" } | Export-Csv  C:\__\addresen.csv
