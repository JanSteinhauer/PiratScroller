extends Navigation


const SPEED = 10.0

var path = []

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ship  = get_node("../Ship")
onready var camera = get_node("../Camera")


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)


func _physics_process(delta):
	var direction = Vector3()

	# We need to scale the movement speed by how much delta has passed,
	# otherwise the motion won't be smooth.
	var step_size = delta * SPEED

	if path.size() > 0:
		# Direction is the difference between where we are now
		# and where we want to go.
		var destination = path[0]
		direction = destination - ship.translation

		# If the next node is closer than we intend to 'step', then
		# take a smaller step. Otherwise we would go past it and
		# potentially go through a wall or over a cliff edge!
		if step_size > direction.length():
			step_size = direction.length()
			# We should also remove this node since we're about to reach it.
			path.remove(0)

		ship.translation += direction.normalized() * step_size
		
		direction.y = 0
		if direction:
			var look_at_point = ship.translation + direction.normalized()
			ship.look_at(look_at_point, Vector3.UP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 1000
		var target_point = get_closest_point_to_segment(from, to)

		path = get_simple_path(ship.translation, target_point, true)
