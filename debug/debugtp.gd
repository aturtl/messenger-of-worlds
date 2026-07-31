extends Node3D


@export var enabled = false


func _ready():
	if !enabled:
		return
	await get_tree().create_timer(.5)
	%Player.global_position = global_position
