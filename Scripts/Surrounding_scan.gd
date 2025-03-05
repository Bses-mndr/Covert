extends Area3D
var toggle

func trigger_entered(body):
	if body == get_node("/root/" + get_tree().current_scene.name + "/Player"):
		toggle = true
