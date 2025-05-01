extends Control

var database:SQLite
var player
func _ready() -> void:
	await get_tree().create_timer(.1,false).timeout
	player = $"../MainScreen/PlayerName".text
	
	database = get_parent().database
	var res = database.select_rows("Players","name = " + "'" + player + "'" ,["name","death","time"])
	for r in res:
		find_child("PlayerName").text = r.values()[0]
		find_child("DeathCount").text = str(r.values()[1])
		find_child("TimeCount").text = str(r.values()[2]) + " sec"

func updateStats():
	player = $"../MainScreen/PlayerName".text
	
	var res = database.select_rows("Players","name = " + "'" + player + "'" ,["name","death","time"])
	if res.is_empty():
		var entry = {
			"name" : player,
			"death" : 0,
			"time" :0
		};
		database.insert_row("Players",entry)
		res = database.select_rows("Players","name = " + "'" + player + "'" ,["name","death","time"])
	for r in res:
		find_child("PlayerName").text = r.values()[0]
		find_child("DeathCount").text = str(r.values()[1])
		find_child("TimeCount").text = str(r.values()[2]) + " sec"
