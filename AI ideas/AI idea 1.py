'''
AI idea 1
Python sketch for implementing AI
8/18: Getting the bare bones working right now
'''

def getField():
	inputFile = open("inputField.txt")
	fileContent = inputFile.readlines()
	for i in range(0, len(fileContent)):
		fileContent[i] = fileContent[i].replace('\n','')
		fileContent[i] = list(fileContent[i])
	return fileContent

def printResult(fileContent):
	outputFile = open("outputField.txt", "w")
	for i in range(0, len(fileContent)):
		fileContent[i].extend('\n')
		fileContent[i] = ''.join(fileContent[i])
	fileContent = ''.join(fileContent)
	outputFile.write(fileContent)

a = getField()
printResult(a)
piece1 = ['00000',
		  '00100',
		  '00100',
		  '00100',
		  '00100'] # Need algorithm to get equivalent rotation pieces
		 		  # In this sketch I can just define the alternate configurations
# In the java program Piece class can have definition for piece with all the orientations



'''

def disp(field, height, width):
	for row in range(0, height):
		for col in range(0, width):
			print field[row][col],
		print '\n'

height = 5
width = 10
line = [0] * width
field = []
for i in range(0, height):
	field.append(line)


disp(field, height, width)
'''
