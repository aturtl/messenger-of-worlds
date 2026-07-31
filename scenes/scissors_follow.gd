extends AnimatedSprite3D


@onready var player = get_parent()
@onready var player_model = player.get_node("Model")
@onready var hover_pos = $HoverPos
@onready var attack_pos = $AttackPos


var state = "hovering"


func _ready():
	play("default")


func _physics_process(delta):
	if state == "hovering":
		global_position = global_position.lerp(hover_pos.global_position,.5)
		billboard = BaseMaterial3D.BILLBOARD_ENABLED
		scale = scale.lerp(Vector3.ONE * 1.0,.1)
		alpha_cut = SpriteBase3D.ALPHA_CUT_DISABLED
		
	elif state == "attacking":
		global_position = global_position.lerp(attack_pos.global_position,1.0)
		billboard = BaseMaterial3D.BILLBOARD_DISABLED
		rotation = player_model.rotation + Vector3(PI/1.2,PI/2.0,0)
		scale = scale.lerp(Vector3.ONE * 4.0,.5)
		alpha_cut = SpriteBase3D.ALPHA_CUT_DISCARD
	
	# Attack Pos
	attack_pos.global_position = player.global_position + player_model.global_transform.basis.z * 4.0 + player_model.global_transform.basis.x*-.5 - Vector3.UP * 2.0
	
	# Hover Pos
	hover_pos.global_position.y = lerp(hover_pos.global_position.y, player.global_position.y - 3.0 + sin(Time.get_ticks_msec()/128.0), .1)
	
	var dir = (hover_pos.global_position.direction_to(player.global_position) * Vector3(1,0,1)).normalized()
	
	if hover_pos.global_position.distance_to(player.global_position) > 4.0:
	
		hover_pos.global_position = hover_pos.global_position.lerp(player.global_position - dir * 4.0, .1)
