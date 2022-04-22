extends "res://characters/Character.gd"

var TrailEffectScene = preload("res://effects/TrailEffect.tscn")

#var origin_max_speed = MAX_SPEED

export var ATTACK_SPEED = 3500
export var ATTACK_MAX_TIME = 0.15

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
	
	self.clear_trail_effect()

func _input(event):
	if event.is_action_pressed("player_attack"):
		var effect = self.TrailEffectScene.instance()
		effect.name = "TrailEffect"
		self.attacking = true
		$Sprite.add_child(effect)

func set_attacking(val):
	attacking = val
	self.clear_trail_effect()
	

func clear_trail_effect():
	for node in $Sprite.get_children():
		if "TrailEffect" in node.name:
			var effect = node
			if effect.get_point_count() == 0 and effect.tick != 0:
				effect.queue_free()
