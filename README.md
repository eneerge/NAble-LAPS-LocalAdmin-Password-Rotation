# NAble-LAPS-LocalAdmin-Password-Rotation
This is a LAPs like solution for NAble RMM.

To use this script, configure your RMM monitoring template to run an automated task daily.

The script will:
- Step 1: Delete all admin accounts on the machine matching the scripts prefix. IE: Only delete accounts created by the script
- Step 2: Create a new local admin on the machine using the scripts prefix
  - Account will not expire. If user is offline for extended period, the last admin account created and sent to RMM will still be available.
- Step 3: Send the username and password back to RMM

To view the username and password in RMM:
- Click on the workstation
- Click on the "Tasks"
- Locate the "Create admin account" script (or whatever you named) and click the "Output" for the script.

The script allows you to use a custom word list and special character list for the passwords. By using a word list and only certain special characters, you can easily communicate the temporary password over the phone if necessary.

## Notes
When logging into a machine, you must prefix the username with a dot slash (EG: .\tadmin101) or the login may fail. This dot slash tells the login to use a local user account.

![Screenshot1](/screenshots/rmm-create-temp-admin1.png)
![Screenshot2](/screenshots/rmm-create-temp-admin-result.png)
