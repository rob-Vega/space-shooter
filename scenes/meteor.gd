extends Area2D


var meteorsTextures: Array = [
	"res://graphics/meteors/meteorBrown_big1.png",
	"res://graphics/meteors/meteorBrown_big2.png",
	"res://graphics/meteors/meteorBrown_big3.png",
	"res://graphics/meteors/meteorBrown_big4.png",
	"res://graphics/meteors/meteorGrey_big1.png",
	"res://graphics/meteors/meteorGrey_big2.png",
	"res://graphics/meteors/meteorGrey_big3.png",
	"res://graphics/meteors/meteorGrey_big4.png"
	]
var rng := RandomNumberGenerator.new()
var speed: int
var direction_x: float
var rotation_speed: float


func _ready() -> void:
	$MeteorSprite.texture = load(
		meteorsTextures[rng.randi_range(0, meteorsTextures.size() - 1)]
		)
	
	# start position
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(10, width -10)
	var random_y = rng.randi_range(-150, -100)
	position = Vector2(random_x, random_y)
	
	# rng speed / rotation / direction
	speed = rng.randi_range(200, 500)
	direction_x = rng.randf_range(-1, 1)
	rotation_speed = rng.randf_range(1, 5)


func _process(delta: float) -> void:
	position += Vector2(direction_x, 1.0) * speed * delta
	rotate(rotation_speed * delta)


func _on_body_entered(body: Node2D) -> void:
	print('body entered')
