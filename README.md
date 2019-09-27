# GDScriptDictionaryToCrystalHash
Converts a GDScript's [Dictionary](https://docs.godotengine.org/en/3.1/classes/class_dictionary.html) to a [Crystal Hash](https://crystal-lang.org/api/0.31.0/Hash.html)

### What does this do?
 - Converts this:
 ```
 var dictionary = {
	"1": {"id": 1, "name": "item 1", "modifiers": { muffin = 123}},
	"2": {"id": 1, "name": "item 1", "modifiers": { muffin = 123}},
	"3": {"id": 1, "name": "item 1", "modifiers": { muffin = 123}},
	}
  ```
  
  - Into this:
```
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
```

### Welcome!
This is definitely a work in progress, and I welcome all contributions to make this the best GDScript Dictionary to Crystal Hash converter ever!
