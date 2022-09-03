extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector3.ZERO
const SPEED = 6

var curHp : int = 75
var maxHp : int = 100
var coinCounter : int = 8


onready var ui = get_node("../Interface") #b
# Called when the node enters the scene tree for the first time.
func _ready():
	ui.update_health_bar (curHp, maxHp) #b
	#ui.update_coin_text (coinCounter) #b

func take_damage (damage): #b
	
	
	curHp -= damage #b
	ui.update_health_bar(curHp, maxHp) #b
	
	if curHp <= 0: #b
		die() #b

func die(): #b
	
	pass #b

func add_coins (amount): #b
	
	coinCounter += amount #b
	ui.update_coin_text(coinCounter)#b

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.z = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.z = -SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.z = SPEED
	else:
		velocity.z = lerp(velocity.z,0,0.1)
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED 
	else:
		velocity.x = lerp(velocity.x,0,0.1)
		
	move_and_slide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
