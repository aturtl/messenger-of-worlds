extends Node

@onready var b = $BadEnding
@onready var b_loss_text= $BadEnding/LossText
@onready var b_loss_text_2= $BadEnding/LossText2

func _ready():
	pass

func bad_ending():
	b_loss_text.modulate.a = 0.0
	
	b.visible = true
	b_loss_text.visible_characters = 9
	
	var tween0 = get_tree().create_tween()
	tween0.tween_property(b_loss_text,"modulate:a", 1.0, 1.0)
	tween0.play()
	
	await get_tree().create_timer(3.0).timeout
	
	while b_loss_text.visible_characters != b_loss_text.get_total_character_count():
		b_loss_text.visible_characters += 1
		await get_tree().create_timer(.2).timeout
	
	await get_tree().create_timer(1.0).timeout
	
	b_loss_text_2.visible = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(b_loss_text_2,"modulate:a", 1.0, 6.0)
	tween.play()
	
