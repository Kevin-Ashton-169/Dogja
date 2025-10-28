extends Node2D
#D:\dogja
#var dir = DirAccess.open("res://media/manhwa/")
var dir = DirAccess.open("C:/Dogja/media/" + Global.media)
@onready var series_button : PackedScene = preload("res://assets/scenes/series_button.tscn")
@onready var top_bar : PackedScene = preload("res://assets/scenes/top_bar.tscn")
var button_position = Vector2.ZERO
var series_folders

func _ready():
	
	button_position.x = -800.0
	button_position.y = -250.0
	
	series_folders = dir.get_directories()
	
	place_series(series_folders)
	
	var top_bar_temp = top_bar.instantiate()
	add_child(top_bar_temp)
	$Top_Bar.set_bar(Global.media)
	$Top_Bar/Search_Bar.text_changed.connect(search_text_changed)

func place_series(series):
	
	var pre_series_temp = series_button.instantiate()
	$Buttons.add_child(pre_series_temp)
	
	for i in series.size():
		var series_temp = series_button.instantiate()
		$Buttons.add_child(series_temp)
		i+=1
	
	var children_names = $Buttons.get_children()
	
	for i in $Buttons.get_child_count():
		var current_child = "Buttons/" + str(children_names[$Buttons.get_child_count() - (i+1)])
		if current_child[8] == "@":
			if get_node(current_child) != null:
				get_node(current_child).set_button(series,button_position,i)
			button_position.y += 220
			$Camera.limit += 220
			i+=1
		else:
			break
	
	get_node("Buttons/Series_Button").queue_free()

func search_text_changed(new_text: String):
	
	button_position.x = -800.0
	button_position.y = -250.0
	$Camera.limit = 80
	
	var children = $Buttons.get_children()
	for i in $Buttons.get_child_count():
		get_node("Buttons/" + str(children[i])).queue_free()
		i += 1
	
	var query = new_text.strip_edges().to_lower()
	var filtered = []
	
	for i in series_folders:
		if query == "" or query in i.to_lower():
			filtered.append(i)
	
	place_series(filtered)
