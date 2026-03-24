extends StaticBody2D

@export var bonus_scene: PackedScene
@onready var texture_scene: Sprite2D = $Texture

var bonus_chance: int

## Quando se trata de texturas é necessário carregar a textura e não passar uma string de path
## Por isso esse array é um Array[Texture2D] e usamos preload pra carregar cada imagem a ser usada

var brick_textures: Array[Texture2D] = [
	preload("res://assets/sprites/game_objects/white_brick.png"),
	preload("res://assets/sprites/game_objects/red_brick.png"),
	preload("res://assets/sprites/game_objects/purple_brick.png"),
	preload("res://assets/sprites/game_objects/green_brick.png"),
	preload("res://assets/sprites/game_objects/blue_brick.png"),
	preload("res://assets/sprites/game_objects/yellow_brick.png")
]

func _ready() -> void:
	bonus_chance = randi_range(1, 3)
	
	select_brick_color()

func select_brick_color() -> void:
	texture_scene.texture = brick_textures.pick_random() #seleciona um item aleatório do array
	
func destroy() -> void:
	if bonus_chance == 1:
		var bonus = bonus_scene.instantiate()
		bonus.position = position
		
		var paddle = get_tree().get_first_node_in_group("paddle")
		bonus.collected.connect(paddle._on_bonus_collected)
		
		get_parent().add_child(bonus) #O pai quem precisa instanciar o bonus. Nesse caso a cena Game
	
	queue_free()
	GameManager.remove_bricks()
