extends "res://characters/Character.gd"

var TrailEffectScene = preload("res://effects/TrailEffect.tscn")

export var ATTACK_SPEED = 2000
var origin_max_speed = MAX_SPEED

func _ready():
	self.collision_layer = 1

func get_input_velocity():
	var input_vel = Vector2.ZERO
	input_vel.y = Input.get_action_strength("player_move_down") - Input.get_action_strength("player_move_up")
	input_vel.x = Input.get_action_strength("player_move_right") - Input.get_action_strength("player_move_left")
	input_vel = input_vel.normalized()
	
	
#	if Input.is_action_pressed("player_attack"):
#		input_vel = Vector2(ATTACK_SPEED, 0)
#		MAX_SPEED = ATTACK_SPEED
#	if self.velocity == Vector2.ZERO:
#		MAX_SPEED = origin_max_speed
	
	return input_vel
	

func _input(event):
	if event.is_action_pressed("player_attack"):
		var effect = self.TrailEffectScene.instance()
		effect.name = "TrailEffect"
		$Sprite.add_child(effect)
		
		$AnimationPlayer.play("attack_{direction}_finished".format({ "direction": self.direction }))
		
#		var tween = Tween.new()
#		var new_vel = Vector2.ZERO
#		if self.direction == "down":
#			new_vel = Vector2(0, ATTACK_SPEED)
#			$AnimationPlayer.play("attack_down")
#		elif self.direction == "up":
#			new_vel = Vector2(0, -ATTACK_SPEED)
#			$AnimationPlayer.play("attack_up")
#		elif self.direction == "left":
#			new_vel = Vector2(-ATTACK_SPEED, 0)
#			$AnimationPlayer.play("attack_left")
#		else:
#			new_vel = Vector2(ATTACK_SPEED, 0)
#			$AnimationPlayer.play("attack_right")
#		tween.interpolate_property(self, "velocity", self.velocity, new_vel, 0.15, Tween.TRANS_BOUNCE)
#		self.add_child(tween)
#		tween.start()
#		self.attacking = true
#		self.collision_mask = 0
#		yield(tween, "tween_all_completed")
#		yield($AnimationPlayer, "animation_finished")
#		yield(self.get_tree().create_timer(0.03), "timeout")
#		self.velocity = Vector2.ZERO
#		yield(self.get_tree().create_timer(0.07), "timeout")
#		self.attacking = false
#		self.collision_mask = 5
#		yield(self.get_tree().create_timer(1), "timeout")
#		effect.queue_free()
#		tween.queue_free()
