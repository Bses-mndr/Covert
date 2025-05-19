extends Control

var database : SQLite

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()

func _process(delta: float) -> void:
	await get_tree().create_timer(5,false).timeout
	var win = database.select_rows("Players","name = '" + AutoLoad.player_name + "'" ,["win"])
	for i in win:
		i = i.values()
		var res = i[0] + 1
		database.update_rows("Players","name = '" + str(AutoLoad.player_name) + "'", {"win" : str(res)})
	get_tree().change_scene_to_file("res://Scenes/Main_menu.tscn")
