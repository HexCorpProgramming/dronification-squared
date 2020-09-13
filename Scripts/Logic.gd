extends Node
# This is the main node for all mathematics calculations.

const RECRUITER_BASE_MATERIAL = 100
const RECRUITER_BASE_MONEY = 400

const CONVERTER_BASE_MATERIAL = 200
const CONVERTER_BASE_MONEY = 100

const RESEARCH_BASE_SCIENCE = 100

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
var conversion_chambers = 1 #Converts drones, first ones free! :)
var available_drones = 0 #Not for much longer 
var assigned_drones_materials = 0 #Gather materials
var assigned_drones_money = 0 #Gather money
var assigned_drones_science = 0 #Gather science

var recruit_upgrades = 0
var convert_upgrades = 0
var materials_upgrades = 0
var money_upgrades = 0
var science_upgrades = 0

#Research modifiers
var recruit_mod = 1.00
var convert_mod = 1.00
var materials_mod = 1.00
var money_mod = 1.00
var science_mod = 1.00

var upgrade_boost = 0.10

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
	recruits_literal += (recruits_per_second * auto_recruiters*recruit_mod)
	recruits_rounded = int(ceil(recruits_literal))
	
	#Only do this if doing a recruit wont make the recruit resource go negative
	var converted = (conversions_per_second * conversion_chambers* convert_mod)
	if (recruits_literal-converted) >= 0:
		drones_literal += converted
		recruits_literal -= converted # Take out of recruit resource
		drones_rounded = int(floor(drones_literal))
		recruits_rounded = int(ceil(recruits_literal))
	
	#Resource production
	materials += (resources_per_drone_per_second * assigned_drones_materials * materials_mod)
	money += (resources_per_drone_per_second * assigned_drones_money * money_mod)
	science += (resources_per_drone_per_second * assigned_drones_science * science_mod)
	
	# Update the amount of availible drones
	available_drones = drones_rounded - (assigned_drones_materials + assigned_drones_money + assigned_drones_science)
	
func add_recruits(amnt):
	recruits_literal += amnt
	recruits_rounded = int(ceil(recruits_literal))

func format_number(number):
	var result
	var label = ""
	# First, determine if Nothing, K, M, B, or T label
	var offset = 0
	var logo = log(number) / log(10)
	
	if logo >= 12:
		label = "T"
		offset = 12
	elif logo >= 9:
		label = "B"
		offset = 9
	elif logo >= 6:
		label = "M"
		offset = 6
	elif logo >= 3:
		label = "K"
		offset = 3

	
	#Then limit it to 4 digits
	var digits = (log(number) / log(10)) - offset
	var final_number = number/pow(10,offset)
	if digits >= 3: #1000
		result = "%f"
		result = result % stepify(final_number,1)
	elif digits >= 2: #100.0
		result = "%.1f"
		result = result % stepify(final_number,0.1)
	elif digits >= 1: #10.00 
		result = "%.2f"
		result = result % stepify(final_number,0.01)
	else: 			#1.000
		result = "%.3f"
		result = result % stepify(final_number,0.001)
	
	#Apply label
	result = result + label
	
	return result

func format_number_int(number):
	var result
	var label = ""
	# First, determine if Nothing, K, M, B, or T label
	var offset = 0
	var logo = log(number) / log(10)
	
	if logo >= 12:
		label = "T"
		offset = 12
	elif logo >= 9:
		label = "B"
		offset = 9
	elif logo >= 6:
		label = "M"
		offset = 6
	elif logo >= 3:
		label = "K"
		offset = 3

	
	#Then limit it to 4 digits
	var digits = (log(number) / log(10)) - offset
	var final_number = number/pow(10,offset)
	if digits >= 3: #1000
		result = "%f"
		result = result % stepify(final_number,1)
	elif digits >= 2 and offset != 0 : #100.0
		result = "%.1f"
		result = result % stepify(final_number,0.1)
	elif digits >= 1 and offset != 0: #10.00 
		result = "%.2f"
		result = result % stepify(final_number,0.01)
	elif offset != 0: 			#1.000, avoid being float
		result = "%.3f"
		result = result % stepify(final_number,0.001)
	else:
		result = str(number)
	
	#Apply label
	result = result + label
	
	return result
