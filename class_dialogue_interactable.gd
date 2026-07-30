class_name DialogueInteractable extends Interactable


@export var line: DialogueLine


func interact_message():
	return "Press Enter to Interact"


func _on_interact():
	if !Dialogue.running:
		Dialogue.start(line)


func _ready():
	super._ready()
	interacted.connect(_on_interact)
