class_name Interactable extends Node3D


@onready var player = %Player
@export var interact_range = 100.0


signal entered_range
signal exited_range
signal interacted


var in_range = false


var disabled = false


func _dialogue_started():
	print("tracked")
	disabled = true


func _dialogue_ended():
	await get_tree().create_timer(.1).timeout
	disabled = false


func _ready():
	Dialogue.started.connect(_dialogue_started)
	Dialogue.ended.connect(_dialogue_ended)


func _physics_process(delta):
	if position.distance_to(player.position) <= interact_range:
		if !in_range:
			entered_range.emit()
		in_range = true
	else:
		if in_range:
			exited_range.emit()
		in_range = false
	
	if !disabled and in_range and Input.is_action_just_pressed("interact"):
		interacted.emit()
