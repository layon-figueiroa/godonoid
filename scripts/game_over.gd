extends Control

@onready var score_label: Label = $VBoxContainer/HBoxContainer/Label2
@onready var high_score_label: Label = $VBoxContainer/HBoxContainer2/Label2

func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)
	
func show_game_over() -> void:
	score_label.text = str(GameManager.current_score)
	high_score_label.text = str(GameManager.top_score)
	visible = true
	
func _on_state_changed(new_state) -> void:
	if new_state != GameManager.State.GAME_OVER:
		return
	
	show_game_over()

func _on_button_pressed() -> void:
	GameManager.change_state(GameManager.State.START)
	visible = false
