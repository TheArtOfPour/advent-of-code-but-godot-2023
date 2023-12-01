extends Node

@export var position = Vector3()
@export var head_rotation = Vector3()
@export var camera_rotation = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_player_variables(player: CharacterBody3D):
	print("set variables")
	print(player)
	print(player.rotation)
	position = player.global_position
	head_rotation = player.get_node("Head").rotation
	camera_rotation = player.get_node("Head/Camera3D").rotation
