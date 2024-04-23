extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var double_jumped = false

var invuln = false
var inv_frame = .5

var max_health = 200
var health = max_health

var level = 0
var dubloons = 0

#level = level_mod * sqrt(dubloons)
var level_mod = .4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var hurt_box = $HurtBox
@onready var invuln_timer = $InvulnTimer
@onready var game = $"../.."
@onready var visuals = $Visuals

func _ready():
	animation_player.play("walk")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	elif double_jumped:
		double_jumped = false
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif !is_on_floor() and !double_jumped:
			double_jumped = true
			velocity.y = JUMP_VELOCITY*2/3
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	if !invuln:
		if hurt_box.has_overlapping_areas():
			for n in hurt_box.get_overlapping_areas():
				if n.is_in_group("hit"):
					take_damage(n.get_parent().damage)	#jenk, as hitboxes are children of the base enemy node, which contains damage for now.
					break
	
	
	#if direction and visuals.scale.x != direction:
		#visuals.scale.x = direction

func dubloon_pickup(amount):
	dubloons += amount
	if level != calculate_level(dubloons):
		#trigger levelup
		pass
	pass
	
func calculate_level(dubs):
	return level_mod * sqrt(dubloons)

func level_up():
	pass

func invuln_up():
	invuln = false
	pass

func take_damage(dmg):
	health -= dmg
	if health <= 0:
		game.player_death()
		set_process_mode(Node.PROCESS_MODE_DISABLED)
	else:
		invuln = true
		invuln_timer.start()
		modulate = Color.RED
		create_tween().tween_property(self,"modulate",Color(Color.WHITE,1),.5).finished
