extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var ui = get_node("../../Interface")



# Called when the node enters the scene tree for the first time.
func _ready():
	
	ui.update_health_bar ()
	ui.update_coin_text ()

func _pressed():
	var player_vars = get_node("/root/PlayerVariables")
	
	if player_vars.coins > 0 && player_vars.health < 100:
		
		player_vars.health += 10
		player_vars.coins -= 1
		
		if player_vars.health >= 100:
		
			player_vars.health = 100
	
	ui.update_health_bar ()
	ui.update_coin_text ()

#func _process(delta):
#	pass
