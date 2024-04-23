extends Node2D

var trigger = false

@onready var smoke = $Smoke

@onready var fire = $Fire
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func shot_trigger():
	smoke.modulate = Color(smoke.modulate,1)
	smoke.scale = Vector2(.2,.2)
	fire.modulate = Color(fire.modulate,1)
	fire.scale = Vector2(.4,.4)
	audio_stream_player_2d.play()
	create_tween().tween_property(smoke,"modulate",Color(smoke.modulate,0),1)
	create_tween().tween_property(smoke,"scale",Vector2(.5,.5),1)
	
	create_tween().tween_property(fire,"modulate",Color(fire.modulate,0),.5)
	create_tween().tween_property(fire,"scale",Vector2(.1,.1),.5)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
