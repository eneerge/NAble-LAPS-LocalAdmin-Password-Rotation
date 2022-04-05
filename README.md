# NAble-LAPS-LocalAdmin-Password-Rotation
This is a LAPs like solution for NAble RMM.

To use this script, configure your RMM monitoring template to run an automated task daily.

The script will:
- Step 1: Delete all admin accounts on the machine matching the scripts prefix. IE: Only delete accounts created by the script
- Step 2: Create a new local admin on the machine using the scripts prefix
  - Account will expire by default at 5:30pm in the local system's time
- Step 3: Send the username and password back to RMM

To view the username and password in RMM:
- Click on the workstation
- Click on the "Tasks"
- Locate the "Create admin account" script (or whatever you named) and click the "Output" for the script.


The script allows you to use a custom word list and special character list for the passwords. By using a word list and only certain special characters, you can easily communicate the temporary password over the phone if necessary.

![Screenshot1](/screenshots/rmm-create-temp-admin1.png)
![Screenshot2](/screenshots/rmm-create-temp-admin-result.png)
