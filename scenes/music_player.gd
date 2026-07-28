extends Node3D


@onready var music = $Music


func play_music(path, vol):
	music.volume_db = vol
	music.stream = load(path)
	music.play()


func stop_music():
	music.stop()


func _ready():
	play_music("res://sounds/music/sheepy.mp3",-12.0)
