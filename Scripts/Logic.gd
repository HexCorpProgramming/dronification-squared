extends Node
# This is the main node for all mathematics calculations.

#Resources
var drones_literal: float = 0
var drones_rounded: int = 0
var recruits_literal = 0 
var recruits_rounded = 0
var money = 0
var materials = 0
var science = 0

#Producers
var auto_recruiters = 0 #Recruits... Recruits
var conversion_chambers = 0 #Converts drones 
var assigned_drones = 0 #Gather materials

#Constants
var recruits_per_second = 0.25
var materials_per_drone_per_second = 0.25
var conversions_per_second = 0

#Timer
onready var tick = get_node("Tick")

func _ready():
	drones_literal = 0
	drones_rounded = 0
	recruits_literal = 0
	recruits_rounded = 0
	money = 0
	materials = 0
	science = 0
	
	auto_recruiters = 0
	conversion_chambers = 0
	assigned_drones = 0
	
	#Start ticking the timer.
	tick.connect("timeout",self,"tick")
	tick.start()
	
func tick():
	#Every tick, add resources relative to the amount of producers.
	recruits_literal += (recruits_per_second * auto_recruiters)
	recruits_rounded = int(round(recruits_literal))
	
	materials += (materials_per_drone_per_second * assigned_drones)