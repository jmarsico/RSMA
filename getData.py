#call this script to get data

# https://128.2.109.159/piwebapi/
# Credentials : CMU_Students
# Pass : Energy1?


import requests
from requests.auth import HTTPBasicAuth
import json

myURL = "https://128.2.109.159/piwebapi/streams/A0EDrCQspyh10qS-uAmnJ8eXAL0kemPll5BGfhGhbNZgNbw8T76JDZWhlUE9yV5tbOekwMTI4LjIuMTA5LjE1OVxDQU1QVVMgU1VCTUVURVJJTkdcTUFJTiBDQU1QVVNcR0FURVN8UE9XRVIgSU5URU5TSVRZ/value"
response = json.loads(requests.get(myURL, auth=HTTPBasicAuth('CMU_Students', 'Energy1?'), verify=False).text)

with open('test.json', 'w') as outfile:
    json.dump(response, outfile, sort_keys = True, indent = 4,
ensure_ascii=False)


https://CMU_Students:Energy1%3F@128.2.109.159/piwebapi/streams/A0EDrCQspyh10qS-uAmnJ8eXAL0kemPll5BGfhGhbNZgNbw8T76JDZWhlUE9yV5tbOekwMTI4LjIuMTA5LjE1OVxDQU1QVVMgU1VCTUVURVJJTkdcTUFJTiBDQU1QVVNcR0FURVN8UE9XRVIgSU5URU5TSVRZ/value

https://128.2.109.159/piwebapi/streams/A0EDrCQspyh10qS-uAmnJ8eXAL0kemPll5BGfhGhbNZgNbw8T76JDZWhlUE9yV5tbOekwMTI4LjIuMTA5LjE1OVxDQU1QVVMgU1VCTUVURVJJTkdcTUFJTiBDQU1QVVNcR0FURVN8UE9XRVIgSU5URU5TSVRZ/value