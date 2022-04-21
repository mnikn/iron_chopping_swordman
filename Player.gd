extends KinematicBody2D

const FRICTION = 2000
const SPEED = 600
const ACCELERATION = SPEED
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
		self.collision_mask = 0
		yield(tween, "tween_all_completed")
		yield($AnimationPlayer, "animation_finished")
		yield(self.get_tree().create_timer(0.03), "timeout")
		self.velocity = Vector2.ZERO
		yield(self.get_tree().create_timer(0.07), "timeout")
		self.attacking = false
		self.collision_mask = 5
		tween.queue_free()

func _process(delta):
	if self.attacking:
		self.move_and_collide(self.velocity)
		return

	var input_vel = Vector2.ZERO
	input_vel.y = Input.get_action_strength("player_move_down") - Input.get_action_strength("player_move_up")
	input_vel.x = Input.get_action_strength("player_move_right") - Input.get_action_strength("player_move_left")
	input_vel = input_vel.normalized()
	
	if input_vel != Vector2.ZERO:
		self.velocity += input_vel * ACCELERATION * delta
		self.velocity = velocity.clamped(SPEED * delta)
		if input_vel.y < 0:
			$AnimationPlayer.play("move_up")
			self.direction = "up"
		elif input_vel.y > 0:
			$AnimationPlayer.play("move_down")
			self.direction = "down"
		elif input_vel.x < 0:
			$AnimationPlayer.play("move_left")
			self.direction = "left"
		elif input_vel.x > 0:
			$AnimationPlayer.play("move_right")
			self.direction = "right"
	else:
		self.velocity = self.velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		$AnimationPlayer.play("idle_" + self.direction)
	self.move_and_collide(self.velocity)

func set_direction(val):
	direction = val
	$Sprite.flip_h = val == "right"
