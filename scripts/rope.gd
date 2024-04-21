extends StaticBody2D

@export var rope_length = 14 #in segments
var last = self
const ROPE_SEGMENT = preload("res://scenes/environment/rope_segment.tscn")
var end_seg
@onready var timer = $Timer
#@onready var enemy_entrance = $"../../EnemyEntrance"
const ENEMY_ENTRANCE = preload("res://scenes/units/enemy_entrance.tscn")
var height = 17*2
@onready var parent = get_parent()
var velocity = Vector2(0,0)
var reel_in = false
var reel_speed = 600
var reel_acc = 200
var direction = 1
#var dumb = [1,-1]

# Called when the node enters the scene tree for the first time.
func _ready():
	rotate(direction*.5*PI)
	#parent = get_parent()
	#generate grass_length-1 segments, and finish with an end segment
	for n in range(rope_length-1):
		var seg = ROPE_SEGMENT.instantiate()
		add_child(seg)
		seg.position.y = height*n - height/2
		var pj = seg.get_node("PinJoint2D")
		
		pj.set_node_a(last.get_path())
		pj.set_node_b(seg.get_path())
		last = seg
	end_seg = last
	print("test")
	var enemy = ENEMY_ENTRANCE.instantiate()
	get_parent().add_child(enemy)
	enemy.position = end_seg.global_position
	enemy.rotation = end_seg.global_rotation
	var pin = PinJoint2D.new()
	pin.name = "PinJoint2D"
	enemy.add_child(pin)
	pin.set_node_a(end_seg.get_path())
	pin.set_node_b(enemy.get_path())
	
	#var end = segment_res.instantiate()
	#add_child(end)
	#end.position.y = -height*(grass_length-1) - height/2
	#var pj = end.get_node("PinJoint2D")
	#pj.set_node_a(last.get_path())
	#pj.set_node_b(end.get_path())

func _physics_process(delta):
	if reel_in:
		velocity += Vector2(0,-reel_acc*delta)
		position += velocity*delta
		
		if position.y < - 800:
			queue_free()
		pass
	pass

func trigger_reel():
	reel_in = true
	pass
