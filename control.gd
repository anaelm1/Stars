extends Node2D

func _ready() -> void:
	$CanvasLayer/VBoxContainer/StartButton.pressed.connect(_on_start_pressed)
	$CanvasLayer/VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn") 

func _on_quit_pressed() -> void:
	get_tree().quit()
