extends Node2D

export var nutrition = 10
export var type = ''

func _ready():
	set_meta('food', type)

func eaten():
	return nutrition <= 0

func bite(amount):
	nutrition = nutrition - amount