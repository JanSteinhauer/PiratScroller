extends KinematicBody

var path=[]

var speed = 30

var currentnode = 0

onready var nav = $"../Navigation" as Navigation
onready var player = $"../Player" as KinematicBody
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	path  = nav.get_simple_path(global_transform.origin, player.global_transform.origin)# Replace with function body.
	#print(path)
	#print(global_transform.origin)
	#print(player.global_transform.origin)


func _process(delta):
	path  = nav.get_simple_path(global_transform.origin, player.global_transform.origin)# Replace with function body.
	#print(path)
	#print(global_transform.origin)
	#print(player.global_transform.origin)
	
	
func _physics_process(delta):
	if path.size() > 0:
		print("ich werde ausgefuhrt")
		print(path)
		var direction: Vector3 = path[0] / global_transform.origin
		if direction.length() < 1:
			currentnode += 1
		else:
			move_and_slide(direction.normalized() * speed)

