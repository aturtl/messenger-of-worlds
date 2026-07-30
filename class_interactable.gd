class_name Interactable extends Node3D


@onready var player = %Player
@export var interact_range = 100.0
@onready var label: Label3D = $InteractLabel


signal entered_range
signal exited_range
signal interacted

var in_range = false

var disabled = false


func interact_message():
	return "Press Enter to Interact"


func _dialogue_started():
	print("tracked")
	disabled = true


func _dialogue_ended():
	await get_tree().create_timer(.1).timeout
	disabled = false


func _entered_range():
	pass


func _exited_range():
	pass


func _ready():
	Dialogue.started.connect(_dialogue_started)
	Dialogue.ended.connect(_dialogue_ended)
	entered_range.connect(_entered_range)
	exited_range.connect(_exited_range)


func _physics_process(delta):
	if global_position.distance_to(player.global_position) <= interact_range:
		if label and !player.player_lock:
			label.visible = true
		if !in_range:
			entered_range.emit()
		in_range = true
	else:
		if label:
			label.visible = false
		if in_range:
			exited_range.emit()
		in_range = false
	
	if !disabled and in_range and Input.is_action_just_pressed("interact"):
		if !player.player_lock:
			interacted.emit()
			
