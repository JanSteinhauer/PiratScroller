extends Navigation


const SPEED = 10.0

var path = []

export var islandDistance = 2.5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ship  = get_node("../Ship")
onready var camera = get_node("../Camera")
onready var ui = get_node("../Interface")

var lastPressedPosition = Vector3(0,0,0)
var lastEventPosition = Vector2(0,0)
var lastSelectedIsland = null
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)


func _process(delta):
	ui.update_coin_text()
	ui.update_health_bar()
	
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
			
	var space_state = get_world().direct_space_state
	# use global coordinates, not local to node
	var to = lastPressedPosition + camera.project_ray_normal(lastEventPosition) * 1000
	var result = space_state.intersect_ray(lastPressedPosition, to)
	if result:
		print("Hit at point: ", result.position)
		lastSelectedIsland = result.collider
	if  lastSelectedIsland != null:
		print((lastSelectedIsland.translation - ship.translation).length())
		if (lastSelectedIsland.translation - ship.translation).length() < islandDistance:
			lastSelectedIsland.dispatchLoadUI()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * 1000
		lastEventPosition  = event.position
		var target_point = get_closest_point_to_segment(from, to)

		path = get_simple_path(ship.translation, target_point, true)
		
		lastPressedPosition = from
		lastSelectedIsland = null
		

