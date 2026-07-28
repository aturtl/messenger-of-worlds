extends Node


signal statement_continue
signal choice_made
signal started
signal ended
signal string_signal
signal finished_talking

var choice: int

var running = false # (full)
var talking = false


@onready var sound: AudioStreamPlayer


func _ready():
	sound = AudioStreamPlayer.new()
	add_child(sound)
	sound.stream = load("res://sounds/talk/bite_of_87_2.mp3")


func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		if talking:
			talking = false
		elif running:
			statement_continue.emit()


func play_line(dialogue: DialogueLine):
	if !dialogue:
		finish()
		return
	
	dialogue.box.visible = true
	
	var cc = dialogue.cutscene_camera
	if cc:
		GlobalVariables.action_camera.current = true
		cc.interpolate_to()
	
	if dialogue.string_signal != "":
		string_signal.emit(dialogue.string_signal)
	
	talking = true
	await talk(dialogue)
	talking = false
	finished_talking.emit()
	
	await statement_continue
	
	dialogue.box.visible = false
	
	if dialogue is DialogueStatement:
		play_line(dialogue.goto)
	
	elif dialogue is DialogueQuestion:
		prompt_choices(dialogue)
	


func start(dialogue: DialogueLine):
	GlobalVariables.player.player_lock = true
	started.emit()
	running = true
	play_line(dialogue)


func finish():
	GlobalVariables.player_camera.current = true
	GlobalVariables.player.player_lock = false
	running = false
	ended.emit()
	print("done")


func talk(dialogue: DialogueLine):
	print("talk time")
	
	sound.stream = dialogue.talk_sound
	
	var box = dialogue.box
	
	if !box:
		print("box not found")
		return
	
	var label = box.label
	label.visible_characters = 0
	label.text = dialogue.text
	
	var len = dialogue.box.label.get_total_character_count()
	
	for _n in len:
		await get_tree().create_timer(.05).timeout
		label.visible_characters += 1
		if !label.text[label.visible_characters-1] == " ":
			sound.pitch_scale = randf_range(.9,1.1)
			sound.play()
		if !talking:
			break
	
	label.visible_characters = -1


func play_talk_sound():
	pass


func prompt_choices(question: DialogueQuestion):
	await choice_made
	match choice:
		1: play_line(question.choice_1_goto)
		2: play_line(question.choice_2_goto)
		3: play_line(question.choice_3_goto)
