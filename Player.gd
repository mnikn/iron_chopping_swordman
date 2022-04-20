extends KinematicBody2D

const SPEED = 10
const ATTACK_SPPED = 25

var velocity = Vector2.ZERO
var direction = "down" setget set_direction
var attacking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("player_attack"):
		var tween = Tween.new()
		var new_vel = Vector2.ZERO
		if self.direction == "down":
			new_vel = Vector2(0, ATTACK_SPPED)
			$AnimationPlayer.play("attack_down")
		elif self.direction == "up":
			new_vel = Vector2(0, -ATTACK_SPPED)
			$AnimationPlayer.play("attack_up")
		elif self.direction == "left":
			new_vel = Vector2(-ATTACK_SPPED, 0)
			$AnimationPlayer.play("attack_left")
		else:
			new_vel = Vector2(ATTACK_SPPED, 0)
			$AnimationPlayer.play("attack_right")
		tween.interpolate_property(self, "velocity", self.velocity, new_vel, 0.15, Tween.TRANS_BOUNCE)
		self.add_child(tween)
		tween.start()
		self.attacking = true
		yield(tween, "tween_all_completed")
		yield($AnimationPlayer, "animation_finished")
		yield(self.get_tree().create_timer(0.03), "timeout")
		self.velocity = Vector2.ZERO
		yield(self.get_tree().create_timer(0.07), "timeout")
		self.attacking = false
		tween.queue_free()

func _process(delta):
	if self.attacking:
		self.move_and_collide(self.velocity)
		return

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
