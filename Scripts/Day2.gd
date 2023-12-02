extends Node3D

@onready var label_3d = $Label3D2
@onready var star = $Star
@onready var star_2 = $Star2

const max_color = {"red": 12, "green": 13, "blue": 14}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	star.rotate_y(0.05)
	star_2.rotate_y(0.05)


func test():
	var file: FileAccess = FileAccess.open("res://Inputs/Day2Test.txt", FileAccess.READ)
	if !file.file_exists("res://Inputs/Day2Test.txt"):
		label_3d.text = "Test Case Not Found"
		pass
	label_3d.text = "We Testin'\n\n"
	solve(file)


func for_real():
	var file: FileAccess = FileAccess.open("res://Inputs/Day2.txt", FileAccess.READ)
	if !file.file_exists("res://Inputs/Day2.txt"):
		label_3d.text = "Input Not Found"
		pass
	label_3d.text = "Processin'\n\n"
	var sum = solve(file)
	label_3d.text = "\nAnswer: " + str(sum)


func solve(file):
	# Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
	label_3d.font_size = 32
	var sum = 0
	while !file.eof_reached():
		var line = file.get_line()
		if line == "":
			continue
		var split = line.split(": ")
		var game_id = int(split[0].split(" ")[1])
		var handfuls = split[1].split("; ")
		var gg = true
		for handful in handfuls:
			var color_counts = handful.split(", ")
			for color_count in color_counts:
				var s = color_count.split(" ")
				var color = s[1]
				var count = int(s[0])
				if (count > max_color[color]):
					# too many!
					gg = false
					break
			if !gg:
				break
		if gg:
			sum += game_id
			label_3d.text += line + " -> :D \n"
		else:
			label_3d.text += line + " -> t(^.^t) \n"
	label_3d.text += "\nAnswer: " + str(sum)
	return sum


func solve2B(file):
	# Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
	label_3d.font_size = 32
	var sum = 0
	while !file.eof_reached():
		var line = file.get_line()
		if line == "":
			continue
		var split = line.split(": ")
		var game_id = int(split[0].split(" ")[1])
		var handfuls = split[1].split("; ")
		var min_colors = {"red": 0, "green": 0, "blue": 0}
		for handful in handfuls:
			var color_counts = handful.split(", ")
			for color_count in color_counts:
				var s = color_count.split(" ")
				var color = s[1]
				var count = int(s[0])
				if (count > min_colors[color]):
					min_colors[color] = count
		var power = min_colors["red"] * min_colors["green"] * min_colors["blue"]
		sum += power
		label_3d.text += line + " -> t(^.^t) \n"
	label_3d.text += "\nAnswer: " + str(sum)
	return sum


func _on_test_area_3d_body_entered(body):
	if body.name == "Player":
		test()


func _on_real_area_3d_body_entered(body):
	if body.name == "Player":
		for_real()


func _on_real_b_area_3d_body_entered(body):
	if body.name == "Player":
		var file: FileAccess = FileAccess.open("res://Inputs/Day2.txt", FileAccess.READ)
		if !file.file_exists("res://Inputs/Day2.txt"):
			label_3d.text = "Input Not Found"
			pass
		label_3d.text = "Processin'\n\n"
		var sum = solve2B(file)
		label_3d.text = "\nAnswer: " + str(sum)
