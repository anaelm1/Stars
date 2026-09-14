extends CharacterBody2D

# Signals to communicate with UI / HUD
signal health_changed(current_health: int)
signal player_died

# Movement Constants
const SPEED: float = 300.0
const JUMP_VELOCITY: float = -600.0
const MAX_HEALTH: int = 3

# World Boundary (Y coordinate where player dies if they fall off platforms)
const FALL_LIMIT_Y: float = 500.0 

var current_health: int = MAX_HEALTH

func _ready() -> void:
	# Unpause the engine whenever the player spawns or scene restarts
	get_tree().paused = false
	current_health = MAX_HEALTH
	health_changed.emit(current_health)

func _physics_process(delta: float) -> void:
	# 1. Fall boundary check
	if position.y > FALL_LIMIT_Y:
		die()
		return

	# 2. Apply Gravity when in air
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 3. Handle Jump
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump")) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 4. Get horizontal input direction (-1, 0, 1)
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == 0:
		direction = Input.get_axis("move_left", "move_right")

	# 5. Apply horizontal velocity
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 6. Execute physics motion
	move_and_slide()

# Health & Damage Logic
func take_damage(amount: int) -> void:
	current_health -= amount
	health_changed.emit(current_health)
	
	if current_health <= 0:
		die()

# Death Trigger Function
func die() -> void:
	player_died.emit()
	get_tree().paused = true
	
	# Instance and overlay the Game Over screen
	var game_over_scene = load("res://game_over.tscn").instantiate()
	get_tree().current_scene.add_child(game_over_scene)
	queue_free()
