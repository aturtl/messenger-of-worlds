class_name DialogueStatement extends DialogueLine

@export var goto: DialogueLine


func _ready():
	super._ready()
	if goto == null:
		goto = get_child(0)
