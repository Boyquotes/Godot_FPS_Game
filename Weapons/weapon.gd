extends Spatial
class_name Weapon

# References
var weapon_manager = null
var player = null
var animation_player

# Weapon States
var is_equipped = false
var is_firing = false
var is_reloading = false

# Weapon Parameters
export var weapon_name = "Weapon"

# Functionality
export var equip_speed = 1.0

func equip():
	animation_player.play("Equip", -1.0, equip_speed)
	update_ammo()
	

func unequip():
	animation_player.play("Unequip", -1.0, equip_speed)
	
func is_equip_finished():
	if is_equipped:
		return true
	return false
func is_unequip_finished():
	if is_equipped:
		return false
	
# Animation finished
func on_animation_finish(anim_name):
	match anim_name:
		"Unequip":
			is_equipped = false
		"Equip":
			is_equipped = true
			
# Update Ammo
func update_ammo(action = "Refresh"):
	var weapon_data = {
		"Name" : weapon_name
	}
	
	# weapon_manager.update_hud(weapon_data)
