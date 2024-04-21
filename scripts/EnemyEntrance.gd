extends RigidBody2D

var enemy
var release_height = 360

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(position.y)
	if global_position.y > release_height:
		#or maybe once the rope snaps(downward vel < certain amount)
		if enemy:
			var e = enemy.instantiate()
			get_parent().add_child(enemy)
			enemy.position = position
		queue_free()
	pass
