extends Node2D

export var nutrition = 10

func eaten():
	return nutrition <= 0

func bite(amount):
	nutrition = nutrition - amount