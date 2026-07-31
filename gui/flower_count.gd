extends Label3D


@onready var you_may_now_return = $"YOU MAY NOW RETURN"


func update_count(new):
	if new == 3:
		you_may_now_return.visible = true
		%MusicPlayer.play_music("res://sounds/music/dream_slowest.mp3", -12.0)
		var mat: ShaderMaterial = %Shader.mesh.material
		mat.set_shader_parameter("weirder", true)
		%Sun.queue_free()
	
	var jump_tween = get_tree().create_tween()
	
	text = "you have "+str(new-1)+" + 1!" 
	
	%Player.shake_screen(.5, 8,.08)
	
	jump_tween.tween_property(self, "scale", Vector3.ONE * 1.8, 1.0)
	jump_tween.tween_property(self, "scale", Vector3.ONE, .2)
	
	jump_tween.play()
	
	await jump_tween.finished
	
	text = "you have "+str(new)+"."


func _ready():
	pass
