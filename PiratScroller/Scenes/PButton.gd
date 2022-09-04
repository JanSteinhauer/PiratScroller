extends Button


onready var ui = get_node("../../Interface")



# Called when the node enters the scene tree for the first time.
func _ready():
	
	ui.update_health_bar ()
	ui.update_coin_text ()

func _pressed():
	var player_vars = get_node("/root/PlayerVariables")
	
	if player_vars.coins > 0 :
		
		player_vars.power += .5
		player_vars.coins -= 1
		
		
	
	
	ui.update_coin_text ()

