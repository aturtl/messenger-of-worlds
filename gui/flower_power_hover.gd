extends AnimatedSprite3D


@export var spin_time = 1.0
@export var hover_time = 1.6

@export var hover_height = 2.0


func _ready():
	play("default")
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation:y", 2.0*PI, spin_time)
	tween.tween_property(self, "rotation:y", 0.0, 0.0)
	tween.set_loops(-1)
	tween.play()
	
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "position:y", hover_height, hover_time/2.0).set_trans(Tween.TRANS_SINE)
	tween2.tween_property(self, "position:y", 0.0, hover_time/2.0).set_trans(Tween.TRANS_SINE)
	tween2.set_loops(-1)
	tween2.play()
