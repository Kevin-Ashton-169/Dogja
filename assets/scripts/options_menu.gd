extends Node2D

@onready var top_bar : PackedScene = preload("res://assets/scenes/top_bar.tscn")

func _ready():
	var top_bar_temp = top_bar.instantiate()
	add_child(top_bar_temp)
	$Top_Bar.set_bar("options")
