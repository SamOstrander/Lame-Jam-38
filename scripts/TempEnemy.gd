extends CharacterBody2D

const ACC = 200
const SPEED = 200
#const JUMP_VELOCITY = -400.0
var min_distance = 10
var direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var timer = $Timer
@onready var player = $"../Player"
@onready var target_position = player.global_position

func _ready():
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
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func update_targetpos():
	target_position = player.global_position
