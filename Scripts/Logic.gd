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
var available_drones = 0 #Not for much longer 
var assigned_drones_materials = 0 #Gather materials
var assigned_drones_money = 0 #Gather money
var assigned_drones_science = 0 #Gather science

#Constants
var recruits_per_second = 0.25
var resources_per_drone_per_second = 0.25
var conversions_per_second = 0.25

#Timer
onready var timer = get_node("Timer")

func _ready():
	drones_literal = 0
	drones_rounded = 0
	recruits_literal = 0
	recruits_rounded = 0
	money = 0
	materials = 0
	science = 0
	
	auto_recruiters = 0
	conversion_chambers = 1 # Remember, first one's free :]
	assigned_drones_materials = 0
	assigned_drones_money = 0
	assigned_drones_science = 0
	
	#Start ticking the timer.
	timer.connect("timeout",self,"tick")
	timer.start()
	
	
	#Use ceil for recruit rounding, and floor for drone rounding
	#Makes the conversions look better in the UI :>

func tick():
	#Every tick, add resources relative to the amount of producers.
	recruits_literal += (recruits_per_second * auto_recruiters)
	recruits_rounded = int(ceil(recruits_literal))
	
	#Only do this if doing a recruit wont make the recruit resource go negative
	var converted = (conversions_per_second * conversion_chambers)
	if (recruits_literal-converted) >= 0:
		drones_literal += converted
		recruits_literal -= converted # Take out of recruit resource
		drones_rounded = int(floor(drones_literal))
		recruits_rounded = int(ceil(recruits_literal))
	
	#Resource production
	materials += (resources_per_drone_per_second * assigned_drones_materials)
	money += (resources_per_drone_per_second * assigned_drones_money)
	science += (resources_per_drone_per_second * assigned_drones_science)
	
	# Update the amount of availible drones
	available_drones = drones_rounded - (assigned_drones_materials + assigned_drones_money + assigned_drones_science)
	
func add_recruits(amnt):
	recruits_literal += amnt
	recruits_rounded = int(ceil(recruits_literal))
