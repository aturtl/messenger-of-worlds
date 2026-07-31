extends MeshInstance3D


var talking = false
var fps = 6.0


@export var frames = []
var current_frame = 0


var time_since_last_frame = 0.0


func switch_frame():
	time_since_last_frame = 0.0
	current_frame += 1
	current_frame %= frames.size()
	print(current_frame)
	mesh.surface_get_material(0).albedo_texture = frames[current_frame]
	print("swtched")


func stop_talking():
	talking = false
	current_frame = 0
	mesh.surface_get_material(0).albedo_texture = frames[0]


func start_talking():
	talking = true


func _physics_process(delta):
	if talking:
		time_since_last_frame += delta
		if time_since_last_frame >= 1.0/fps:
			switch_frame()
