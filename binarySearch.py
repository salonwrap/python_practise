def binarySearch(alist,item):
	if len(alist) == 0:
		print('item not found')
		return False
	else: 
		midpoint = len(alist)//2
		print(len(alist))
		print('lenght of list')
		print(alist[midpoint])
		print('midpoint test value')
		if alist[midpoint] == item:
			return True
		else:
			if item<alist[midpoint]:
				print('item is less than midpoint')
				print(alist[:midpoint])
				return binarySearch(alist[:midpoint], item)
			else:
				print('item is greater than midpoint')
				print(alist[midpoint +1:])
				return binarySearch(alist[midpoint + 1:], item)



testlist = [1,3,4,6,7,10]
#print(binarySearch(testlist,3))
print(binarySearch(testlist,2))
