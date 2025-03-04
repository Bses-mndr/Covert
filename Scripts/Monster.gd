extends CharacterBody3D


var speed = 3.5
var jumpscare_time = .85

var is_spawn = false
var caught = false
var distance: float

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var pov_camera
var player
var UI

var current_location
var next_location
var new_velocity

@export var next_scene : String

func _ready():
	player = get_node("/root/"+ get_tree().current_scene.name+"/Player")
	pov_camera = get_node("/root/"+ get_tree().current_scene.name+"/Player/Head/Camera3D")
	UI = get_node("/root/"+get_tree().current_scene.name+"/UI")
	

func _process(delta: float) -> void:
	if visible && !is_on_floor():
		velocity.y -= gravity * delta
		
	current_location = global_transform.origin
	next_location = $NavigationAgent3D.get_next_path_position()
	new_velocity = (next_location - current_location).normalized() * speed
	$NavigationAgent3D.set_velocity(new_velocity)
	
	look_at(Vector3(player.global_position.x, global_position.y , player.global_position.z))
	distance = player.global_transform.origin.distance_to(global_transform.origin)
	
	if distance <= 2 && caught == false:
		UI.visible = false
		$Camera3D.current = true
		player.movable = false
		player.visible = false
		speed = 0
		caught = true
		
		await get_tree().create_timer(jumpscare_time,false).timeout
		get_tree().change_scene_to_file("res://Scenes/" + next_scene + ".tscn")

func update_target_location(target_location):
	$NavigationAgent3D.target_position = target_location

func velocity_computed(safe_velocity):
	if is_spawn:
		velocity = velocity.move_toward(safe_velocity, 0.25)
		move_and_slide()

func spawn():
	visible = true
	is_spawn = true
