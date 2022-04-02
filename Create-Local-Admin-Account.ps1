# Delete existing admin accounts
# NOTE: This deletes all accounts starting with "tadmin" by default. If you use tadmin in your environment, you should adjust this
$existingAdmins = Get-LocalUser "tadmin*"
$existingAdmins | Remove-LocalUser

# Create the new one
$adminUser = "tadmin" + (get-random -Minimum 10 -Maximum 999) # tadmin<number>

#############################################################################
## Custom to your liking. Using a wordlist gives us a slightly easier to type password
$wordlist = @(
  "chicken"
  ,"porkchop"
  ,"hamburger"
  ,"beef"
  ,"sushi"
  ,"popcorn"
  ,"pickle"
  ,"orange"
  ,"apple"
  ,"administration"
)

# These special characters are easier to communicate over the phone. No one knows what a "tilde ~" symbol is, hah.
$specialList = @(
  "!" # exclamation point
  ,"@" # at symbol
  ,"#" # pound sign / hash tag
  ,"$" # dollar sign
  ,"%" # percent sign
  ,"&" # ampersand
  ,"*" # asterisk
)

# Generate a password in the format: <Wordlist Word><SpecialChar><RandomNumber><randomChars>
$randomPassword = $wordlist[(get-random -minimum 0 -Maximum ($wordList.Count-1))]
$randomPassword += $specialList[(get-random -minimum 0 -Maximum ($specialList.Count-1))]
$randomPassword += (get-random -Minimum 100 -Maximum 999)
$randomPassword += (-join ((65..90) + (97..122) | Get-Random -Count 4 | % {[char]$_})).ToLower()

# Convert to secure password so it can be sent to new-localuser command
$securedPassword = ConvertTo-SecureString -string $randomPassword -AsPlainText -Force

# Expire the account by default in x hours
# Default is for 10 hours. So if this script runs at 7am daily, the account will expire at 5pm (End of day).
$accountExpires = (get-date).AddHours(10)

# Create the account
New-LocalUser -Name $adminUser -Password $securedPassword -AccountExpires $accountExpires -UserMayNotChangePassword -ErrorAction SilentlyContinue | Out-Null

# Error creating user
if ($Error[0].InvocationInfo.MyCommand.Name -eq "New-LocalUser") {
  Write-Host "There was an error creating the account: "  $Error[0]
  if ($env:USERNAME -eq "System") {
    exit 1001
  }
}

# User created
else {
    Add-LocalGroupMember -Group Administrators -Member $adminUser

    ## No error adding user as admin
    if ($Error -eq $null -or $Error[0].InvocationInfo.MyCommand.Name -ne "Add-LocalGroupMember") {
        Write-Host "$($adminUser)"
        Write-Host $randomPassword
        Write-Host "The account was created and will expire in 8 hours."

        if ($env:USERNAME -eq "System") {
          exit 0
        }
    }
    ## Error adding user to administrators group
    else {
        Write-Host "There was an error elevating the account permission: "  $Error[0]
        if ($env:USERNAME -eq "System") {
          exit 1001
        }
    }
}
