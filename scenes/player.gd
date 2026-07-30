extends CharacterBody3D

@onready var cam: Camera3D = $PlayerCamera
@onready var model: Node3D = $Model

@onready var flowerhead_particle = $FlowerheadParticle

@onready var anim_player: AnimationPlayer = $Model/AnimationPlayer

@export var death_barrier: float = -100.0

@export var current_checkpoint: Checkpoint

var player_lock = true

var cam_y_rot: float = 0.0
var input_direction: Vector2

var move_direction: Vector2
var move_speed: float = 32.0
var drag_amount: float = 64.0

var max_speed = 40.0

var jump_amount = 18.0
var jumping: bool = false
var successful_jump: bool = false

var model_rotate_lerp_amount = 12.0

var gravity = 18.0

# velocities

var move_velocity: Vector3
var grav_velocity: Vector3

var last_anim: String
var current_anim: String


var has_flowerhead: bool = false
var flowerhead_activated: bool = false
var max_flowerhead_activation = 1.0
var current_flowerhead_activation = 0.0


func summon_flowerhead():
	print("summoned")


func play_anim(n):
	current_anim = n
	if current_anim != last_anim:
		last_anim = n
		anim_player.play(n)


func _ready():
	anim_player.set_blend_time("dragonfly/Run", "dragonfly/Idle", .2)
	anim_player.set_blend_time("dragonfly/Idle", "dragonfly/Run", .1)
	anim_player.set_blend_time("dragonfly/Hover", "dragonfly/Idle", .2)
	anim_player.set_blend_time("dragonfly/JumpPrime", "dragonfly/Hover", .4 )
	
	anim_player.set_blend_time("dragonfly/Idle", "dragonfly/Hover", .2)
	anim_player.set_blend_time("dragonfly/Run", "dragonfly/Hover", .2)
	


func manage_animations():
	anim_player.speed_scale = 1.0
	
	if not is_on_floor():
		play_anim("dragonfly/Hover")
	elif input_direction != Vector2.ZERO or move_velocity.length() >= 10.0:
		play_anim("dragonfly/Run")
		anim_player.speed_scale = move_velocity.length()*.1
	else:
		play_anim("dragonfly/Idle")


func respawn_at_last_checkpoint():
	move_velocity = Vector3.ZERO
	grav_velocity = Vector3.ZERO
	position = current_checkpoint.spawnpoint.position
	cam.global_position = global_position - (-global_transform.basis.z) * 8.0 + Vector3.UP * 5.0


func _dialogue_string_signal(sig):
	if sig == "giveflowerhead":
		has_flowerhead = true


func _physics_process(delta):
	Dialogue.string_signal.connect(_dialogue_string_signal)
	
	if position.y <= death_barrier:
		respawn_at_last_checkpoint()
	
	successful_jump = false
	
	if player_lock:
		anim_player.speed_scale = 1.0
		play_anim("dragonfly/Idle")
		return
	
	cam_y_rot = cam.rotation.y
	
	jumping = Input.is_action_pressed("jump")
	
	var right_comp = Input.get_axis("move_left", "move_right")
	var forward_comp = Input.get_axis("move_back", "move_forward")
	
	input_direction = Vector2(forward_comp,right_comp)
	move_direction = input_direction.rotated(-cam_y_rot)
	
	move_velocity.x += move_direction.y * move_speed * delta
	move_velocity.z += -move_direction.x * move_speed * delta
	
	if move_direction == Vector2.ZERO:
		var sign_x = sign(move_velocity.x)
		var sign_z = sign(move_velocity.z)
		move_velocity.x -= sign_x*drag_amount*delta
		move_velocity.z -= sign_z*drag_amount*delta
		
		if sign(move_velocity.x) != sign_x:
			move_velocity.x = 0.0
		if sign(move_velocity.z) != sign_z:
			move_velocity.z = 0.0
	else:
		var rotate_to = -Vector2.ZERO.angle_to_point(move_direction) + PI
		model.rotation.y = lerp_angle(model.rotation.y, rotate_to, model_rotate_lerp_amount * delta)
	
	if move_velocity.length() > max_speed:
		move_velocity = move_velocity.normalized() * max_speed
	
	if has_flowerhead and !is_on_floor() and Input.is_action_just_pressed("jump"):
		flowerhead_activated = true
	
	if is_on_floor():
		flowerhead_particle.mesh.get_material().albedo_color = Color(1,1,1)
		flowerhead_activated = false
		current_flowerhead_activation = 0.0
		if jumping:
			successful_jump = true
			grav_velocity.y = jump_amount
		else:
			grav_velocity.y = 0.0
	elif flowerhead_activated and current_flowerhead_activation < max_flowerhead_activation:
		current_flowerhead_activation += delta
		var red_amount = current_flowerhead_activation/max_flowerhead_activation
		flowerhead_particle.mesh.get_material().albedo_color = Color(1,1-red_amount,1)
		flowerhead_particle.emitting = true
		successful_jump = true
		grav_velocity.y = jump_amount
	else:
		flowerhead_particle.emitting = false
		grav_velocity.y -= gravity * delta
	
		print("okay")
	
	
	manage_animations()
	
	velocity = move_velocity + grav_velocity
	
	move_and_slide()
