extends Node3D


@onready var anim_player = $AnimationPlayer


func _ready():
	anim_player.play("Cube|the house")
	


func _physics_process(delta):
	print(self.global_position.distance_to(%Player.global_position))


func _on_area_3d_body_entered(body):
	if body == %Player:
		%Player.player_lock = true
