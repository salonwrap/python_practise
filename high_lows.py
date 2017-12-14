import csv
from datetime import datetime as d 
from matplotlib import pyplot as plt 


filename = 'sitka_weather_2014.csv'

with open(filename) as f:
	reader = csv.reader(f)
	header_row = next(reader)
#	print(header_row)


#for index, column_header in enumerate(header_row):
#	print(index, column_header)

	highs = []
	dates = []
	for row in reader:
		current_date = d.strptime(row[0], '%Y-%m-%d')
		dates.append(current_date)

		high = int(row[1])
		highs.append(high)
#	print(dates)


# Plot data

fig = plt.figure(dpi= 80, figsize=(10,6))
plt.plot(dates, highs, c = 'red')

#Format plot
plt.title('Daily high temperature, year of 2014', fontsize= 24)
plt.xlabel('', fontsize=16)
fig.autofmt_xdate()
plt.ylabel('Temperature (F)', fontsize=16)
plt.tick_params(axis='both',which='major',labelsize=16)

plt.savefig('highs.png')






