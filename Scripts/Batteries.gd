extends StaticBody3D

var refill = 25
var flashlight

func _ready() -> void:
	flashlight = get_node("/root/"+get_tree().current_scene.name+"/Player/Head/Flashlight")

func interact():
	if flashlight.flash_life < 100:
		flashlight.flash_batt = true
		flashlight.flash_life += refill
		if flashlight.flash_life > 100:
			flashlight.flash_life = flashlight.flashlight_slider.max_value
	queue_free()
