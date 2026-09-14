extends Area2D

# Path to your victory overlay screen
@export var win_scene_path: String = "res://game_won.tscn"

func _ready() -> void:
	# Connect the collision signal
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		# Directly switch scene instead of adding a child overlay
		get_tree().change_scene_to_file("res://game_won.tscn")
