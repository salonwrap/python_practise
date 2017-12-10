import json
filename = 'googleapi.txt'
with open(filename) as f_obj:
	json_data = json.load(f_obj)
#	print(json_data)

json_status = json_data['status']
print('API status: ' +json_status)

#json_data = {'status': 'OK'}

