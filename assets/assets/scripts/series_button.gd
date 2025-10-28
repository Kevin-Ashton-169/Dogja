extends Button

var series_name

func set_button(series_folder,button_position,i):
	
	var img_path = "C:/Dogja/media/" + Global.media + "/" + series_folder[i] + "/icon.webp"
	var img = Image.new()
	img.load(img_path)
	if img != null:
		var img_texture = ImageTexture.create_from_image(img)
		icon = img_texture
	
	series_name = series_folder[i]
	
	text = series_folder[i]
	position = button_position
	size.x = 1600
	size.y = 200

func _on_pressed():
	Global.series_path = "C:/Dogja/media/" + Global.media + "/" + series_name
	get_tree().change_scene_to_file("res://assets/scenes/series_menu.tscn")
