@icon("hurtbox.svg")
class_name HurtBox
extends Area2D


signal hurt_for(amount: float)

@export var health : Health
@export var faction : HitBox.Faction = HitBox.Faction.ENEMY


func hurt(amount: float) -> void:
	hurt_for.emit(amount)


func get_faction() -> int:
	return faction
