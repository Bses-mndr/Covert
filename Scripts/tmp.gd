extends Button

var database:SQLite
var uid

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()
	uid = "Monster1"

func _on_pressed() -> void:
	var death = database.select_rows("Players","",["death"])
	for i in death:
		i = i.values()
		var res = i[0] + 1
		database.query("UPDATE Players SET death = " + str(res))
