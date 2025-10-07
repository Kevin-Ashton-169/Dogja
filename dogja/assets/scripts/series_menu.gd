extends Node2D

var dir = DirAccess.open(Global.series_path)
@onready var chapter_button : PackedScene = preload("res://assets/scenes/chapter_button.tscn")
@onready var top_bar : PackedScene = preload("res://assets/scenes/top_bar.tscn")
var button_position = Vector2.ZERO

func _ready():
	
	button_position.x = -800.0
	button_position.y = 175.0
	
	var description_path = Global.series_path + "/description.txt"
	var description = FileAccess.open(description_path,FileAccess.READ)
	var text = ""
	var text_box = 0
	
	var img_path = Global.series_path + "/cover.webp"
	var img = Image.new()
	img.load(img_path)
	if img != null:
		var img_texture = ImageTexture.create_from_image(img)
		$Sprite2D.texture = img_texture
		$Sprite2D.size.x = 330.0
		$Sprite2D.size.y = 390.0
	
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
	
	var chapter_folder = dir.get_directories()
	var pre_chapter_temp = chapter_button.instantiate()
	add_child(pre_chapter_temp)
	
	#print(chapter_folder.size())
	
	for i in chapter_folder.size():
		var chapter_temp = chapter_button.instantiate()
		add_child(chapter_temp)
	
	var children_names = $".".get_children()
	
	for i in $".".get_child_count():
		var current_child = str(children_names[$".".get_child_count() - (i+1)])
		if current_child[0] == "@":
			if get_node(current_child) != null:
				get_node(current_child).set_button(chapter_folder,button_position,i)
			button_position.y += 220
			$Camera.limit += 220
			i+=1
		else:
			break
	
	get_node("Chapter_Button").queue_free()
	var top_bar_temp = top_bar.instantiate()
	add_child(top_bar_temp)
	$Top_Bar.set_bar("series_menu")
