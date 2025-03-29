extends RayCast3D
var hit
var count
@export var chase_time = 3.5
func _ready() -> void:
	count = chase_time
	
func _process(delta: float) -> void:
	if is_colliding():
		hit = get_collider()
		if hit.name == "Player" && get_parent().chase == false: # Chase player when detected if not already chasing.
			get_parent().chase = true
			get_parent().available = false
			
		if hit.name != "Player" && get_parent().chase == true: # No longer detecting player but still chasing, start countdown.
			var near_by = $"../Area3D".toggle # Value of Area3D, check if player is in detection range.
			count -= delta
			if near_by == false && count < .1: # No longer detection range and timeout chase.
				print("Reset Path")
				get_parent().available = true
				get_parent().chase = false
				get_parent().pick_path()
				count = chase_time
			elif near_by: # Detected the player then reset timer.
				count = chase_time
				$"../Area3D".toggle = false
