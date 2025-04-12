extends Node2D

const maxCityLives = 5
const maxHealth = 200


var score=0
var currentCityLives = maxCityLives
var currentHealth = maxHealth

onready var livesBar = get_node("Score/LivesText")
onready var scoreBar = get_node("Score/ScoreText")
onready var healthBar = get_node("Score/HealthText")

func _ready():
	scoreBar.text = "Score " + str(score)
	livesBar.text = "Lives " + str(currentCityLives)
	healthBar.text = "Health " + str(currentHealth)
	
	
func increaseScore():
	score+=10
	scoreBar.text = "Score " + str(score)

func decreaseLives():
	currentCityLives -= 1
	if currentCityLives <= maxCityLives/2:
		livesBar.set("custom_colors/default_color", Color(1, 0, 0))
	livesBar.text = "Lives " + str(currentCityLives)
	return currentCityLives <= 0

func decreaseCharacterHealth():
	currentHealth -= 20
	if currentHealth <= maxHealth/4:
		healthBar.set("custom_colors/default_color", Color(1, 0, 0))
	healthBar.text = "Health " + str(currentHealth)
	return currentHealth <= 0

func is_outside_screen(position: Vector2) -> bool:
	var viewport_size = get_viewport().size
	return position.x < 0 or position.x > viewport_size.x or position.y < 0 or position.y > viewport_size.y

func is_inside_screen(position: Vector2) -> bool:
	#print(position)
	var viewport_size = get_viewport().size
	#print(viewport_size)
	var delta = 10
	var value = position.y > delta and position.y < viewport_size.y - delta
	print(value)
	return value

