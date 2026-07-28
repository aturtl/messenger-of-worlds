class_name DialogueLine extends Node

@export var text = ""
@export var box: DialogueBox

@export var talk_sound: AudioStream

func _ready():
	if box == null:
		print("none")
		box = %DialogueBoxes.get_node("Regular")
