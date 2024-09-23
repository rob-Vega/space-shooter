extends Node2D


# load scene
var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var star_scene: PackedScene = load("res://scenes/star.tscn")

# cambiar health a player o global
@export var health: int = 5
@onready var player_heath = $Player.player_health


func _ready() -> void:
	# set health ui
	# get_tree().call_group("ui", "set_health", health)
	$UI.set_health(player_heath)
	
	# change to number_stars variable, export?
	for n in 30:
		var star = star_scene.instantiate()
		$Stars.add_child(star)


# SIGNALS
func _on_meteor_timer_timeout() -> void:
	# create instance
	var meteor = meteor_scene.instantiate()
	
	# connect the signal
	meteor.collision.connect(_on_meteor_collision)
	
	# attach the node to the scene tree
	$Meteors.add_child(meteor)


func _on_meteor_collision():
	$MeteorCollision.play()
	player_heath -= 1

	#get_tree().call_group("ui", "set_health", health)
	$UI.set_health(player_heath)
	_on_player_take_damage()
	
	if player_heath <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")


func _on_player_shoot_laser(pos: Vector2) -> void:
	var laser = laser_scene.instantiate()
	laser.rotation = $Player.rotation
	laser.position = pos
	$Lasers.add_child(laser)


func _on_player_take_damage() -> void:
	$Player.change_sprite_color()
