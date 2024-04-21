extends Node2D

@onready var default_angle = rotation
@onready var attack_range_area = $AttackRangeArea
@onready var ar_shape = $AttackRangeArea/CollisionShape2D
@onready var sprite_2d = $Sprite2D

var weapon
var target_enemy
var rotate_speed = 3*PI/2
var target_update_rate = .6
var flipped = false

@onready var flip_range = Vector2(default_angle-PI/2, default_angle + PI/2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !target_enemy or target_enemy.is_queued_for_deletion():
		update_target_enemy()
	update_target_enemy()
	if target_enemy:
		var ang = global_position.angle_to_point(target_enemy.position)
		rotation = rotate_toward(rotation,ang,rotate_speed*delta)
	
	#var trot = (rotation+2*PI) / (2*PI)
	#while trot > 1:
		#trot -= 1
	#trot = trot * 2 * PI

	if abs(angle_difference(rotation, default_angle)) > PI/2 and !flipped:
		print("flip")
		flipped = true
		#sprite_2d.scale.y *= -1
		sprite_2d.flip_v = !sprite_2d.flip_v
	elif abs(angle_difference(rotation, default_angle)) < PI/2 and flipped:
		print("unflip")
		flipped = false
		sprite_2d.flip_v = !sprite_2d.flip_v

func weapon_change(weapon_node):
	weapon = weapon_node
	#weapon behaviour node added. modify area range and other junk
	#attack_range_area.visible = true
	#attack_range_area.get_shape().set_radius(weapon.range)
	pass

func update_target_enemy():
	#loop through enemies in range and target closest to arm. 
	var closest
	var closest_distance : float = ar_shape.get_shape().get_radius()
	#print(ar_shape.get_shape())
	if attack_range_area.has_overlapping_bodies():
		for n in attack_range_area.get_overlapping_bodies():
			if n.is_in_group("enemy") and global_position.distance_to(n.global_position) < closest_distance:
				closest = n
				closest_distance = position.distance_to(n.position) < closest_distance
		target_enemy = closest
