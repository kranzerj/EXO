#Install-Module -Name ExchangeOnlineManagement
#Set-ExecutionPolicy RemoteSigned
Connect-ExchangeOnline -UserPrincipalName your-email@domain.com
 
 Get-Recipient -ResultSize Unlimited | Where-Object {$_.PrimarySmtpAddress -like '*@*'} | ForEach-Object { $_.EmailAddresses | Where-Object { $_.PrefixString -eq 'SMTP' } | ForEach-Object { [pscustomobject]@{ DisplayName = $_.DisplayName; PrimarySmtpAddress = $_.PrimarySmtpAddress; SMTPAddress = $_.AddressString.Trim('}') } } } | Export-Csv -Path "C:\__addresen.csv" -NoTypeInformation -Encoding UTF8
