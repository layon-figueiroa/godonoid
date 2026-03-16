extends Node

signal state_changed(new_state) # Avisa às cenas quando o estado do jogo mudou

enum State {
	START,
	PLAYING,
	PAUSED,
	GAME_OVER,
	CREDITS
}

var current_state: State = State.START
var current_score: int = 0
var top_score: int = 0
var lives: int = 3

## Função chamada pelas cenas do jogo para solicitar a mudança de estado

func change_state(new_state: State) -> void:
	if new_state == current_state:
		return
	
	current_state = new_state
	state_changed.emit(current_state)
	
	match current_state:
		State.START:
			pass
		State.PLAYING:
			pass
		State.PAUSED:
			pass
		State.GAME_OVER:
			pass
		State.CREDITS:
			pass

## Funções chamadas de acordo com cada estado do jogo #################

## Controla as ações quando o jogo está na tela inicial
func call_start_screen() -> void:
	print("Showing start screen now!")

## Controla as ações quando jogo é iniciado
func call_play_game() -> void:
	print("Playing game now!")

## Controla as ações quando o jogo é pausado
func call_pause_game() -> void:
	print("Game is paused now...")

## Controla as ações quando em game over
func call_game_over() -> void:
	print("Game finished now...")

## Controla as ações quando exibindo os créditos
func call_credits() -> void:
	print("Showing game credits now")

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
