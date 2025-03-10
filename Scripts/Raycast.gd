extends RayCast3D

var interact_label

func _ready() -> void:
	interact_label = get_node("/root/"+ get_tree().current_scene.name + "/UI/Interact")
	interact_label.visible = false

func _process(delta: float) -> void:
	if is_colliding():
		var hit = get_collider()
		if hit != null:
			if hit.has_method("interact"): # Checks if the collider has method.
				interact_label.visible = true
				if Input.is_action_just_pressed("Interact"):
					hit.interact()
			else:
				interact_label.visible = false
	else:
			interact_label.visible = false
