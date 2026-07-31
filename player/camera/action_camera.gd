class_name ActionCamera extends Camera3D


@export var camera: Camera3D
var disable_on_dialogue_end = true
var enable_on_dialogue_start = true


var weight = 0.0


func interpolate_to_cutscene_camera(cc: CutsceneCamera):
	camera = cc
	weight = camera.weight
	print("new")
	snap()


func interpolate_to_camera(c: Camera3D, c_weight):
	print("NEW INTERPOLATE")
	camera = c
	weight = c_weight
	snap()


func snap():
	if weight == 1.0:
		print("NEW INTERPOLATE 2")
		
		global_rotation = camera.global_rotation
		global_position = camera.global_position
		fov = camera.fov


func _physics_process(delta):
	if !camera:
		return
	if weight != 1.0:
		global_rotation.x = lerp_angle(global_rotation.x, camera.global_rotation.x, weight)
		global_rotation.y = lerp_angle(global_rotation.y, camera.global_rotation.y, weight)
		global_rotation.z = lerp_angle(global_rotation.z, camera.global_rotation.z, weight)
		global_position = global_position.lerp(camera.global_position, weight)
		
		fov = lerp(fov, camera.fov, weight)
	else:
		pass
		#snap()
