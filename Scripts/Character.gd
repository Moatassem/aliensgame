extends Node2D

onready var animatedSprite=get_node("AnimatedSprite")
var bulletScene=preload("res://Scenes/Bullet.tscn")
onready var bulletPosition=get_node("BulletPosition")
var isShooting=false

func _ready():
	animatedSprite.play("Fly")

# warning-ignore:unused_argument
func _process(delta):
	var mousePos=get_global_mouse_position()
	if position.x<mousePos.x:
		look_at(mousePos)
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if isShooting==false:
			Shoot()
	
			
	if Input.is_key_pressed(KEY_W):
		translate(Vector2(0,-1))
	if Input.is_key_pressed(KEY_S):
		translate(Vector2(0,1))
		
			
	if Input.is_key_pressed(KEY_UP):
		translate(Vector2(0,-1))
	if Input.is_key_pressed(KEY_DOWN):
		translate(Vector2(0,1))
	

func _on_AnimatedSprite_animation_finished():
	animatedSprite.play("Fly")



func Shoot():
	animatedSprite.play("Shoot")	
	$AudioStreamPlayer2D.play()
	var bullet=bulletScene.instance()
	bullet.position=bulletPosition.get_global_position()
	get_parent().add_child(bullet)
	isShooting=true
	
	yield(get_tree().create_timer(0.5),"timeout")
	isShooting=false
