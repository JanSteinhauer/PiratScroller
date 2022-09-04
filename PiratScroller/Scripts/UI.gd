extends Node

onready var healthBar : TextureProgress = $Hbar
onready var coinCounter : Label =  $Counter/Label

func update_health_bar (curHp, maxHp):
	healthBar.max_value = maxHp
	healthBar.value = curHp
	

func update_coin_text ():
	var player_vars = get_node("/root/PlayerVariables")
	var coins = player_vars.coins
	#coinCounter.text =  String(coinCounter)


