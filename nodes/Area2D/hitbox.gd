@icon("hitbox.svg")
class_name HitBox
extends Area2D


enum Faction {
	PLAYER,
	ENEMY,
	NEUTRAL
}

signal entered_hurtbox(hurtbox: HurtBox)

@export var damage_amount := 1.0
@export var faction : Faction = Faction.ENEMY


func _on_area_entered(area: Area2D) -> void:
	if not (area is HurtBox):
		return

	var hurtbox = area

	if hurtbox.get_faction() == faction:
		return

	hurtbox.hurt(damage_amount)
	entered_hurtbox.emit(area)
