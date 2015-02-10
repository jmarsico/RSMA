#call this script to get data

# https://128.2.109.159/piwebapi/
# Credentials : CMU_Students
# Pass : Energy1?


import requests
from requests.auth import HTTPBasicAuth
import json

myURL = "<URL>"
response = json.loads(requests.get(myURL, auth=HTTPBasicAuth('USER', 'PASS?'), verify=False).text)

with open('test.json', 'w') as outfile:
    json.dump(response, outfile, sort_keys = True, indent = 4,
ensure_ascii=False)



