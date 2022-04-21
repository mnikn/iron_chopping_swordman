extends KinematicBody2D

export var SPEED = 10
const ATTACK_SPPED = 25

var velocity = Vector2.ZERO
var direction = "down" setget set_direction

func _process(delta):
#	if self.attacking:
#		self.move_and_collide(self.velocity)
#		return
#
#	if Input.get_action_strength("player_move_down") > 0:
#		if $AnimationPlayer.current_animation != "move_down":
#			$AnimationPlayer.play("move_down")
#			self.direction = "down"
#		self.velocity = Vector2(0, SPEED)
#	elif Input.get_action_strength("player_move_up") > 0:
#		if $AnimationPlayer.current_animation != "move_up":
#			$AnimationPlayer.play("move_up")
#			self.direction = "up"
#		self.velocity = Vector2(0, -SPEED)
#	elif Input.get_action_strength("player_move_left") > 0:
#		$AnimationPlayer.play("move_left")
#		self.direction = "left"
#		self.velocity = Vector2(-SPEED, 0)
#	elif Input.get_action_strength("player_move_right") > 0:
#		$AnimationPlayer.play("move_right")
#		self.direction = "right"
#		self.velocity = Vector2(SPEED, 0)
#	else:
#		$AnimationPlayer.play("idle_" + self.direction)
#		self.velocity = Vector2.ZERO
	if self.velocity == Vector2.ZERO:
		$AnimationPlayer.play("idle_" + self.direction)
	self.move_and_collide(self.velocity)

func set_direction(val):
	direction = val
	$Sprite.flip_h = val == "right"
