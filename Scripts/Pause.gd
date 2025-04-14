extends Control

func _ready() -> void:
	visible = false

func resume_game():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func quit_game():
	get_tree().quit()

func main_menu():
	get_tree().change_scene_to_file("res://Scenes/Main_menu.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		visible = !visible
		get_tree().paused = visible
		if get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
