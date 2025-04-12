extends Node2D

var bulletSpeed=100
onready var gameManager = get_parent()

func _ready():
	var charPos = get_parent().get_node("Character/CharacterPosition").get_global_position()
	look_at(charPos)
	#yield(get_tree().create_timer(4),"timeout")
	#queue_free()

func _process(delta):
	position += transform.x*delta*bulletSpeed
	if gameManager.is_outside_screen(position):
		#print("AlienBullet is outside the screen")
		queue_free()

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("Character"):
		queue_free()
		area.get_parent().hit()
