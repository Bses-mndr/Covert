extends RayCast3D

var interact_label
var hit

func _process(delta: float) -> void:
	if is_colliding():
		hit = get_collider()
		if hit != null:
			if hit.has_method("enemy_interact"): # Checks if the collider has method.
				if !hit.opened:
					hit.enemy_interact()
	await get_tree().create_timer(1,false).timeout
