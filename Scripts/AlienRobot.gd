extends Node2D

var missileHit = 0.3 #out of 100% = 1
export var hitDamage: int = 40

export var speed = 15
var health = 100
var isDead = false
export var startPosition = Vector2(0, 0)

onready var animation = get_node("AnimatedSprite")
onready var gameManager = get_parent()

onready var bulletScene = preload("res://Scenes/AlienBullet.tscn")
onready var missileScene = preload("res://Scenes/Missile.tscn")
onready var bulletPosition = get_node("AlienBulletPosition")

func _ready():
	animation.play("Run")
	yield(get_tree().create_timer(0.05), "timeout")
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
			var _1 = get_tree().change_scene("res://Scenes/ResultScene.tscn")
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
	yield(get_tree().create_timer(3), "timeout")
	animation.play("Run")
	isDead = false
	visible = true
	shoot()

func shoot():
	while not isDead and visible:
		var pos = bulletPosition.get_global_position()
		var projectile
		if checkProjectile():
			projectile = missileScene.instance()
		else:
			projectile = bulletScene.instance()
		projectile.position = pos
		#print(bullet.position)
		get_parent().add_child(projectile)
		$ShootSound.play()
		yield(get_tree().create_timer(rand_range(3, 10)), "timeout")

func checkProjectile() -> bool:
	return randf() <= missileHit
	

func hit():
	if isDead:
		return
	health -= 25
	gameManager.increaseScore()
	$AnimationPlayer.play("Hit")
	$HitSound.play()
	animation.modulate.a = 0.5
	yield(get_tree().create_timer(0.3), "timeout")
	animation.modulate.a = 1
