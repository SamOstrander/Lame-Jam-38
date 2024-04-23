extends Area2D

@export var amount = 1
var pull_speed = 400
var pulled = false
var target_node
var pitch_rand = .2
@onready var audio_player = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if pulled:
		global_position = global_position.move_toward(target_node.global_position,pull_speed*delta)
	pass

func trigger_pull(player):
	#print("trigger_pull")
	target_node = player
	pulled = true

func trigger_pickup(player):
	player.dubloon_pickup(amount)
	print("trigger pickup")
	#play pickup sound, disable collision, await 
	audio_player.pitch_scale = audio_player.pitch_scale + randf_range(-pitch_rand/2, pitch_rand/2)
	audio_player.play()
	monitorable = false
	monitoring = false
	create_tween().tween_property(self,"modulate",Color(modulate,0),.4)
	await audio_player.finished
	queue_free()
