extends Node3D

var player_scene = preload("res://player.tscn")

func _ready():
	spawn_player()
	
	
func spawn_player():
	var player = player_scene.instantiate()
	add_child(player)
	player.position = Vector3(0, 0.335, -0.007)
