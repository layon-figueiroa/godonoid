extends Node2D

@onready var ball: CharacterBody2D = $Ball

func _ready() -> void:
	ball.destroy_brick.connect(_on_destroy_brick)
	
func _on_destroy_brick(brick) -> void:
	brick.destroy()
