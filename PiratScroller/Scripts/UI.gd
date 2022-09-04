extends Node

onready var healthBar : TextureProgress = $Hbar
onready var coinCounter : Label =  $Counter/Label

func _ready():
	update_coin_text()

func update_health_bar ():
	
	var player_vars = get_node("/root/PlayerVariables")
	var health = player_vars.health
	healthBar.max_value = 100
	healthBar.value = health
	

func update_coin_text ():
	var player_vars = get_node("/root/PlayerVariables")
	var coins = player_vars.coins
	coinCounter.text =  String(coins)


