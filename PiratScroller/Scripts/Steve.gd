extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector3.ZERO
const SPEED = 6

var curHp : int = 75
var maxHp : int = 100

export var attackTime = 100
onready var attackDamage = 5
onready var ui = get_node("../Interface")
onready var trigger = $AreaTrigger as Area

onready var animPlayer = $AnimationPlayer
var lastAttackTime 


# Called when the node enters the scene tree for the first time.
func _ready():
	lastAttackTime = Time.get_ticks_msec()
	ui.update_health_bar () #b
	animPlayer.play("modelsrigAction")
	ui.update_coin_text () #b

func take_damage (damage): #b
	var player_vars = get_node("/root/PlayerVariables")
	player_vars.health -= damage
	ui.update_health_bar() #b
	
	if player_vars.health <= 0: #b
		die() #b

func die(): #b
	
	pass #b

	
func _process(delta):
	
	ui.update_coin_text()
	if Input.is_action_pressed("attack") && Time.get_ticks_msec() - lastAttackTime > attackTime:
		lastAttackTime = Time.get_ticks_msec()
		var bodies = trigger.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("Enemy"):
				body.receiveDamage(attackDamage)
	

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
