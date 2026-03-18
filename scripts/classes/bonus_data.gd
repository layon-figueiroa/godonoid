extends Node
class_name BonusData

var texture: Texture2D
var effect: String

func _init(p_texture: Texture2D, p_effect: String) -> void:
	texture = p_texture
	effect = p_effect
