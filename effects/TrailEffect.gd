extends Line2D
signal finished()

export var max_length = 50
var point = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_as_toplevel(true)

func _process(delta):
	self.global_position = Vector2.ZERO
	self.global_rotation = 0
	
	self.point = self.get_parent().global_position
	
	add_point(self.point)
	
	if self.get_point_count() > self.max_length:
		self.remove_point(0)
		if self.get_point_count() == 0:
			self.emit_signal("finished")
