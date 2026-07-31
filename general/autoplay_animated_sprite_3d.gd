extends AnimatedSprite3D


@onready var interactable = $InteractFlowerHeadTalk

@onready var quest_complete_line = $FlowerheadCompleteQuest


func _string_signal(sig):
	if sig == "resume_happy_music":
		%MusicPlayer.play_music("res://sounds/music/dream.mp3",-12.0)
		%Shader.mesh.material.set_shader_parameter("weirder", false)


func _ready():
	play("default")
	Dialogue.string_signal.connect(_string_signal)


func task_completed():
	$InteractFlowerHeadTalk.line = quest_complete_line
