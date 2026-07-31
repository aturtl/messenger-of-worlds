extends Node3D


@onready var mouth = $Mouth


func _make_talk(sig):
	if sig == "suntalk":
		print("MAKE")
		mouth.talking = true


func _end_talk():
	print("END")
	mouth.talking = false


func _ready():
	Dialogue.string_signal.connect(_make_talk)
	Dialogue.finished_talking.connect(_end_talk)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position:y", 5.0, 1.0).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "position:y", -2.0, 1.0).set_trans(Tween.TRANS_SPRING)
	tween.set_loops(-1)
