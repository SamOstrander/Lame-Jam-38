extends RigidBody2D

var enemy
var release_height = 420

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")
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
			print("free")
			get_node("PinJoint2D").queue_free()

#on collision (ideally with floor), get current rotation, destroy self, replace with actual enemy, tween from current angle to flattened against floor, fix angle and then tween to straight up. 
func _on_body_entered(body):
	var current_rotation = rotation
	#create enemy
	#enemy.rotation = current_rotation
	#enemy.spawning = true
	#enemy.animationplayer.play(
	
	pass # Replace with function body.
