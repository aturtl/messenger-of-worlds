extends Node3D


@onready var model = $Model


@export var spin_time = 1.0
@export var hover_time = 1.6

@export var hover_height = 2.0


var ascend = false


func _string_signal(sig):
	if sig == "catlo_1_perish":
		ascend = true
		%Player.souls_freed += 1


func _ready():
	Dialogue.string_signal.connect(_string_signal)
	
	var tween = get_tree().create_tween()
	tween.tween_property(model, "rotation:y", 2.0*PI, spin_time)
	tween.tween_property(model, "rotation:y", 0.0, 0.0)
	tween.set_loops(-1)
	tween.play()
	
	var tween2 = get_tree().create_tween()
	tween2.tween_property(model, "position:y", hover_height, hover_time/2.0).set_trans(Tween.TRANS_SINE)
	tween2.tween_property(model, "position:y", 0.0, hover_time/2.0).set_trans(Tween.TRANS_SINE)
	tween2.set_loops(-1)
	tween2.play()


func _physics_process(delta):
	if ascend:
		position.y += 16.0 * delta
	
		await get_tree().create_timer(60).timeout
		
		queue_free()
