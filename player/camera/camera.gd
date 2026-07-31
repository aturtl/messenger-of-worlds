extends Camera3D


@onready var player = get_parent()
var max_dist = 10.0
var min_dist = 2.0

var max_lerp_factor = 6.0

func _physics_process(delta):
	
	var dist = position.distance_to(player.position)
	var dir_to: Vector3 = position.direction_to(player.position)
	
	var dir_to_no_y = (dir_to * Vector3(1.0, 0.0, 1.0)).normalized()
	
	rotation.y = -atan2(dir_to_no_y.z,dir_to_no_y.x) - PI/2.0
	
	look_at(player.position)
	
	if position.y < player.position.y + 2.0:
		var diff = player.position.y + 2.0 - position.y
		position.y = lerp(position.y, position.y+diff, max_lerp_factor * delta)
	
	var correction = dist - max_dist
	
	if dist > max_dist:
		position = position.lerp(position+correction*dir_to, max_lerp_factor * delta)
