extends Control

@onready var credits: VBoxContainer = $VContainer

var speed: float = 50.0
var credits_state: bool = false
var initial_position: float

func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)
	initial_position = get_viewport_rect().size.y
	credits.position.y = initial_position
	
func _process(delta: float) -> void:
	if !credits_state:
		return
	
	move_credits(delta)
	
	
func move_credits(delta: float) -> void:
	credits.position.y -= speed * delta
	if credits.position.y + credits.size.y < 0:
		credits.position.y = initial_position
		GameManager.change_state(GameManager.State.START)
		visible = false
		credits_state = false

func _on_state_changed(new_state) -> void:
	if new_state == GameManager.State.CREDITS:
		visible = true
		credits_state = true
		AudioManager.play_music(preload("res://assets/audios/04 Ending.mp3"))
	
