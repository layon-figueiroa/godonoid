extends Area2D

signal collected(effect)

@onready var texture_scene: Sprite2D = $Texture

var speed: float = 100.0
var effect: String

var bonus_object: Array[BonusData] = [
	BonusData.new(preload("res://assets/sprites/game_objects/blue_bonus.png"), "score"),
	BonusData.new(preload("res://assets/sprites/game_objects/green_bonus.png"), "speed"),
	BonusData.new(preload("res://assets/sprites/game_objects/red_bonus.png"), "speed"),
	BonusData.new(preload("res://assets/sprites/game_objects/yellow_bonus.png"), "score")
]

func _ready() -> void:
	select_texture_and_effect()
	body_entered.connect(_on_body_entered)
	
func _process(delta: float) -> void:
	position.y += speed * delta
	
	check_out_of_screen()

func select_texture_and_effect() -> void:
	var bonus = bonus_object.pick_random()
	texture_scene.texture = bonus.texture
	effect = bonus.effect
	
func check_out_of_screen() -> void:
	var screen_height = get_viewport_rect().size.y
	
	if position.y > screen_height + 50:
		queue_free()
		print("Bônus sumiu")
		
func _on_body_entered(body) -> void:
	if body.is_in_group("paddle"):
		collected.emit(effect)
	
	queue_free()
