extends Spatial


var all_weapons = {} # all weapons in the game
var player_weapons = {} # weapons the player is carrying
var hud # hud
var current_weapon # reference to the player's current weapon
var current_weapon_slot = "Empty" # current weapon slot

var changing_weapon = false
var unequipped_weapon = false

func _ready():
	hud = owner.get_node("HUD")
	all_weapons = {
		"Revolver" : preload("res://Weapons/Revolver.tscn"),
		"Repeater" : preload("res://Weapons/Repeater.tscn"),
	}

	player_weapons = {
		"Primary" : $Revolver,
		"Secondary" : $Repeater,
	}
