extends Node3D


func _ready():
	GlobalVariables.player = %Player
	GlobalVariables.cutscene_cameras = %CutsceneCameras
	GlobalVariables.action_camera = %ActionCamera
	GlobalVariables.player_camera = %PlayerCamera
