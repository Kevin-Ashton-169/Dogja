extends Button

var chapter_name

func set_button(chapter_folder,button_position,i):
	
	var img_path = "C:/Dogja/media/" + Global.media + "/" + chapter_folder[i] + "/icon.webp"
	var img = Image.new()
	img.load(img_path)
	if img != null:
		var img_texture = ImageTexture.create_from_image(img)
		icon = img_texture
	
	chapter_name = chapter_folder[i]
	
	var chapter_button_name
	var pass_first_zeros = false
	
	for j in chapter_name.length():
		if chapter_name[j] != "0" and pass_first_zeros == false:
			text = ""
			text += chapter_name[j]
			pass_first_zeros = true
		elif pass_first_zeros == true:
			text += chapter_name[j]
		j += 1
		
	position = button_position
	size.x = 1600
	size.y = 200

func _on_pressed():
	Global.chapter = Global.series_path + "/" + chapter_name
	get_tree().change_scene_to_file("res://assets/scenes/chapter_menu.tscn")
