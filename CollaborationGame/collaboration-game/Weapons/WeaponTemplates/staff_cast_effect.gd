extends Node2D

class_name staff_effect

enum EFFECT_TYPES {PROJECTILE, AREA, POINT_AREA, BUFF, SPECIAL}

@export var effect_type: EFFECT_TYPES
@export var damage: int
@export var projectile_speed: int
