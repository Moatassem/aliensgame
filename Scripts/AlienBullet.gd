extends Node2D

export var mytype: String = "alienBullet"
export var hitDamage: int = 20


var bulletSpeed=300
onready var gameManager = get_parent()

func lookAtHero():
	var charPos = get_parent().get_node("Character/CharacterPosition").get_global_position()
	look_at(charPos)

func _ready():
	lookAtHero()

func _process(delta):
	position += transform.x*delta*bulletSpeed
	if gameManager.is_outside_screen(position):
		#print("AlienBullet is outside the screen")
		queue_free()

func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if "hitDamage" in self and parent.is_in_group("Character"):
		parent.Hit(self.hitDamage)
		queue_free()
	#if parent.is_in_group("Character"):
		#parent.Hit(20)
	#elif area.get_parent().name.find("Bullet") > -1:
	elif "mytype" in parent and parent.mytype == "heroBullet":
		queue_free()
