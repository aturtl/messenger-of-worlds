class_name ActionCamera extends Camera3D


@export var cutscene_camera: CutsceneCamera


func interpolate_to_cutscene_camera(cc: CutsceneCamera):
	cutscene_camera = cc
	print("new")


func _physics_process(delta):
	rotation.x = lerp_angle(rotation.x, cutscene_camera.rotation.x, cutscene_camera.weight)
	rotation.y = lerp_angle(rotation.y, cutscene_camera.rotation.y, cutscene_camera.weight)
	rotation.z = lerp_angle(rotation.z, cutscene_camera.rotation.z, cutscene_camera.weight)
	position = position.lerp(cutscene_camera.position, cutscene_camera.weight)
