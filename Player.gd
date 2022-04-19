extends KinematicBody2D

const SPEED = 10

var velocity = Vector2.ZERO
var direction = "down" setget set_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if Input.get_action_strength("player_move_down") > 0:
		if $AnimationPlayer.current_animation != "move_down":
			$AnimationPlayer.play("move_down")
			self.direction = "down"
		self.velocity = Vector2(0, SPEED)
#		self.global_position.y += SPEED
	elif Input.get_action_strength("player_move_up") > 0:
		if $AnimationPlayer.current_animation != "move_up":
			$AnimationPlayer.play("move_up")
			self.direction = "up"
		self.velocity = Vector2(0, -SPEED)
#		self.global_position.y -= SPEED
	elif Input.get_action_strength("player_move_left") > 0:
		$AnimationPlayer.play("move_left")
		self.direction = "left"
		self.velocity = Vector2(-SPEED, 0)
#		self.global_position.x -= SPEED
	elif Input.get_action_strength("player_move_right") > 0:
		$AnimationPlayer.play("move_right")
		self.direction = "right"
		self.velocity = Vector2(SPEED, 0)
#		self.global_position.x += SPEED
	else:
		$AnimationPlayer.play("idle_" + self.direction)
		self.velocity = Vector2.ZERO
	self.move_and_collide(self.velocity)

func set_direction(val):
	direction = val
	$Sprite.flip_h = val == "right"
