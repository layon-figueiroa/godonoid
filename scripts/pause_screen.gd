extends Control

func _ready() -> void:
	GameManager.state_changed.connect(_on_state_changed)
	
func _on_state_changed(new_state) -> void:
	if new_state == GameManager.State.PAUSED:
		visible = true
	elif new_state == GameManager.State.UNPAUSED:
		visible = false
	else:
		return
