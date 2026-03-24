extends Node

@export var brick_model: PackedScene

var brick_width: float = 64.0
var brick_height: float = 32.0

func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)
	generate_brick_group()

func generate_brick_group() -> void:
	clear_remaining_bricks()
	
	for i in range(6):
		for j in range(9):
			var brick = brick_model.instantiate()
			brick.position = Vector2((brick_width * j + brick_width / 2), (brick_height * i + brick_height / 2))
			add_child(brick)
			
func clear_remaining_bricks() -> void:
	for child in get_children():
		child.queue_free()

func _on_game_over() -> void:
	clear_remaining_bricks()

func _on_state_changed(new_state) -> void:
	if new_state != GameManager.State.START:
		return

	generate_brick_group()
