extends CanvasLayer

static var health_image = preload("res://graphics/UI/ship_G_life.png")

@onready var box_container = $LifesContainer/HBoxContainer
@onready var score_text = $MarginContainer/Score

var player_health: int = 5
var time_elapsed: float = 0


func set_health(health: int) -> void:
	for child in box_container.get_children():
		child.queue_free()
	
	for i in range(health):
		var texture_rect = TextureRect.new()
		texture_rect.texture = health_image
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP
		box_container.add_child(texture_rect)


func _on_timer_timeout() -> void:
	Global.score += 1
	score_text.text = str(Global.score)
