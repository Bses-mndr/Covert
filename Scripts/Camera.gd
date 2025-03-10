extends Node3D

var player
var sens = 0.001
var movable = true

func _ready():
	player = get_node("/root/" + get_tree().current_scene.name + "/Player")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) #Mouse is incorporated in game.
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && movable: #Camera rotation.
		get_parent().rotate_y(-event.relative.x * sens)
		rotate_x(-event.relative.y * sens)
		rotation.x = clamp(rotation.x,deg_to_rad(-90),deg_to_rad(90))

func _process(delta: float) -> void:
	if(Input.is_action_pressed("Sprint")): #Changing FOV when sprinting.
		if $Camera3D.fov <= 85:
			$Camera3D.fov += delta*12
			print($Camera3D.fov)
	else:
		if $Camera3D.fov >= 75:
			$Camera3D.fov -= delta*12
			print($Camera3D.fov)
