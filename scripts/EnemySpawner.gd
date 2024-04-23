extends Node2D

var game_state = 0
var timer_length = 4
var offset = 500
var offset2 = 800

const ROPE = preload("res://scenes/environment/rope.tscn")
const ENEMY = preload("res://scenes/units/enemy.tscn")

@onready var timer = $Timer
@onready var player = $"../Player"
@onready var side_timer = $SideTimer

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
	var dir = [1,-1].pick_random()
	rope.direction = dir
	get_parent().add_child(rope)
	#rope.position = Vector2(player.position.x,-30)
	
	rope.position = Vector2(player.position.x+dir*offset*-1,-30)	#offset to one side or other
	

func spawn_enemy_ground():
	print("spawnt2")
	var enemy = ENEMY.instantiate()
	var dir2 = [1,-1].pick_random()
	get_parent().add_child(enemy)
	enemy.position = Vector2(player.position.x+dir2*offset2*-1,500)	#offset to one side or other
