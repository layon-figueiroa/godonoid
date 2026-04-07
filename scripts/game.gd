extends Node2D

#signal pause_game

var state: GameManager.State
var pause_game: bool = false

@onready var ball: CharacterBody2D = $Ball

func _ready() -> void:
	ball.destroy_brick.connect(_on_destroy_brick)
	GameManager.state_changed.connect(_on_state_changed)
	
func _on_destroy_brick(brick) -> void:
	brick.destroy()
	
func _on_state_changed(new_state) -> void:
	state = new_state
		
func _input(event) -> void:
	if (state != GameManager.State.PLAYING and 
		state != GameManager.State.PAUSED and 
		state != GameManager.State.UNPAUSED):
		return
		
	if event.is_action_pressed("pause"):
		pause_game = !pause_game
		
		if pause_game:
			GameManager.change_state(GameManager.State.PAUSED)
		else:
			GameManager.change_state(GameManager.State.UNPAUSED)
