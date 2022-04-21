extends KinematicBody2D

export var MAX_SPEED = 950
export var ACCELERATION = INF
export var FRICTION = INF

var velocity = Vector2.ZERO
var direction = "down" setget set_direction

onready var AnimationState = $AnimationTree.get("parameters/playback")

func _process(delta):
	var input_vel = self.get_input_velocity()
	
	if input_vel != Vector2.ZERO:
		$AnimationTree.set("parameters/idle/blend_position", input_vel)
		$AnimationTree.set("parameters/move/blend_position", input_vel)
		self.AnimationState.travel("move")
		self.velocity = velocity.move_toward(input_vel * MAX_SPEED, ACCELERATION * delta)
	else:
		self.AnimationState.travel("idle")
		self.velocity = self.velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	self.move_and_slide(self.velocity)

func get_input_velocity():
	return Vector2.ZERO
	
func play_animation(animation):
	$AnimationPlayer.play(animation)

func set_direction(val):
	direction = val
	$Sprite.flip_h = val == "right"
