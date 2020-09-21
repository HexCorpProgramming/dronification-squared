extends Node
# This is the main node for all mathematics calculations.

const RECRUITER_BASE_MATERIAL = 100
const RECRUITER_BASE_MONEY = 400

const CONVERTER_BASE_MATERIAL = 200
const CONVERTER_BASE_MONEY = 100

const RESEARCH_BASE_SCIENCE = 100

const TICK_MOD = 5.0 # x ticks per second, 

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

#Values to be taken and displayed
var drones_per_second = 0.00
var multi = 1


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
	timer.set_wait_time(1.0/TICK_MOD)
	timer.connect("timeout",self,"tick")
	timer.start(1.0/TICK_MOD)
	
	get_tree().call_group("display", "update_display")



	#Use ceil for recruit rounding, and floor for drone rounding
	#Makes the conversions look better in the UI :>
func tick():
	#Every tick, add resources relative to the amount of producers.
	recruits_literal += (recruits_per_second * auto_recruiters*recruit_mod) / TICK_MOD
	recruits_rounded = int(ceil(recruits_literal))
	
	#Only do this if doing a recruit wont make the recruit resource go negative
	var converted = (conversions_per_second * conversion_chambers* convert_mod) / TICK_MOD
	if (recruits_literal-converted) >= 0:
		drones_literal += converted 
		recruits_literal -= converted # Take out of recruit resource
		drones_rounded = int(floor(drones_literal))
		recruits_rounded = int(ceil(recruits_literal))
	
	#Resource production
	materials += (resources_per_drone_per_second * assigned_drones_materials * materials_mod) / TICK_MOD
	money += (resources_per_drone_per_second * assigned_drones_money * money_mod) / TICK_MOD
	science += (resources_per_drone_per_second * assigned_drones_science * science_mod) / TICK_MOD
	
	# Update the amount of availible drones
	available_drones = drones_rounded - (assigned_drones_materials + assigned_drones_money + assigned_drones_science)
	
	#Updated the stored drones_per_second and assignment multipliers
	drones_per_second = conversion_chambers * conversions_per_second* convert_mod
	if multi * 1000 < drones_per_second:
		multi *= 1000
		
	#update on-tick displays
	get_tree().call_group("tickable", "tick")
		
func add_recruits(amnt):
	recruits_literal += amnt
	recruits_rounded = int(ceil(recruits_literal))

func create_dict():
	var save_dict = {
		# User Info
		"ID" : Global.ID,
		# Resources
		"drones" : drones_literal,
		"recruits" : recruits_literal,
		"money" : money,
		"materials" : materials,
		"science" : science,
		# Buildings
		"auto_recruiters" : auto_recruiters,
		"conversion_chambers" : conversion_chambers,
		# Assignments
		"assigned_money" : assigned_drones_money,
		"assigned_materials" : assigned_drones_materials,
		"assigned_science" : assigned_drones_science,
		# Researches
		"recruit_upgrades" : recruit_upgrades,
		"convert_upgrades" : convert_upgrades,
		"money_upgrades" : money_upgrades,
		"materials_upgrades" : materials_upgrades,
		"science_upgrades" : science_upgrades
	}
	
	return save_dict

func parse_dict(dict):
	#TODO, Make this a loop with an array of all the dictionary keys
	#load all data
	if dict.has("ID"):
		Global.ID = dict["ID"]
	
	drones_literal = dict["drones"]
	recruits_literal = dict["recruits"]
	money = dict["money"]
	materials = dict["materials"]
	science = dict["science"]
	
	auto_recruiters = dict["auto_recruiters"]
	conversion_chambers = dict["conversion_chambers"]
	
	assigned_drones_money = dict["assigned_money"]
	assigned_drones_materials = dict["assigned_materials"]
	assigned_drones_science = dict["assigned_science"]
	
	recruit_upgrades = dict["recruit_upgrades"]
	convert_upgrades = dict["convert_upgrades"]
	money_upgrades = dict["money_upgrades"]
	materials_upgrades = dict["materials_upgrades"]
	science_upgrades = dict["science_upgrades"]
	
	#Update mods
	if recruit_upgrades != 0:
		recruit_mod = (pow(2, Logic.recruit_upgrades-1) * Logic.upgrade_boost)+1.00
	else:
		recruit_mod = 1.00
	if convert_upgrades != 0:
		convert_mod = (pow(2, Logic.convert_upgrades-1) * Logic.upgrade_boost)+1.00
	else:
		convert_mod = 1.00
	if money_upgrades != 0:
		money_mod = (pow(2, Logic.money_upgrades-1) * Logic.upgrade_boost)+1.00
	else:
		money_mod = 1.00
	if materials_upgrades != 0:
		materials_mod = (pow(2, Logic.materials_upgrades-1) * Logic.upgrade_boost)+1.00
	else:
		materials_mod = 1.00
	if science_upgrades != 0:
		science_mod = (pow(2, Logic.science_upgrades-1) * Logic.upgrade_boost)+1.00
	else:
		science_mod = 1.00
	
	tick()
	get_tree().call_group("buildings", "update_cost")
	get_tree().call_group("display", "update_display")
	get_tree().call_group("operations", "update_text")
	
func format_number(number):
	var result = "%.2f"
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
	if digits >= 2: #100
		result = "%.1f"
		result = result % stepify(final_number,0.1)
	elif digits >= 1: #10.0 
		result = "%.2f"
		result = result % stepify(final_number,0.01)
	else: 			#1.00
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
	
	if logo >= 11.99:
		label = "T"
		offset = 12
	elif logo >= 8.99:
		label = "B"
		offset = 9
	elif logo >= 5.99:
		label = "M"
		offset = 6
	elif logo >= 2.99:
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
