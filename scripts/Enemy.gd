extends CharacterBody2D

const ACC = 200
const SPEED = 200
#const JUMP_VELOCITY = -400.0
var min_distance = 10
var direction = 1

var max_health = 100
var health = max_health
var dying = false

var damage = 20

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#const sprites = [preload("res://assets/sprites/the_carptain.png"),preload("res://assets/sprites/mimic boyo scarred.png")]
@onready var timer = $Timer
@onready var player = $"../Player"
@onready var target_position = player.global_position
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
const DOUBLOON_PICKUP = preload("res://scenes/pickups/doubloon_pickup.tscn")
@onready var hit_box = $HitBox
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	#sprite_2d.texture = sprites.pick_random()
	animation_player.play("walk")
	
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if abs(target_position.x - global_position.x) > min_distance:
		#move toward player
		direction = sign(target_position.x - global_position.x)
		velocity = Vector2(clamp(velocity.x + direction*ACC*delta,-SPEED,SPEED),velocity.y)
		#velocity = velocity.move_toward(Vector2(direction*SPEED,velocity.y),ACC*delta)
	
	#dir 1 fliph false
	#dir -1 fliph true
	sprite_2d.flip_h != !clamp(direction,0,1)
	if sprite_2d.flip_h != !clamp(direction,0,1):
		sprite_2d.flip_h = !sprite_2d.flip_h
	
	move_and_slide()

func take_damage(dmg):
	if !dying:
		health -= dmg
		if health <= 0:
			dying = true
			collision_shape_2d.disabled = true
			hit_box.monitorable = false
			hit_box.monitoring = false
			
			var dubby = DOUBLOON_PICKUP.instantiate()
			dubby.position = position
			get_parent().add_child(dubby)
			
			set_physics_process(false)
			await create_tween().tween_property(self,"modulate",Color(modulate,0),1).finished
			queue_free()
		else:
			modulate = Color.RED
			create_tween().tween_property(self,"modulate",Color.WHITE,.5).finished


func update_targetpos():
	target_position = player.global_position
