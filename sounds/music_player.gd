extends Node3D


@onready var music = $Music


var volume = 0.0
var duck = false
var duck_amount = -6.0


func play_music(path, vol):
	music.volume_db = vol
	music.stream = load(path)
	music.play()


func stop_music():
	music.stop()


func _ready():
	play_music("res://sounds/music/sheepy.mp3",-12.0)
