extends RayCast3D
var hit
var count
@export var chase_time = 5.0
func _ready() -> void:
	count = chase_time
	
func _process(delta: float) -> void:
	if is_colliding():
		hit = get_collider()
		if hit.name == "Player" && get_parent().chase == false:
			get_parent().chase = true
			get_parent().available = false
			
		if hit.name != "Player" && get_parent().chase == true:
			var near_by = $"../Area3D".toggle
			count -= delta
			if near_by == false && count < .1:
				print("Reset Path")
				get_parent().available = true
				get_parent().chase = false
				get_parent().pick_path()
				count = chase_time
			elif near_by:
				count = chase_time
				$"../Area3D".toggle = false
