extends KinematicBody

var path=[]

export var health = 100

export var speed = 2
export var offset = Vector3(0,-1,0)
export var attackRange = 4
export var damage = 5
export var attackTime = 1000
export var coinLoot = 1

var currentnode = 1
var x = Vector3(1,0,0)
onready var nav = $"../Navigation" as Navigation
onready var player = $"../Player" as KinematicBody


var lastAttackTime 

func _ready():
	add_to_group("Enemy")
	lastAttackTime = Time.get_ticks_msec()
	var player_vars = get_node("/root/PlayerVariables")
	player_vars.enemyCounter += 1

func receiveDamage(damage):
	health -= damage
	if health <= 0:
		var player_vars = get_node("/root/PlayerVariables")
		player_vars.coins += coinLoot
		player_vars.enemyCounter -= 1
		if player_vars.enemyCounter == 0:
			get_tree().change_scene("res://Scenes/islandMap.tscn")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		queue_free()

func _process(delta):
	path  = nav.get_simple_path(global_transform.origin, player.global_transform.origin)# Replace with function body.
	
	
func _physics_process(delta):
	
	var diff = player.global_transform.origin - global_transform.origin
	if diff.length() < attackRange && Time.get_ticks_msec() - lastAttackTime > attackTime:
		player.take_damage(damage)
		lastAttackTime = Time.get_ticks_msec()
		return
	
	update_path(player.global_transform.origin)
	if path.size() > 1:
		#print(path[currentnode] ,"currentnode" , global_transform.origin, "global transform org")
		var direction: Vector3 = path[1] - (global_transform.origin + offset)
		direction = direction.normalized() * speed
		var lookRotation = player.global_transform.origin - global_transform.origin
		lookRotation.y = 0
		look_at(global_transform.origin + lookRotation.normalized(),Vector3.UP)
		move_and_slide(direction)
	
	
func update_path(target_position):
	path = nav.get_simple_path(global_transform.origin, target_position)
