extends Node2D

export var mytype: String = "heroBullet"

var bulletSpeed=300
onready var gameManager = get_parent()

func _ready():
	var mousePos=get_global_mouse_position()
	look_at(mousePos)
	#yield(get_tree().create_timer(4),"timeout")
	#queue_free()

func _process(delta):
	position += transform.x*delta*bulletSpeed
	if gameManager.is_outside_screen(position):
		#print("Bullet is outside the screen")
		queue_free()

func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if parent.is_in_group("Aliens"):
		parent.hit()
		queue_free()
	elif "mytype" in parent and parent.mytype == "alienBullet":
		queue_free()
