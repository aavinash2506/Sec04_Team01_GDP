extends Resource

class_name Questions

var id: String
var compoundType: String
var formulaValue: String

func _init(id: String, data: Dictionary) -> void:
	self.id = id
	for key in data.keys():
		var formula = data[key]
		self.formulaValue = formula["stringValue"]
		#self.compoundType = key
		self.compoundType = key[0].to_upper() + key.substr(1, key.length() - 1)
		#print("Key: ", self.compoundType, ", Value: ", formula)
