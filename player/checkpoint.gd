class_name Checkpoint extends Area3D

@export var touchable: bool = true
@onready var spawnpoint: Node3D = $Spawnpoint


func _body_entered(body):
	if body.get_parent() == %Player:
		%Player.current_checkpoint = self


func _ready():
	if touchable:
		body_entered.connect(_body_entered)
