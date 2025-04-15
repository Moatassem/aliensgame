extends Node2D

export var mytype: String = "alienMissile"
export var hitDamage: int = 50

var missileSpeed=200
onready var gameManager = get_parent()

func lookAtHero():
	var charPos = get_parent().get_node("Character/CharacterPosition").get_global_position()
	look_at(charPos)

func _ready():
	lookAtHero()

func _process(delta):
	lookAtHero()
	position += transform.x*delta*missileSpeed
	if gameManager.is_outside_screen(position):
		queue_free()

func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if "hitDamage" in self and parent.is_in_group("Character"):
		parent.Hit(self.hitDamage)
		queue_free()
	#if parent.is_in_group("Character"):
		#parent.Hit(50)
	elif "mytype" in parent and parent.mytype == "heroBullet":
		queue_free()
