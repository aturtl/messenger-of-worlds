extends AnimatedSprite2D


@export var button: TextureButton
@export var black_screen: ColorRect


func _ready():
	play("idle")
	print(button.is_node_ready())
	button.button_down.connect(_button_press)


func _button_press():
	%MusicPlayer.stop_music()
	print("clicked")
	button.button_down.disconnect(_button_press)
	var tween = get_tree().create_tween()
	tween.tween_property(button, "position:y", 500.0, .5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.play()
	await animation_looped
	play("start")
	await animation_looped
	play("end")
	await fade_to_black()
	Dialogue.start(%DialogueLines.get_node("StatementSun"))
	await Dialogue.ended


func fade_to_black():
	black_screen.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(black_screen, "color:a", 1.0, 1.0)
	tween.play()
	var anim_tween = get_tree().create_tween()
	anim_tween.tween_property(self, "scale", Vector2(1.5,1.5), 1.0)
	anim_tween.play()
	tween.tween_property(black_screen, "color:a", 0.0, 1.0)
	await anim_tween.finished
	self.queue_free()
