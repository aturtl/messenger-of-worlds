class_name DialogueInteractable extends Interactable


@export var line: DialogueLine


func _on_interact():
	if !Dialogue.running:
		Dialogue.start(line)


func _ready():
	super._ready()
	interacted.connect(_on_interact)
