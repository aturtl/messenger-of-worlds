extends CharacterBody3D

@onready var cam: Camera3D = $Camera3D
@onready var model: Node3D = $Model

var cam_y_rot: float = 0.0
var input_direction: Vector2

var move_direction: Vector2
var move_speed: float = 32.0
var drag_amount: float = 64.0

var jump_amount = 12.0
var jumping: bool = false

var model_rotate_lerp_amount = 12.0

var gravity = 18.0

# velocities

var move_velocity: Vector3
var grav_velocity: Vector3

func _physics_process(delta):
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
	
	if is_on_floor():
		if jumping:
			grav_velocity.y = jump_amount
		else:
			grav_velocity.y = 0.0
	else:
		grav_velocity.y -= gravity * delta
	
	velocity = move_velocity + grav_velocity
	
	move_and_slide()
