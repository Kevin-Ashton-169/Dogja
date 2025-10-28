extends Node2D

var type_media
var dir = DirAccess.open(Global.chapter)
@onready var page : PackedScene = preload("res://assets/scenes/page.tscn")
@onready var top_bar : PackedScene = preload("res://assets/scenes/top_bar.tscn")
var page_position = Vector2.ZERO

func _ready():
	
	var files_in_dir = dir.get_files()
	var page_files = []
	
	for i in files_in_dir.size():
		if files_in_dir[i].ends_with(".webp") or files_in_dir[i].ends_with(".jpg") or files_in_dir[i].ends_with(".jpeg"):
			page_files.append(files_in_dir[i])
	
	var temp_ghost_page = page.instantiate()
	add_child(temp_ghost_page)
	var first_page = true
	page_position.y -= 500
	
	for i in page_files.size():
		var temp_page = page.instantiate()
		add_child(temp_page)
	
	var children_names = $".".get_children()
	
	for i in $".".get_child_count():
		var current_child = str(children_names[$".".get_child_count() - (i+1)])
		if current_child[0] == "@":
			if get_node(current_child) != null:
				var img_path = Global.chapter + "/" + page_files[i]
				var img = Image.new()
				img.load(img_path)
				var img_texture = ImageTexture.create_from_image(img)
				get_node(current_child).texture = img_texture
				if first_page == true:
					get_node(current_child).position = page_position
					page_position.x = -(get_node(current_child).size.x / 2)
					get_node(current_child).position = page_position
					page_position.y += get_node(current_child).size.y
					$Camera.limit += get_node(current_child).size.y
				else:
					get_node(current_child).position = page_position
					page_position.x = -(get_node(current_child).size.x / 2)
					get_node(current_child).position = page_position
					page_position.y += get_node(current_child).size.y
					$Camera.limit += get_node(current_child).size.y
	
	get_node("Page").queue_free()
	var temp_bar = top_bar.instantiate()
	add_child(temp_bar)
	$Top_Bar.set_bar("chapter")
