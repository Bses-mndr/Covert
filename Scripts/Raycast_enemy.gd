extends RayCast3D

var interact_label
var hit
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_colliding():
		hit = get_collider()
		if hit != null:
			if hit.has_method("enemy_interact"):
				hit.enemy_interact()
