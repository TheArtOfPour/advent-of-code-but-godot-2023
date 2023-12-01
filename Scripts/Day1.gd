extends Node3D

@onready var label_3d = $Label3D
@onready var star = $Star
@onready var star_2 = $Star2

const num_text = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
const num_nums = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	star.rotate_y(0.1)
	star_2.rotate_y(0.1)
	

func test():
	var file: FileAccess = FileAccess.open("res://Inputs/Day1Test.txt", FileAccess.READ)
	if !file.file_exists("res://Inputs/Day1Test.txt"):
		label_3d.text = "Test Case Not Found"
		pass
	label_3d.text = "We Testin'\n\n"
	calculateFileNumbers(file)


func full():
	var file: FileAccess = FileAccess.open("res://Inputs/Day1.txt", FileAccess.READ)
	if !file.file_exists("res://Inputs/Day1.txt"):
		label_3d.text = "Input Not Found"
		pass
	label_3d.text = "Calculating...\n\n"
	var result = calculateFileNumbers(file)
	print(result)
	label_3d.text = "Calculating...\n\n" + str(result)


func test1B():
	var file: FileAccess = FileAccess.open("res://Inputs/Day1BTest.txt", FileAccess.READ)
	if !file.file_exists("res://Inputs/Day1BTest.txt"):
		label_3d.text = "Test Case Not Found"
		pass
	label_3d.text = "We Testin'\n\n"
	calculateFileNumbersWithText(file)


func full1B():
	var file: FileAccess = FileAccess.open("res://Inputs/Day1.txt", FileAccess.READ)
	if !file.file_exists("res://Inputs/Day1.txt"):
		label_3d.text = "Input Not Found"
		pass
	var result = calculateFileNumbersWithText(file)
	print(result)
	label_3d.text = "Calculating...\n\n" + str(result)


func calculateFileNumbers(file):
	# for each line
	# 	find the first digit
	# 	find the last digit
	#	combine them into a 2 digit number
	#	sum those numbers
	var sum = 0
	while !file.eof_reached():
		var line = file.get_line()
		if line == "":
			continue
		var first = -1
		var last = -1
		for char in line:
			if char.is_valid_int():
				if first == -1:
					first = int(char)
				last = int(char)
		var combined = 10*first + last
		label_3d.text += line + " -> " + str(combined) + "\n"
		sum += combined
	label_3d.text += "\nAnswer: " + str(sum)
	return sum


func calculateFileNumbersWithText(file):
	# for each line
	# 	find the first digit
	# 	find the last digit
	#	combine them into a 2 digit number
	#	sum those numbers
	var sum = 0
	while !file.eof_reached():
		var line = file.get_line()
		if line == "":
			continue
			
		var original = line
		
		# non-destructive to allow for overlaps :D
		var first_num
		var last_num
		
		var first_text_position = 9223372036854775807 # max int
		for i in range(0, num_text.size()):
			var position = line.find(num_text[i])
			if position != -1 and position < first_text_position:
				first_text_position = position
				first_num = i + 1
		for i in range(0, num_nums.size()):
			var position = line.find(num_nums[i])
			if position != -1 and position < first_text_position:
				first_text_position = position
				first_num = i + 1
		
		var last_text_position = 9223372036854775807 # max int
		var reversed = line.reverse()
		for i in range(0, num_text.size()):
			var search = num_text[i].reverse()
			var position = reversed.find(search)
			if position != -1 and position < last_text_position:
				last_text_position = position
				last_num = i + 1
		for i in range(0, num_nums.size()):
			var search = num_nums[i].reverse()
			var position = reversed.find(search)
			if position != -1 and position < last_text_position:
				last_text_position = position
				last_num = i + 1
			
		line = reversed.reverse()
		
		var combined = 10*first_num + last_num
		label_3d.text += line + " -> " + str(combined) + "\n"
		sum += combined
		print(original + " -> " + line + " = " + str(combined) + " " + str(sum))
	label_3d.text += "\nAnswer: " + str(sum)
	# 54998 is too high
	return sum


func _on_test_body_entered(body):
	if (body.name == "Player"):
		test()


func _on_full_body_entered(body):
	if (body.name == "Player"):
		full()


func _on_test_2_body_entered(body):
	if (body.name == "Player"):
		test1B()


func _on_full_2_body_entered(body):
	if (body.name == "Player"):
		full1B()
