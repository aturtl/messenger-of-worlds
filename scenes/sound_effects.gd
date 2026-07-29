extends Node3D


@onready var template = $Template


func play_sound_effect(n):
	var sfx = get_node(n)
	if sfx:
		sfx.play()
