class_name SymbolGeneration

static var available_characters := range(65, 91)

static func clear() -> void:
	available_characters = range(65, 91)

#static func generate_symbols(count: int, symbol_count: int) -> Array[String]:
	#assert(count <= 25, "Symbols count exceeded")
	#var symbols : Array[String] = []
	#var symbols_range := range(65, 90)
	#for i in count:
		#var symbol_index := randi_range(0, symbols_range.size())
		#var symbol_code := symbol_index + 65
		#symbols_range.remove_at(symbol_index)
		#var str := ""
		#str += String.chr(symbol_code)
		#for j in symbol_count - 1:
			#str += String.chr(randi_range(65, 90))
		#symbols.append(str)
	#return symbols


static func generate_symbol(count: int) -> String:
	var symbol_index := randi_range(0, available_characters.size() - 1)
	var symbol_code : int = available_characters[symbol_index]
	var label := String.chr(symbol_code)
	label = label.to_lower()
	available_characters.remove_at(symbol_index)
	for i in count - 1:
		label += String.chr(randi_range(65, 90)).to_lower()
	return label

static func free_symbol(char: String) -> void:
	available_characters.append(char.unicode_at(0))
