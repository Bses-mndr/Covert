extends Button

var database:SQLite

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()

func _on_pressed() -> void:
	var coor:Array[Array]
	var i = 0 
	var destinations = database.select_rows("Destinations","",["x","y","z"])
	for d in destinations:
		coor.append(d.values())
	print(coor)
