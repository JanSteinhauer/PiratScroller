extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ship  = get_node("../Ship")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var diff = ship.translation + Vector3(0,0,7.5);
	
	diff.y = translation.y;
	translation = lerp(translation, diff, 2* delta)
	
