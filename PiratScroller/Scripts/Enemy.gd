extends KinematicBody

var path=[]

var speed = 2
export var offset = Vector3(0,-1,0)


var currentnode = 1
var x = Vector3(1,0,0)
onready var nav = $"../Navigation" as Navigation
onready var player = $"../Player" as KinematicBody
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#path  = nav.get_simple_path(global_transform.origin, player.global_transform.origin)# Replace with function body.
	#print(path)
	#print(global_transform.origin)
	#print(player.global_transform.origin)


func _process(delta):
	path  = nav.get_simple_path(global_transform.origin, player.global_transform.origin)# Replace with function body.
	#print(path)
	#print(global_transform.origin)
	#print(player.global_transform.origin)
	
	
func _physics_process(delta):
	
	update_path(player.global_transform.origin)
	
	if currentnode < path.size():
		#print("ich werde ausgefuhrt")
		#print(path)
		print(path[currentnode] ,"currentnode" , global_transform.origin, "global transform org")
		var direction: Vector3 = path[currentnode] - (global_transform.origin + offset)
		move_and_slide(direction)
			
			
func update_path(target_position):
	
	path = nav.get_simple_path(global_transform.origin, target_position)
	currentnode = 1
	#print("traget ", target_position, "global ", global_transform.origin)

