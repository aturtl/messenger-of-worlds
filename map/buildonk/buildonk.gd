extends Node3D


@onready var anim_player = $AnimationPlayer
@onready var line = $DialogueLine
@onready var line2 = $DialogueLine2
@onready var line3 = $DialogueLine3
@onready var line4 = $DialogueLine4
@onready var line4_5 = $DialogueLine4_5
@onready var line5 = $DialogueLine5
@onready var line6 = $DialogueLine6
@onready var line7 = $DialogueLine7
@onready var line8 = $DialogueLine8
@onready var line9 = $DialogueLine9
@onready var line10 = $DialogueLine10
@onready var line11 = $DialogueLine11


@export var why_camera: CutsceneCamera


@export var teleport_to: Node3D


var override_p_cam = false


func _ready():
	anim_player.play("Cube|the house")


func _physics_process(delta):
	print(self.global_position.distance_to(%Player.global_position))
	if override_p_cam:
		%Player.cam.rotation = why_camera.rotation


func _on_area_3d_body_entered(body):
	if body == %Player:
		Dialogue.lock_player = false
		%Player.frozen = true
		%MusicPlayer.stop_music()
		%ActionCamera.disable_on_dialogue_end = false
		%ActionCamera.current = true
		%ActionCamera.interpolate_to_camera(%Player.cam,1.0)
		await get_tree().create_timer(3.0).timeout
		override_p_cam = true
		%ActionCamera.interpolate_to_cutscene_camera(why_camera)
		Dialogue.start(line)
		await Dialogue.ended
		%Player.global_position = teleport_to.global_position
		await get_tree().create_timer(2.0).timeout
		Dialogue.start(line2)
		await Dialogue.ended
		%Player.frozen = false
		await get_tree().create_timer(3.0).timeout
		Dialogue.start(line3)
		await get_tree().create_timer(4.0).timeout
		Dialogue.start(line4)
		await get_tree().create_timer(3.0).timeout
		Dialogue.start(line4_5)
		await get_tree().create_timer(4.0).timeout
		Dialogue.start(line5)
		await get_tree().create_timer(3.0).timeout
		Dialogue.start(line6)
		await get_tree().create_timer(4.0).timeout
		Dialogue.start(line7)
		await get_tree().create_timer(4.0).timeout
		Dialogue.start(line8)
		await get_tree().create_timer(4.0).timeout
		Dialogue.start(line9)
		await get_tree().create_timer(5.0).timeout
		Dialogue.start(line10)
		await get_tree().create_timer(5.0).timeout
		Dialogue.start(line11)
		var tween = get_tree().create_tween()
		%BlackScreen.visible = true
		tween.tween_property(%BlackScreen, "color:a", 1.0, 1.0)
		tween.play()
		%Endings.bad_ending()
