extends StaticBody3D

var info_text

func _ready() -> void:
	info_text = get_node("/root/" + get_tree().current_scene.name + "/UI/Info")

func interact():
	get_node("/root/"+get_tree().current_scene.name+"/Player/pickup_audio").play()
	info_text.text = "You found a KEY!" 
	
	queue_free()
