extends SpotLight3D

var info_text
var flashlight_slider

var picked_up = false
var flash_batt = false

var flash_life
var flash_life_r : int
const drain_rate = 1

func _ready() -> void:
	flash_batt = false
	visible = false
	flash_life_r = 0 #Rounding off flash_life value.
	
	info_text = get_node("/root/"+get_tree().current_scene.name+"/UI/Info")
	flashlight_slider = get_node("/root/"+get_tree().current_scene.name+"/UI/Flashlight")
	flash_life = flashlight_slider.value

func _process(delta):
	
	if flash_batt:
		flash_life_r = int(flash_life)
		if flash_life_r % 5 == 0: #Discrete increment of UI slider.
			flashlight_slider.value = flash_life_r
		
		if visible:
			flash_life -= drain_rate * delta
		
		#print(flash_life_r)
		
		if flash_life_r == flashlight_slider.min_value: #Turning off flashlight when battery runs out.
			flash_life_r = flashlight_slider.min_value
			flashlight_slider.value = flash_life_r 
			visible = false
			flash_batt = false
			info_text.text = "Your Battery is FRIED!"
	
	if Input.is_action_just_pressed("Flashlight") && picked_up == true && flash_batt:
		visible = !visible
		$toggle.play()
	elif Input.is_action_just_pressed("Flashlight") && picked_up == false:
		info_text.text = "You don't have a Flashlight!"
	elif Input.is_action_just_pressed("Flashlight") && flash_batt == false:
		info_text.text = "Your Battery is FRIED!"
		
