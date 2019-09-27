extends Node2D

var dictionary = {
	"1": {"id": 1, "name": "item 1", "modifiers": { muffin = 123}},
	"2": {"id": 2, "name": "item 2", "modifiers": { muffin = 123}},
	"3": {"id": 3, "name": "item 3", "modifiers": { muffin = 123}},
	}
	
func _ready():
	convert_dict_to_crystal_class(dictionary, "NodeTypes")
	
func convert_dict_to_crystal_class(data, class__name):
	var property_list = {}
	var property_list_s = PoolStringArray()
	var parameter_list_s = PoolStringArray()
	var hash_list_s = PoolStringArray()
	var special_client_modifiers = PoolStringArray()
	
	for key in data:
		var obj = data[key]
		var parameter_values_s = PoolStringArray()
		for key2 in obj:	
			var value = obj[key2]

			if value is Dictionary:
				# We must do recursion here
				property_list[key2] = "%s : Hash(String, Int32)" % key2
				# Conform to Crystal's Hash
				parameter_values_s.append("%s" % to_json(value).replace(":", "=>"))
				for mod_key in value:
					if mod_key.find("client_") != -1:
						special_client_modifiers.append("property %s = 0" % mod_key.replace("client_", ""))
			else:
				#Extract keys
				property_list[key2] = "%s = \"\" " % key2
				parameter_values_s.append("\"%s\"" % value)

		hash_list_s.append( "NodeTypes[\"%s\"] = NodeTypesClass.new(%s)" % [key, parameter_values_s.join(",")] )

	for key in property_list:
		property_list_s.append("property %s" % property_list[key])
		parameter_list_s.append("@%s" % key)

	var text = """
class %sClass
	%s
	def initialize(%s) end
end
%s
%s
""" % [
	class__name,
	property_list_s.join("\n	"),
	parameter_list_s.join(","),
	"%s = Hash(String, %sClass).new" % [class__name, class__name],
	hash_list_s.join("\n")
	]
	
	if special_client_modifiers.size() > 0:
		text += "\nclass Client\n%s\nend" % [special_client_modifiers.join("\n")]
		
	save_file("%s.cr" % class__name, text)
	print("Conversion Complete!\n-----------\n%s\n-----------" % text)

func save_file(the_path, content):
	var filet = File.new()
	filet.open(the_path, File.WRITE)
	filet.store_string(content)
	filet.close()
