import urllib.parse
import requests
import json
main_api = 'http://maps.googleapis.com/maps/api/geocode/json?'


address = 'lhr'
url = main_api + urllib.parse.urlencode({'address':address})


json_data = requests.get(url).json()

#print(json_data)

#json_status = json_data['status']
#print('API status: ' +json_status)

#reading from a file:


#writing to a file:
filename = 'googleapi.txt'
with open(filename, 'w') as f_obj:
	json.dump(json_data, f_obj)

#	file_object.write(str(json_data))