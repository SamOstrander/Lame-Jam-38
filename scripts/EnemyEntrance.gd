extends RigidBody2D

var enemy
var release_height = 300

const ENEMY = preload("res://scenes/units/enemy.tscn")
const sprites = [preload("res://assets/sprites/the_carptain.png"),preload("res://assets/sprites/mimic boyo scarred.png")]
@onready var sprite_2d = $Sprite2D
var spr

# Called when the node enters the scene tree for the first time.
func _ready():
	spr = sprites.pick_random()
	sprite_2d.texture = spr
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.y > release_height:
		#or maybe once the rope snaps(downward vel < certain amount)
		#if enemy:
			#var e = enemy.instantiate()
			#get_parent().add_child(enemy)
			#enemy.position = position
		#queue_free()
			#release
		if(get_node("PinJoint2D")):
			get_node("PinJoint2D").queue_free()

#on collision (ideally with floor), get current rotation, destroy self, replace with actual enemy, tween from current angle to flattened against floor, fix angle and then tween to straight up. 
func _on_body_entered(body):
	var current_rotation = rotation
	#create enemy
	#enemy.rotation = current_rotation
	#enemy.spawning = true
	#enemy.animationplayer.play(
	var enemy = ENEMY.instantiate()
	enemy.get_node("Sprite2D").texture = spr
	enemy.global_position = global_position
	get_parent().add_child(enemy)
	queue_free()
	pass # Replace with function body.


