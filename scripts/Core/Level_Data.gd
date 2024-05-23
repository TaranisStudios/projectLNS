extends Node

var level_dic = {
	"Level_1" : {
		"unlocked" : true,
		"score" : 0,
		"max_score" : 0,
		"coins" : 0,
		"max_coins" : 0,
		"damege_taken" : 0,
		"unlocks" : "Level_2",
		"beaten" : false
	}
}

func genarate_level(level):
	if level not in level_dic:
		level_dic[level] = {
			"unlocked" : true,
			"score" : 0,
			"max_score" : 0,
			"coins" : 0,
			"max_coins" : 0,
			"damege_taken" : 0,
			"unlocks" : genarate_level_number(level),
			"beaten" : false
		}

func genarate_level_number(level):
	var level_number = ""
	for character in level:
		if character.is_valid_int():
			level_number += character
			
	level_number = int(level_number) + 1
	
	return "Level" + str(level_number)
	
func update_level(level, score, max_score, coins, max_coins, damage_taken, beaten):
	level_dic[level]["score"] = score
	level_dic[level]["max_score"] = max_score
	level_dic[level]["coins"] = coins
	level_dic[level]["max_coins"] = max_coins
	level_dic[level]["damage_taken"] = damage_taken
	level_dic[level]["beaten"] = beaten
