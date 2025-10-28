extends Node2D

var dir = DirAccess.open(Global.series_path)
@onready var chapter_button : PackedScene = preload("res://assets/scenes/chapter_button.tscn")
@onready var top_bar : PackedScene = preload("res://assets/scenes/top_bar.tscn")
var button_position = Vector2.ZERO
var chapter_folders

func _ready():
	
	button_position.x = -800.0
	button_position.y = 175.0
	
	var description_path = Global.series_path + "/description.txt"
	var description = FileAccess.open(description_path,FileAccess.READ)
	var text = ""
	var text_box = 0
	
	if description != null:
		description = description.get_as_text()
	
		for i in description.length():
			if description[i] == "\n" and text_box == 0:
				$Control/author.text = text
				text = ""
				text_box += 1
			elif description[i] == "\n" and text_box == 1:
				$Control/artist.text = text
				text = ""
				text_box += 1
			elif text_box == 2:
				$Control/synopes.text += description[i]
			else:
				text += description[i]
			i += 1
	
	var img_path = Global.series_path + "/cover.webp"
	var img = Image.new()
	img.load(img_path)
	if img != null:
		var img_texture = ImageTexture.create_from_image(img)
		$Sprite2D.texture = img_texture
		$Sprite2D.size.x = 330.0
		$Sprite2D.size.y = 390.0
	
	chapter_folders = dir.get_directories()
	place_chapters(chapter_folders)
	
	var top_bar_temp = top_bar.instantiate()
	add_child(top_bar_temp)
	$Top_Bar.set_bar("series")
	$Top_Bar/Search_Bar.text_changed.connect(search_text_changed)

func place_chapters(chapters):
	
	var pre_chapter_temp = chapter_button.instantiate()
	$Buttons.add_child(pre_chapter_temp)
	
	for i in chapters.size():
		var chapter_temp = chapter_button.instantiate()
		$Buttons.add_child(chapter_temp)
		i+=1
	
	var children_names = $Buttons.get_children()
	
	for i in $Buttons.get_child_count():
		var current_child = "Buttons/" + str(children_names[$Buttons.get_child_count() - (i+1)])
		if current_child[8] == "@":
			if get_node(current_child) != null:
				get_node(current_child).set_button(chapters,button_position,i)
			button_position.y += 220
			$Camera.limit += 220
			i+=1
		else:
			break
	
	get_node("Buttons/Chapter_Button").queue_free()

func search_text_changed(new_text: String):
	
	button_position.x = -800.0
	button_position.y = 175.0
	$Camera.limit = 80
	
	var children = $Buttons.get_children()
	for i in $Buttons.get_child_count():
		get_node("Buttons/" + str(children[i])).queue_free()
		i += 1
	
	var query = new_text.strip_edges().to_lower()
	var filtered = []
	
	for i in chapter_folders:
		if query == "" or query in i.to_lower():
			filtered.append(i)
	
	place_chapters(filtered)
