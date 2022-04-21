extends Sprite

export var ACCELERATION = 400
export var MAX_SPEED = 600

export var direction = Vector2.ZERO

var velocity = Vector2.ZERO

func _process(delta):
	self.velocity += self.direction * ACCELERATION * delta
	self.velocity = self.velocity.clamped(MAX_SPEED * delta)	
	self.global_position += self.velocity


func _on_Check_body_entered(body):
	self.queue_free()
