extends Control


# Usar onready para una referencia más segura a los nodos
@onready var score_label = $CenterContainer/VBoxContainer/YourScoreLabel
var level: PackedScene = preload("res://scenes/level.tscn")


func _ready() -> void:
	score_label.text = "Your Score: " + str(Global.score)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		start_new_game()


# Función para cambiar de escena
func start_new_game() -> void:
	get_tree().change_scene_to_packed(level)
