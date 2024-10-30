extends Resource

class_name Users

var id: String
var first_name: String
var last_name: String
var email: String
#var score: String
var highest_score_lvl_1: String = "0"
var highest_score_lvl_2: String = "0"


func _init(id: String, data: Dictionary) -> void:
	self.id = id
	self.first_name = data["first_name"]["stringValue"]
	self.email = data["email"]["stringValue"]
	self.last_name = data["last_name"]["stringValue"]
	if (data.has("highest_score_lvl_1")):
		self.highest_score_lvl_1 = data["highest_score_lvl_1"]["stringValue"]
	if (data.has("highest_score_lvl_2")):
		self.highest_score_lvl_2 = data["highest_score_lvl_2"]["stringValue"]
	
	#for key in data.keys():
		#var formula = 
		#self.formulaValue = formula["stringValue"]
		#self.compoundType = key
		#print("Key: ", self.compoundType, ", Value: ", formula)
