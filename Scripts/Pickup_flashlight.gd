extends StaticBody3D

var flashlight
var info_text

func _ready() -> void:
	flashlight = get_node("/root/" + get_tree().current_scene.name + "/Player/Head/Flashlight")
	info_text = get_node("/root/" + get_tree().current_scene.name + "/UI/Info")

func interact():
	flashlight.picked_up = true
	info_text.text = "You found a FLASHLIGHT!"
	get_node("/root/"+get_tree().current_scene.name+"/Player/pickup_audio").play()
	queue_free()
