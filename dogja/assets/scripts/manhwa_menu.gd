extends Node2D
#D:\dogja
#var dir = DirAccess.open("res://media/manhwa/")
var dir = DirAccess.open("C:/Dogja/media/manhwa")
@onready var series_button : PackedScene = preload("res://assets/scenes/series_button.tscn")
@onready var top_bar : PackedScene = preload("res://assets/scenes/top_bar.tscn")
var button_position = Vector2.ZERO

var lol = false

func _ready():
	
	button_position.x = -800.0
	button_position.y = -250.0
	
	var series_folder = dir.get_directories()
	
	var pre_series_temp = series_button.instantiate()
	add_child(pre_series_temp)
	
	for i in series_folder.size():
		var series_temp = series_button.instantiate()
		add_child(series_temp)
		i+=1
	
	var children_names = $".".get_children()
	
	for i in $".".get_child_count():
		var current_child = str(children_names[$".".get_child_count() - (i+1)])
		if current_child[0] == "@":
			if get_node(current_child) != null:
				get_node(current_child).set_button(series_folder,button_position,i)
			button_position.y += 220
			$Camera.limit += 220
			i+=1
		else:
			break
	
	
	get_node("Series_Button").queue_free()
	var top_bar_temp = top_bar.instantiate()
	add_child(top_bar_temp)
