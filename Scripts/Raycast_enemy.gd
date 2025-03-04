extends RayCast3D

var interact_label
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_colliding():
		var hit = get_collider()
		if hit != null:
			if hit.has_method("interact") && hit.opened == false:
				hit.interact()
				await get_tree().create_timer(1,false).timeout
				hit.opened = true
