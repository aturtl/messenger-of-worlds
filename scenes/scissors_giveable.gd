extends AnimatedSprite3D


@onready var pos_1 = $Pos1
@onready var pos_2 = $Pos2


var state = "hovering"
var already_given = false


func _string_signal(sig):
	if sig == "show_scissors":
		visible = false
	
	if sig != "visible_give_scissors" or already_given:
		return
	
	already_given = true
	
	scale *= 3.0
	
	global_position = pos_1.global_position
	visible = true
	
	var give_tween = get_tree().create_tween()
	
	give_tween.tween_property(self, "global_position", %Player.model.global_position, 3.0)
	
	visible = true


func _ready():
	play("default")
	Dialogue.string_signal.connect(_string_signal)
