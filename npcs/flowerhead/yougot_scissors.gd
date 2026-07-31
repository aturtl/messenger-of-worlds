extends Node2D


var skippable = false
@onready var enter_to_continue = $EnterToContinue
@onready var background = $Background
@onready var you_got = $YOUGOT

@onready var sfx = $"hi it is me the scissors"


func _string_signal(sig):
	if sig == "show_scissors":
		%Player.player_lock = true
		%Player.dialogue_lock = true
		
		visible = true
		
		var alpha_tween = get_tree().create_tween()
		alpha_tween.tween_property(background,"modulate:a", 1.0, 1.0)
		
		sfx.play()
		
		await get_tree().create_timer(1.0).timeout
		
		%Player.has_scissors = true
		
		var enter_tween = get_tree().create_tween()
		enter_tween.tween_property(enter_to_continue, "scale", Vector2(.45,.45), .1)
		
		enter_tween.play()
		
		skippable = true


func _physics_process(delta):
	if visible:
		you_got.scale += Vector2.ONE*delta*.1
		if Input.is_action_just_pressed("interact") and skippable:
			skippable = false
			visible = false
			you_got.scale = Vector2.ONE
			background.modulate.a = 0
			enter_to_continue.scale = Vector2(0,0)
			%Player.player_lock = false
			await get_tree().create_timer(.5).timeout
			%Player.dialogue_lock = false


func _ready():
	enter_to_continue.scale = Vector2(0,0)
	visible = false
	background.modulate.a = 0
	Dialogue.string_signal.connect(_string_signal)
