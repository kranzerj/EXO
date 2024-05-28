#Install-Module -Name ExchangeOnlineManagement

Connect-ExchangeOnline -UserPrincipalName your-email@domain.com


# Abrufen aller E-Mail-Adressen vom Typ SMTP
$mailboxes = Get-Recipient -ResultSize Unlimited | Where-Object {$_.PrimarySmtpAddress -like '*@*'} | Select-Object DisplayName,PrimarySmtpAddress,EmailAddresses

# Filtern der SMTP-Adressen und Entfernen unerwünschter Klammern
$smtpAddresses = @()
foreach ($mailbox in $mailboxes) {
    foreach ($email in $mailbox.EmailAddresses) {
        if ($email.PrefixString -eq 'SMTP') {
            $smtpAddresses += [pscustomobject]@{
                DisplayName = $mailbox.DisplayName
                PrimarySmtpAddress = $mailbox.PrimarySmtpAddress
                SMTPAddress = $email.AddressString.Trim('}')
            }
        }
    }
}

# Exportieren der Daten in eine CSV-Datei mit Spaltenbeschreibung
$smtpAddresses | Export-Csv -Path "C:\__\addresen.csv" -NoTypeInformation -Encoding UTF8 -Delimiter ','


