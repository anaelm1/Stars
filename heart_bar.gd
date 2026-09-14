extends CanvasLayer

@onready var heart_container = $HBoxContainer

func update_health(health: int) -> void:
	for i in range(heart_container.get_child_count()):
		# Show hearts matching remaining health
		heart_container.get_child(i).visible = i < health
