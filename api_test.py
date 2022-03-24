import requests

response_API = requests.get('http://www7.slv.se/apilivsmedel/LivsmedelService.svc/Livsmedel/Klassificering/20170101')

print(response_API.status_code)
print(response_API)


