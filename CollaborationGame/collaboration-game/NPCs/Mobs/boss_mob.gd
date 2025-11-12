extends mob

class_name boss_mob

const ADDITIVE_BOSS_HEALTH_BONUS = 200
var multiplicative_boss_health_bonus
const MHBL = 1.5
const MHBH = 2.5

# if a mob is a projector mob, the projector function needs to be overwritten
# to include a change to the mob's projectiles' damage each time they are cast
# special attacks will be unaffected by this and they will have their own 
# damage and size and the like
var size_change_multiplier
var stat_change_multiplier
const SCML = 2.0
const SCMH = 3.0

func _ready():
	super()
	multiplicative_boss_health_bonus = GlobalRandomNumberGenerator.rng.randf_range(MHBL, MHBH)
	size_change_multiplier = GlobalRandomNumberGenerator.rng.randf_range(SCML, SCMH)
	stat_change_multiplier = GlobalRandomNumberGenerator.rng.randf_range(SCML, SCMH)
	health *= multiplicative_boss_health_bonus
	health += ADDITIVE_BOSS_HEALTH_BONUS
	scale *= size_change_multiplier
	contact_damage *= stat_change_multiplier
	move_speed *= (stat_change_multiplier / 2.0)
