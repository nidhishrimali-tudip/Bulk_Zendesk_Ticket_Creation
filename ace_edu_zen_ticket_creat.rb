require 'rest-client'
require 'csv' 
require 'json'

CSV.foreach("ace_edu_sheet.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
  hashed_row = row.to_hash
  email = hashed_row[:email]
  start_date = hashed_row[:start_date]
  end_date = hashed_row[:end_date] 
  qlcampaign = hashed_row[:qlcampaign]
  subject = "[VIP][MARKETING][NA] QL Campaign Request"
  body = "Hi Qwiklabs Team, 
New QL campaign request in the tracker: https://docs.google.com/spreadsheets/d/1l1790iNe10YvUOANHoM4y-j1Xha9gJbvL9u51Qag54A/edit#gid=1425299298

Email: #{email} 
Starting date: #{start_date}
End date: #{end_date}"

    
    
    
  response = RestClient.post 'https://qwiklab.zendesk.com/api/v2/tickets.json', {"ticket": {"subject": "#{subject}", "comment": { "body": "#{body}" }, "requester": { "locale_id": 8, "name": "Atish Kumbhar", "email": "Kumbhara@google.com" }}}, {"authorization": "Basic a3VtYmhhcmFAZ29vZ2xlLmNvbTp0dWRpcDEyMw=="}


  update_response = RestClient.put JSON.parse(response)["ticket"]["url"], {
      "ticket": {
      "comment": { "body": "Hi,

Requester Email id: #{email}
Starting date: #{start_date}
End date: #{end_date}
Quest Name/Lab Name: Cloud Architecture 
QL campaign link: #{qlcampaign}

See you in the cloud,
Atish from Qwiklabs", "public": true },
                                   "status":  "closed",
      "tags":[ "admin-action", "marketing", "type-gcp", "spl", "vip"],
      "assignee_email": "kumbhara@google.com"
  }
  }, {"authorization": "test"} // Provide the authorization key of Agent's account.

end



