extends Node2D

const maxCityLives = 5
const maxHealth = 10


var score=0
var currentCityLives = maxCityLives
var currentHealth = maxHealth

onready var livesBar = get_node("Score/LivesText")
onready var scoreBar = get_node("Score/ScoreText")
onready var healthBar = get_node("Score/HealthText")

func _ready():
	scoreBar.text = "Score " + str(score)
	livesBar.text = "Lives " + str(currentCityLives)
	healthBar.text = "Health " + str(currentCityLives)
	
	
func increaseScore():
	score+=10
	scoreBar.text = "Score " + str(score)

func decreaseHealth():
	currentCityLives -= 1
	if currentCityLives <= maxCityLives/2:
		livesBar.set("custom_colors/default_color", Color(1, 0, 0))
	livesBar.text = "Lives " + str(currentCityLives)
	return currentCityLives == 0




