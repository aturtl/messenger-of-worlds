extends Node3D


@onready var area3d = $Area3D
@onready var parent: AnimatedSprite3D = get_parent()


var dead = false


func _area_entered(area):
	if area.name == "ScissorKill" and %Player.using_scissors == true and !dead:
		dead = true
		print("dead")
		%Player.dead_flowers += 1
		
		if %Player.dead_flowers >= 3:
			%FlowerHead.task_completed()
			
		%FlowerCount.update_count(%Player.dead_flowers)
		
		var kill_tween = get_tree().create_tween()
		
		kill_tween.tween_property(parent, "pixel_size", 0.0, 1.0)
		kill_tween.tween_callback(parent.queue_free)
		
		kill_tween.play()
		%SoundEffects.play_sound_effect("Explosion")


func _ready():
	area3d.area_entered.connect(_area_entered)
