extends Node2D

export var speed = 15
var health = 100
var isDead = false
export var startPosition = Vector2(0, 0)

onready var animation = get_node("AnimatedSprite")
onready var gameManager = get_parent()

var bulletScene = preload("res://Scenes/AlienBullet.tscn")
onready var bulletPosition = get_node("AlienBulletPosition")

func _ready():
	animation.play("Run")
	shoot()

func _process(delta):
	if isDead or not visible:
		return
	if not isDead:
		translate(Vector2(-speed * delta, 0))
	if health <= 0:
		die()
		return
	if position.x <= 39:
		if gameManager.decreaseLives():
			get_tree().change_scene("res://Scenes/ResultScene.tscn")
			return
		reset()

func die():
	isDead = true
	get_node("Damage taken").visible = false
	animation.play("Die")
	$AnimationPlayer.play("Die")
	yield(get_tree().create_timer(1), "timeout")
	reset()

func reset():
	visible = false
	position = startPosition
	health = 100
	visible = true
	yield(get_tree().create_timer(3), "timeout")
	animation.play("Run")
	isDead = false
	shoot()

func shoot():
	while not isDead and visible:
		var bullet = bulletScene.instance()
		bullet.position = bulletPosition.get_global_position()
		get_parent().add_child(bullet)
		yield(get_tree().create_timer(2.5), "timeout")
		

func hit():
	health -= 25
	gameManager.increaseScore()
	$AnimationPlayer.play("Hit")
	$AudioStreamPlayer2D.playing = true
	animation.modulate.a = 0.5
	yield(get_tree().create_timer(0.3), "timeout")
	animation.modulate.a = 1
