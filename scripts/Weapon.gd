extends Node2D

var range = 300
var cd = 2
var damage = 20
@onready var arm = $".."
	#cd
@onready var timer = $Timer

var ranged = false
#var projectile = preload("") #all hitscan? seems more consistent i think. 
#var effect = preload("")	#for swings

# Called when the node enters the scene tree for the first time.
func _ready():
	arm.weapon_change(self)
	timer.wait_time = cd

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func trigger_attack():
	if ranged:
		#create projectile
		pass
	#play attack animation
		#from the arm object?
	#play attack sound
	pass
