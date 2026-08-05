extends Node3D


func _ready():
	for child in get_children():
		if child is AnimatedSprite3D:
			child.play()
