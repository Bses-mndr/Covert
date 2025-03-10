extends Area3D
var toggle

func trigger_entered(body):
	if body == get_node("/root/" + get_tree().current_scene.name + "/Player"): # Sends signal to Radar when detecting player.
		toggle = true
