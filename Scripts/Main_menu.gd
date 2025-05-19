extends Control

var database:SQLite
var player
var playerName

func start_game():
	
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")

func quit_game():
	get_tree().quit()
	
func controls():
	$MainScreen.visible = false
	$InputSettings.visible = true
	
func profile():
	$MainScreen.visible = false
	$Profile.visible = true

func _ready() -> void:
	
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()
	
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	$MainScreen/PlayerName.text = AutoLoad.player_name
	
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("Pause"):
		$MainScreen.visible = true
		$InputSettings.visible = false
		$Profile.visible = false
