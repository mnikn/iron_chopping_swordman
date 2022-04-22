extends Line2D
signal finished()

export var max_length = 50

var tick = 0
const STEP = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_as_toplevel(true)
	self.global_position = Vector2.ZERO
	self.global_rotation = 0

func _process(delta):
	if not self.get_parent().global_position in self.points:
		var point = self.get_parent().global_position
		add_point(point)	
	
	tick += 1
	if tick % STEP == 0:
		self.remove_point(0)

