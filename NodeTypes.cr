
class NodeTypesClass
	property id = "" 
	property name = "" 
	property modifiers : Hash(String, Int32)
	def initialize(@id,@name,@modifiers) end
end
NodeTypes = Hash(String, NodeTypesClass).new
NodeTypes["1"] = NodeTypesClass.new("1","item 1",{"muffin"=>123})
NodeTypes["2"] = NodeTypesClass.new("1","item 1",{"muffin"=>123})
NodeTypes["3"] = NodeTypesClass.new("1","item 1",{"muffin"=>123})
