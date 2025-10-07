extends TextureRect

var desired_position
var back_destination = ""

func set_bar(menu_type):
	match menu_type:
		"manhwa_menu":
			$Button.queue_free()
		"series_menu":
			var entered_media_type = false
			var exited_media_type = false
			for i in Global.series_path.length():
				if entered_media_type == false:
					if Global.series_path[Global.series_path.length() - (i+1)] == "/":
						entered_media_type = true
				elif exited_media_type == false:
					if Global.series_path[Global.series_path.length() - (i+1)] == "/":
						exited_media_type = true
					else:
						back_destination += Global.series_path[Global.series_path.length() - (i+1)]
				else:
					i = Global.series_path.length() - 1
				i += 1
			#print(back_destination)
		"chapter_menu":
			back_destination = "series"

func _process(delta):
	desired_position = $"../Camera".position
	desired_position.x -= 1000
	desired_position.y -= 550
	position = desired_position


func _on_button_pressed():
	match back_destination:
		"series":
			get_tree().change_scene_to_file("res://assets/scenes/series_menu.tscn")
		"awhnam":
			get_tree().change_scene_to_file("res://assets/scenes/manhwa_menu.tscn")
		
