class_name DialogueLine extends Node

@export var text = ""
@export var box: DialogueBox

@export var talk_sound: AudioStream

@export var cutscene_camera: CutsceneCamera

@export var string_signal = ""
@export var end_signal = ""

func _ready():
	if box == null:
		print("none")
		box = %DialogueBoxes.get_node("Regular")
