extends CharacterBody3D

@export var walk = 2
var run  = walk * 2
var speed = walk
var jumpscare_time = .85

var is_spawn = true
var caught = false
var distance: float
var is_thinking = false
var has_found = false

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var database:SQLite
var m_id:String
var destination:Array[Array]

var player
var UI
var found_text
var interact_text

var look_dir
var chase
var available

var current_location
var next_location
var new_velocity

var rng
var rand_dest
var current_dest
var temp_dest

@export var next_scene : String

func _ready():
	
	
	m_id = name.trim_prefix("Monster")
	database = get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").database
	var res = database.select_rows("Destinations", "m_id = '" + m_id + "'", ["x","y","z"])
	for r in res:
		destination.append(r.values())
	
	player = get_node("/root/"+ get_tree().current_scene.name+"/Player")
	UI = get_node("/root/"+get_tree().current_scene.name+"/UI")
	found_text = get_node("/root/"+get_tree().current_scene.name+"/UI/Found_you")
	
	chase = false
	available = true
	rng  = RandomNumberGenerator.new()
	rand_dest = rng.randi_range(0,(destination.size()-1))
	temp_dest = rand_dest
	current_dest = destination[rand_dest]
	current_dest = Vector3(current_dest[0],current_dest[1],current_dest[2])
	print(current_dest)

func pick_path(): #Pick random destination if not chasing.
	if chase == false && available:
		is_thinking = true
		available = false
		rotation.y = look_dir
		temp_dest = rand_dest
		await get_tree().create_timer(2,false).timeout
		rand_dest = rng.randi_range(0,destination.size()-1)
		
		if destination.size() == 2:
			if temp_dest:
				temp_dest = 0
			else:
				temp_dest = 1
			print("New Path Picked! of P2's")
			current_dest = destination[rand_dest]
			current_dest = Vector3(current_dest[0],current_dest[1],current_dest[2])
			available = true
			is_thinking = false
			
		else:
			if temp_dest != rand_dest:
				current_dest = destination[rand_dest]
				current_dest = Vector3(current_dest[0],current_dest[1],current_dest[2])
				print("New Path Picked! of P3's")
				print(temp_dest," : ",rand_dest)
				available = true
				is_thinking = false
			else:
				available = true
				pick_path()

func decision(): #Chasing or Wandering?
	if chase == false:
		has_found = true
		speed = walk
		distance = current_dest.distance_to(global_transform.origin)
		update_target_location(current_dest)
	elif chase:
		speed = run
		distance = player.global_transform.origin.distance_to(global_transform.origin)
		update_target_location(player.global_position)
		if has_found:
			var flicker:int = rng.randi_range(1,4)
			var i:int = 0
			while i < flicker:
				found_text.visible = true
				await get_tree().create_timer(.25,false).timeout
				found_text.visible = false
				i += 1
			has_found = false

func is_stuck(): #Err handling for when AI gets stuck on locked doors or random terrain.
	if caught == false && is_thinking == false:
		var temp_pos = global_position
		await get_tree().create_timer(5,false).timeout
		if(temp_pos == global_position):
			print("Stuck!")
			pick_path()


func _process(delta: float) -> void:
	if visible && !is_on_floor(): #Path determination
		velocity.y -= gravity * delta
	
	decision()
	is_stuck()
	
	current_location = global_transform.origin
	next_location = $NavigationAgent3D.get_next_path_position()
	new_velocity = (next_location - current_location).normalized() * speed
	$NavigationAgent3D.set_velocity(new_velocity)
	
	look_dir = atan2(-velocity.x,-velocity.z)
	rotation.y = look_dir
	
	if chase:
		if distance <= 2 && caught == false: #Monster catching player.
			get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").stopped = true
			var death = database.select_rows("Players","",["death"])
			for i in death:
				i = i.values()
				var res = i[0] + 1
				database.query("UPDATE Players SET death = " + str(res))
			caught = true
			player.movable = false
			player.visible = false
			UI.visible = false
			$Camera3D.set_current(true)
			
			await get_tree().create_timer(jumpscare_time,false).timeout
			get_tree().change_scene_to_file("res://Scenes/" + next_scene + ".tscn")

func update_target_location(target_location):
	$NavigationAgent3D.target_position = target_location

func velocity_computed(safe_velocity):
	if is_spawn && caught == false:
		velocity = velocity.move_toward(safe_velocity, 0.25)
		move_and_slide()
