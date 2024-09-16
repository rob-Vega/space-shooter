extends Area2D

@export var speed = 700


func _ready() -> void:
	$Sprite2D.scale = Vector2(0, 0)
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(1, 1), 0.2)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speed * delta


func _on_area_entered(area: Area2D) -> void:
	print("area")
