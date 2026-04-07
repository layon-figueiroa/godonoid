extends Control

func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)
	
func _on_state_changed(new_state) -> void:
	if new_state == GameManager.State.WIN:
		visible = true
		
		await get_tree().create_timer(5.0, true).timeout
		
		GameManager.change_state(GameManager.State.START)
		get_tree().paused = false
	else:
		visible = false
