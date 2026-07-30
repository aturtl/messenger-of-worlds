class_name ActionCamera extends Camera3D


@export var cutscene_camera: CutsceneCamera


func interpolate_to_cutscene_camera(cc: CutsceneCamera):
	cutscene_camera = cc
	print("new")


func _physics_process(delta):
	global_rotation.x = lerp_angle(global_rotation.x, cutscene_camera.global_rotation.x, cutscene_camera.weight)
	global_rotation.y = lerp_angle(global_rotation.y, cutscene_camera.global_rotation.y, cutscene_camera.weight)
	global_rotation.z = lerp_angle(global_rotation.z, cutscene_camera.global_rotation.z, cutscene_camera.weight)
	global_position = global_position.lerp(cutscene_camera.global_position, cutscene_camera.weight)
	
	fov = lerp(fov, cutscene_camera.fov, cutscene_camera.weight)
