extends "res://characters/Character.gd"

var BulletScene = preload("res://Bullet.tscn")

func _ready():
	yield(self.get_tree().create_timer(1), "timeout")
	self.shoot()


func shoot():
	var node = self.BulletScene.instance()
	node.set_as_toplevel(true)
	node.global_position = self.global_position
	node.direction = Vector2(0,1)
	self.add_child(node)
