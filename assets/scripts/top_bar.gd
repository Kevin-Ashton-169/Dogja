extends TextureRect

var menu_type
var desired_position
var back_destination = ""

func set_bar(a):
	menu_type = a
	match menu_type:
		"manhwa", "manga", "comics", "books":
			match menu_type:
				"manga":
					$Highlight.position.x += 180
				"comics":
					$Highlight.position.x += 360
				"books":
					$Highlight.position.x += 540
			
		"series", "options":
			
			$Button01.text = "Back"
			$Button02.queue_free()
			$Button03.queue_free()
			$Button04.queue_free()
			if menu_type == "options":
				$Highlight.position.x += 1730
				$Search_Bar.queue_free()
			else:
				$Highlight.queue_free()
				$Search_Bar.size.x += 550
				$Search_Bar.position.x -= 550
			
			back_destination = "media"
			
		"chapter":
			$Button01.text = "Back"
			$Button02.queue_free()
			$Button03.queue_free()
			$Button04.queue_free()
			$Highlight.queue_free()
			$Search_Bar.queue_free()
			back_destination = "series"

func _process(delta):
	desired_position = $"../Camera".position
	desired_position.x -= 1000
	desired_position.y -= 550
	position = desired_position

func _on_button_01_pressed():
	
	match menu_type:
		"manhwa", "manga", "comics", "books":
			Global.media = "manhwa"
			get_tree().change_scene_to_file("res://assets/scenes/media_menu.tscn")
		"series", "options", "chapter":
			if back_destination == "series":
					get_tree().change_scene_to_file("res://assets/scenes/series_menu.tscn")
			else:
					get_tree().change_scene_to_file("res://assets/scenes/media_menu.tscn")

func _on_button_02_pressed():
	
	match menu_type:
		"manhwa", "manga", "comics", "books":
			Global.media = "manga"
			get_tree().reload_current_scene()
		"chapter":
			pass

func _on_button_03_pressed():
	
	match menu_type:
		"manhwa", "manga", "comics", "books":
			Global.media = "comics"
			get_tree().reload_current_scene()
		"chapter":
			pass

func _on_button_04_pressed():
	
	match menu_type:
		"manhwa", "manga", "comics", "books":
			Global.media = "books"
			get_tree().reload_current_scene()
		"chapter":
			pass

func _on_button_05_pressed():
	get_tree().change_scene_to_file("res://assets/scenes/options_menu.tscn")
