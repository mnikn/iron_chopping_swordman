extends KinematicBody2D

export var FRICTION = 2000
export var SPEED = 600
export var ACCELERATION = 600

var velocity = Vector2.ZERO
var direction = "down" setget set_direction

var BulletScene = preload("res://Bullet.tscn")

func _ready():
	yield(self.get_tree().create_timer(1), "timeout")
	self.shoot()

func _process(delta):
	var input_vel =self.get_input_velocity()
	
	if input_vel != Vector2.ZERO:
		self.velocity += input_vel * ACCELERATION * delta
		self.velocity = velocity.clamped(SPEED * delta)
		if self.velocity.y < 0:
			$AnimationPlayer.play("move_up")
			self.direction = "up"
		elif self.velocity.y > 0:
			$AnimationPlayer.play("move_down")
			self.direction = "down"
		elif self.velocity.x < 0:
			$AnimationPlayer.play("move_left")
			self.direction = "left"
		elif self.velocity.x > 0:
			$AnimationPlayer.play("move_right")
			self.direction = "right"
	else:
		self.velocity = self.velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	if self.velocity == Vector2.ZERO:
		$AnimationPlayer.play("idle_" + self.direction)
	self.move_and_collide(self.velocity)

func get_input_velocity():
	return Vector2.ZERO
	
func shoot():
	var node = self.BulletScene.instance()
	node.set_as_toplevel(true)
	node.global_position = self.global_position
	node.direction = Vector2(0,1)
	self.add_child(node)

func set_direction(val):
	direction = val
	$Sprite.flip_h = val == "right"
