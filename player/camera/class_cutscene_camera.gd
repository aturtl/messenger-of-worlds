class_name CutsceneCamera extends Camera3D


@export var weight = 1.0


func interpolate_to():
	%ActionCamera.interpolate_to_cutscene_camera(self)
