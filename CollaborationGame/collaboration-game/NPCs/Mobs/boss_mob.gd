extends Node2D

class_name boss_mob

const ADDITIVE_BOSS_HEALTH_BONUS = 200
var multiplicative_boss_health_bonus
const MBHL = 1.5
const MBHH = 2.5

# if a mob is a projector mob, the projector function needs to be overwritten
# to include a change to the mob's projectiles' damage each time they are cast
# special attacks will be unaffected by this and they will have their own 
# damage and size and the like
var size_change_multiplier
var stat_change_multiplier
const SCML = 2.0
const SCMH = 3.0

# is the parent mob (this will be attached to the mob)
var base_mob

var boss_attack_node

func _ready():
	pass

func set_up_boss():
	base_mob = get_parent()
	set_boss_stats()

func set_boss_stats():
	multiplicative_boss_health_bonus = GlobalRandomNumberGenerator.rng.randf_range(MBHL, MBHH)
	size_change_multiplier = GlobalRandomNumberGenerator.rng.randf_range(SCML, SCMH)
	stat_change_multiplier = GlobalRandomNumberGenerator.rng.randf_range(SCML, SCMH)
	base_mob.health *= multiplicative_boss_health_bonus
	base_mob.health += ADDITIVE_BOSS_HEALTH_BONUS
	base_mob.scale *= size_change_multiplier
	base_mob.contact_damage *= stat_change_multiplier
	base_mob.move_speed *= (stat_change_multiplier / 2.0)
	if base_mob is projector_mob:
		base_mob.damage_edit *= stat_change_multiplier
		base_mob.scale_edit = size_change_multiplier
		base_mob.projectile_speed_edit = stat_change_multiplier * 2
	if base_mob is hopping_mob:
		base_mob.ordinary_move_speed *= stat_change_multiplier
