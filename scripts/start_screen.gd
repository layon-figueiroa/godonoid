extends Control

func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)
	
func _on_state_changed(new_state) -> void:
	if new_state != GameManager.State.START:
		return
	
	visible = true

func _on_button_pressed() -> void:
	GameManager.change_state(GameManager.State.STAND_BY)
	visible = false
	
func _on_btn_quit_pressed() -> void:
	get_tree().quit()

func _on_btn_credits_pressed() -> void:
	GameManager.change_state(GameManager.State.CREDITS)
	visible = false
