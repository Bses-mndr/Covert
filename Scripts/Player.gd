extends CharacterBody3D

var player_name

var crosshair
var movable = true

var walk_speed
var speed = 3.0
var run_speed = 5.0

var stamina = 100
var stamina_slider
var stamina_drain = 25
var stamina_tmp = 0
var fatigue_warn
var is_walk = true
var moving : bool = false

const JUMP_VELOCITY = 2.8

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	walk_speed = speed
	crosshair = get_node("/root/"+get_tree().current_scene.name+"/UI/Crosshair")
	crosshair.visible = true
	stamina_slider = get_node("/root/"+get_tree().current_scene.name+"/UI/Stamina")
	fatigue_warn = get_node("/root/"+get_tree().current_scene.name+"/UI/Fatigued")
	fatigue_warn.visible = false
	self.set_collision_mask_value(2,true)

func _process(delta: float) -> void:
	
	is_moving()
	
	if is_walk && speed != run_speed && moving:
		$Walking.play()
		is_walk = false
	elif moving != true:
		$Walking.stop()
		is_walk = true
	
	if Input.is_action_just_pressed("Sprint"):
		$Walking.stop()
		$Running.play()
		is_walk = true
	elif speed == walk_speed:
		$Running.stop()
	
	if speed == run_speed && stamina >= stamina_slider.min_value: # Decrease stamina when running.
		stamina_slider.visible = true
		stamina_tmp = stamina_slider.min_value
		stamina -= stamina_drain * delta
		stamina_slider.value = stamina
	else:
		if stamina < 5: # Fatigue warning and cannot run.
			fatigue_warn.visible = true
			stamina = stamina_slider.min_value
			stamina_tmp += stamina_drain * .4 * delta
			stamina_slider.value = stamina_tmp
			if (stamina_tmp > (stamina_slider.max_value/2)):
				stamina = stamina_tmp
				fatigue_warn.visible = false
		else:
			if stamina <= stamina_slider.max_value: # Revitalizing stamina when not running.
				stamina += stamina_drain * delta
				stamina_slider.value = stamina
	if stamina_slider.value == stamina_slider.max_value:
		stamina_slider.visible = false


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	if movable:
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			
			if Input.is_action_pressed("Sprint") && stamina > stamina_slider.min_value: # Run if there is stamina.
				speed = run_speed
				
			else:
				speed = walk_speed
			
		else:
			speed = walk_speed
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)

		move_and_slide()


func is_moving() -> void:
	var oldpos = global_position
	await get_tree().create_timer(.2).timeout
	var newpos = global_position
	if oldpos != newpos:
		moving = true
	else :
		moving = false
