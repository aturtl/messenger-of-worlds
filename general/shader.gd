@tool
extends MeshInstance3D


func _ready():
	visible = !Engine.is_editor_hint()
