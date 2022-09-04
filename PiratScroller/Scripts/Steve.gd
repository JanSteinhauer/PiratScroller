extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector3.ZERO
const SPEED = 10

var curHp : int = 75
var maxHp : int = 100

export var sensitivity = 0.1
export var attackAnimTime = 500
export var attackTime = 250
onready var attackDamage = 5
onready var ui = get_node("../Interface")
onready var trigger = $AreaTrigger as Area

var lastMouse

onready var animPlayer = $AnimationPlayer
var lastAttackTime 

var isAttacking = false
var isWalking = false


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	lastAttackTime = Time.get_ticks_msec()
	ui.update_health_bar () #b
	animPlayer.play("modelsIdle")
	ui.update_coin_text () #b

func take_damage (damage): #b
	var player_vars = get_node("/root/PlayerVariables")
	player_vars.health -= damage
	ui.update_health_bar() #b
	
	if player_vars.health <= 0: #b
		die() #b

func die(): #b
	get_tree().quit()

	
func _process(delta):
	
	ui.update_coin_text()
	
	if  Time.get_ticks_msec() - lastAttackTime > attackAnimTime:
		isAttacking = false
		
	if Input.is_action_pressed("attack") && Time.get_ticks_msec() - lastAttackTime > attackTime:
		lastAttackTime = Time.get_ticks_msec()
		isAttacking = true
		updateAnimation()
		var bodies = trigger.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("Enemy"):
				body.receiveDamage(attackDamage)
	

func updateAnimation():
	if isAttacking:
		animPlayer.play("modelsAttack")
		return
	if isWalking:
		animPlayer.play("modelsrigAction")
	else:
		animPlayer.play("modelsIdle")
	

func _physics_process(delta):
	
	var dir_x = get_transform().basis.x
	var dir_z = get_transform().basis.z
	velocity = Vector3(0,0,0)
	var movSpeed = SPEED
	if isAttacking:
		movSpeed *= 0.5
	
	if Input.is_action_pressed("ui_up"):
		velocity += dir_z * -movSpeed
	elif Input.is_action_pressed("ui_down"):
		velocity += dir_z * movSpeed
		
		
	if Input.is_action_pressed("ui_right"):
		velocity += dir_x * movSpeed
	elif Input.is_action_pressed("ui_left"):
		velocity += dir_x * -movSpeed
	
	isWalking = velocity.length() > 0
	updateAnimation()	
	move_and_slide(velocity)
	
func _input(event):         
	if event is InputEventMouseMotion:
		print(event.relative.x)
		rotate_object_local(Vector3(0,1,0), deg2rad(-event.relative.x* sensitivity))
		
