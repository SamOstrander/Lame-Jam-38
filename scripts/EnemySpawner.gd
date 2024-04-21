extends Node2D


var game_state = 0

var timer_length = .7

const ROPE = preload("res://scenes/environment/rope.tscn")

@onready var timer = $Timer
@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = timer_length


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func spawn_enemy():
	#spawn enemy from gamestate pool
	#descend from rope
	#on rope below height, they they're destroyed and replaced with actual enemy.
	#if time, tween from rigidbody angle to 0
	var rope = ROPE.instantiate()
	rope.position = Vector2(player.position.x,-30)
	
