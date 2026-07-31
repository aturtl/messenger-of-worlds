extends Node3D


func _forgot(sig):
	if sig == "introforgot":
		await Dialogue.finished_talking
		await get_tree().create_timer(2.0).timeout
		Dialogue.start(%DialogueLines.get_node("StatementSunForgot"))
	elif sig == "play_main_music":
		%MusicPlayer.play_music("res://sounds/music/dream.mp3",-12.0)


func _ready():
	Dialogue.string_signal.connect(_forgot)
