extends Node2D

@onready var test_stage = $TestStage
@onready var player = $TestStage/Player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player_death():
	await create_tween().tween_property(player,"modulate",Color(player.modulate,0),4).finished
	get_tree().reload_current_scene()
