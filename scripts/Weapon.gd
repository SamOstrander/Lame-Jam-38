extends Node2D

var range = 300
var is_cd = false

var cd = 2
var cd_rand = .1
var damage = 20
@onready var arm = $".."
	#cd
@onready var timer = $Timer
@onready var shot_effect = $ShotEffect

var ranged = false
#var projectile = preload("") #all hitscan? seems more consistent i think. 
#var effect = preload("")	#for swings

# Called when the node enters the scene tree for the first time.
func _ready():
	arm.weapon_change(self)
	timer.wait_time = cd + randf_range(0,cd_rand)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_cd and arm.target_enemy != null and arm.target_enemy and !arm.target_enemy.dying:
		trigger_attack()

func trigger_attack():
	is_cd = true
	#play attack animation
	shot_effect.shot_trigger()
	arm.target_enemy.take_damage(damage)
			#from the arm object?
		#play attack sound

func attack_cd():
	is_cd = false
	timer.wait_time = cd + randf_range(0,cd_rand)
