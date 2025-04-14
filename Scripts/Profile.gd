extends Control

var database:SQLite

func _ready() -> void:
	await get_tree().create_timer(.1,false).timeout
	
	database = get_parent().database
	var res = database.select_rows("Players","",["name","death","time"])
	for r in res:
		find_child("PlayerName").text = r.values()[0]
		find_child("DeathCount").text = str(r.values()[1])
		find_child("TimeCount").text = str(r.values()[2]) + " sec"
