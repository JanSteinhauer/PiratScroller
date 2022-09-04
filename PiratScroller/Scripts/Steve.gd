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

onready var animPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_vars = get_node("/root/PlayerVariables")
	curHp = player_vars.health
	ui.update_health_bar (curHp, maxHp) #b
	animPlayer.play("modelsrigAction")
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
	
	var dir_x = get_transform().basis.x
	var dir_z = get_transform().basis.z
	velocity = Vector3(0,0,0)
	
	if Input.is_action_pressed("ui_up"):
		velocity += dir_z * -SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity += dir_z * SPEED
		
	if Input.is_action_pressed("ui_right"):
		#velocity += dir_z * SPEED
		rotate_object_local(Vector3(0,1,0), deg2rad(-1))
	elif Input.is_action_pressed("ui_left"):
		#velocity = dir_z * -SPEED 
		rotate_object_local(Vector3(0,1,0), deg2rad(1))
		
	move_and_slide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
