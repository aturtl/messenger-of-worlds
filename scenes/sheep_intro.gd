extends AnimatedSprite2D


@export var instructions: RichTextLabel
@export var black_screen: ColorRect

@export var skip_intro = false


var await_interact = true


func _ready():
	if skip_intro:
		await get_tree().create_timer(.5).timeout
		%MusicPlayer.stop_music()
		%Player.player_lock = false
		get_parent().queue_free()
		return
	play("idle")


func _physics_process(delta):
	if await_interact and Input.is_action_pressed("interact"):
		await_interact = false
		interacted()


func interacted():
	%MusicPlayer.stop_music()
	%SoundEffects.play_sound_effect("Start")
	print("clicked")
	var tween = get_tree().create_tween()
	tween.tween_property(instructions, "position:y", 550.0, .5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.play()
	await animation_looped
	play("start")
	await animation_looped
	play("end")
	await fade_to_black()
	Dialogue.start(%DialogueLines.get_node("StatementSun"))


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
	get_parent().queue_free()
