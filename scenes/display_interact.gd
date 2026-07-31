extends Node2D


var in_range_of = {}

var range_count = 0


func create_new_entry(i):
	if !i in in_range_of:
		in_range_of[i] = false


func add(interactable: Interactable):
	var i = interactable.get_instance_id()
	
	create_new_entry(i)
	
	if !in_range_of[i]:
		range_count += 1
		in_range_of[i] = true


func remove(interactable: Interactable):
	var i = interactable.get_instance_id()
	
	create_new_entry(i)
	
	if in_range_of[i]:
		range_count -= 1
		in_range_of[i] = false


func _physics_process(delta):
	visible = range_count > 0 and !%Player.dialogue_lock and !%Player.player_lock
