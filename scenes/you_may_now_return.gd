extends Label3D


func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation:y", 2.0*PI, 1.25)
	tween.tween_property(self, "rotation:y", 0.0, 0.0)
	tween.set_loops(-1)
	tween.play()
