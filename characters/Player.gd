extends "res://characters/Character.gd"

var TrailEffectScene = preload("res://effects/TrailEffect.tscn")

#var origin_max_speed = MAX_SPEED

export var ATTACK_SPEED = 5000
export var ATTACK_MAX_TIME = 0.1

var current_attack_time = 0
var attacking = false setget set_attacking

func _ready():
	self.collision_layer = 1

func get_input_velocity():
	var input_vel = Vector2.ZERO
	input_vel.y = Input.get_action_strength("player_move_down") - Input.get_action_strength("player_move_up")
	input_vel.x = Input.get_action_strength("player_move_right") - Input.get_action_strength("player_move_left")
		
	input_vel = input_vel.normalized()
	return input_vel

func _process(delta):
	if self.attacking:
		if self.current_attack_time > ATTACK_MAX_TIME:
			self.current_attack_time = 0
			self.attacking = false
		elif Input.is_action_pressed("player_attack"):
			self.global_position = self.global_position.move_toward(self.get_global_mouse_position(), ATTACK_SPEED * delta)
			self.current_attack_time += delta

func _input(event):
	if event.is_action_pressed("player_attack"):
		var effect = self.TrailEffectScene.instance()
		effect.name = "TrailEffect"
		$Sprite.add_child(effect)
		self.attacking = true

func set_attacking(val):
	attacking = val
	if not val:
		if $Sprite.has_node("TrailEffect"):
			var effect = $Sprite.get_node("TrailEffect")
			effect.queue_free()
