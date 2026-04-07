extends Node

signal state_changed(new_state) # Avisa às cenas quando o estado do jogo mudou
signal life_lost

enum State {
	START,
	PLAYING,
	STAND_BY,
	PAUSED,
	UNPAUSED,
	GAME_OVER,
	WIN,
	CREDITS
}

var current_state: State = State.START
var current_score: int = 0
var top_score: int = 0
var lives: int = 3
var total_bricks: int = 45

## Função chamada pelas cenas do jogo para solicitar a mudança de estado

func change_state(new_state: State) -> void:
	if new_state == current_state:
		return
	
	current_state = new_state
	state_changed.emit(current_state)
	
	match current_state:
		State.START:
			call_start_screen()
		State.PAUSED:
			call_pause_game()
		State.UNPAUSED:
			call_unpause_game()
		State.WIN:
			call_win()
		State.CREDITS:
			call_credits()

## Funções chamadas de acordo com cada estado do jogo #################

## Controla as ações quando o jogo está na tela inicial
func call_start_screen() -> void:
	current_score = 0
	lives = 3
	total_bricks = 45

## Controla as ações quando o jogo é pausado
func call_pause_game() -> void:
	get_tree().paused = true

## Controla as ações quando o jogo é despausado
func call_unpause_game() -> void:
	get_tree().paused = false
	#change_state(State.PLAYING)
	
## Controla as ações quando o jogador vence o jogo
func call_win() -> void:
	get_tree().paused = true

## Controla as ações quando exibindo os créditos
func call_credits() -> void:
	pass

## Funções de manipulação de scores e vidas #########################

## Altera o score quando chamada
func add_score(point: int) -> void:
	current_score += point

## Altera o top_score caso o score atual seja maior
## Que o valor do top_score atual
func update_top_score() -> void:	
	top_score = max(current_score, top_score) # Função max retorna o maior número entre dois números

## Remove uma vida do jogador
func lose_life() -> void:
	lives = max(lives - 1, 0) # Evita que a quantidade de vidas seja menor que zero
	if lives == 0:
		update_top_score()
		change_state(State.GAME_OVER)
		return

	change_state(State.STAND_BY)
	life_lost.emit()

func remove_bricks() -> void:
	total_bricks = max(total_bricks - 1, 0)
	
	if total_bricks != 0:
		return
	
	change_state(State.WIN)
