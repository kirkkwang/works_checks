# Works Check
---
##### NOTE: These directions are pretty general since Google updates their UI all the time.  In general, these direction should get you to where you need to go.
---
### Setup
- Clone the repo
- Create a Google API key
- Share Google Sheet

##### Clone the repo
- In terminal 
  - `cd` into desired folder
  - `$ git clone https://github.com/kirkkwang/works-check.git`
  - `$ cd works-check`

##### Create a Google API key
- Go to https://console.cloud.google.com/apis/dashboard
  - create a new project
  - give it a name and location
- Enable APIs and Services
  - enable Google Drive API and Google Sheets API
- Create credentials
  - pick Service Account
  - give it a name and optional description (role should be 'Owner')
  - create and continue and done
  - click into account
  - save that email for later
  - choose 'KEYS'
  - create a new JSON key
  - a download should execute
  - rename newly downloaded file to `client_secret.json`
  - store json the root of the project folder
- Share Google Sheet
  - nagivate to the Google Sheet and click 'Share'
  - uncheck 'Notify people' and add copied email in there and send
---
### Usage
Now that the Google Sheet is hooked up with the script, it should be as easy as running `$ ruby works_check.rb` in the terminal

If it does not success because of a bundler issue, run `$ bundle` then try again.