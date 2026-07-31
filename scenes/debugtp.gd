extends Node3D


func _ready():
	await get_tree().create_timer(.5)
	%Player.global_position = global_position
