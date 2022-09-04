extends Node

onready var healthBar : TextureProgress = $Hbar
onready var coinCounter : Label =  $Counter/Label

func update_health_bar (curHp, maxHp):
	healthBar.max_value = maxHp
	healthBar.value = curHp
	

#func update_coin_text (coinCounter):
	
	#coinCounter.text =  String(coinCounter)


