players = ["charles", "martina","michael","florence", "eli"]
print('\n')
print('printing first,third and fourth')
print(players[0:3])
print('\n')
print('printing second,third and fourth')
print(players[1:4])
print('\n')
print('printing second,and all the rest')
print(players[2:])
print('\n')
print('printing last 3 names')
print(players[-3:])
print('\n')

for player in players[:3]:
	print(player.title())
	