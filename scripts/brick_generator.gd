extends Node

@export var brick_model: PackedScene

var brick_width: float = 64.0
var brick_height: float = 32.0

func _ready() -> void:
	generate_brick_group()

func generate_brick_group() -> void:
	for i in range(7):
		for j in range(12):
			var brick = brick_model.instantiate()
			brick.position = Vector2(brick_width * j + brick_width / 2, brick_height * i + brick_height / 2)
			add_child(brick)
