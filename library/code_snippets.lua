function generateMidiNotes(octave, offset, note_count, reverse_order)
	local base <const> = {24, 26, 28, 29, 31, 33, 35}
	local notes = table.create(note_count)
	
	local index_start <const> = reverse_order and (note_count-1) or 0
	local index_end <const> = reverse_order and 0 or (note_count-1)
	local index_inc <const> = reverse_order and -1 or 1
	local note_i = 0
	
	for i = index_start, index_end, index_inc do
		notes[note_i + 1] = base[((offset + i) % #base) + 1] + (12 * (math.floor((offset + i) / #base) + octave))
		note_i += 1
	end
	
	return notes
end


function getSvgPaths( svg_filepath )
	local file, file_error = playdate.file.open( svg_filepath, playdate.file.kFileRead )
	assert(file, "getSvgPaths(), Cannot open file", svg_filepath," (",file_error,")")

	local push = table.insert
	local commandArgCount = { M=2, L=2, T=2, H=1, V=1, C=6, S=6, A=7, Z=0}

	-- read the whole file
	local fileContent = ""
	repeat
		local line = file:readline()
		if line then
			fileContent = fileContent..line
		end
	until not line

	local result = table.create( 8 )
	for path in fileContent:gmatch("<path.-/>") do
		local previousX, previousY = 0, 0
		local newPath = table.create( 8 )

		local name = path:match("id=\"(.-)\"")
		if not name then name = #result + 1 end
		result[name] = newPath

		local d_content = path:match(" d=\"(.-)\"")
		for command in d_content:gmatch("%a[%-%d%., ]*") do
			local first_character = command:sub(1,1)
			local command_letter = first_character:upper()
			local absolute_coordinates = command_letter==first_character

			local args = table.create( 6 )
			for number in command:gmatch("[-%d%.]+") do
				push(args, tonumber(number))
			end
			local argCount = commandArgCount[ command_letter ]

			local argIndex = 0
			while argIndex+argCount<=#args do
				local relativeX, relativeY = 0, 0
				if not absolute_coordinates then
					relativeX, relativeY = previousX, previousY
				end

				if command_letter=="M" or command_letter=="L" or command_letter=="T" then
					push( newPath, args[argIndex+1] + relativeX)
					push( newPath, args[argIndex+2] + relativeY)
				elseif command_letter=="H" then
					push( newPath, args[argIndex+1] + relativeX)
					push( newPath, previousY)
				elseif command_letter=="V" then
					push( newPath, previousX)
					push( newPath, args[argIndex+1] + relativeY)
				elseif command_letter=="C" then
					push( newPath, args[argIndex+5] + relativeX)
					push( newPath, args[argIndex+6] + relativeY)
				elseif command_letter=="S" then
					push( newPath, args[argIndex+3] + relativeX)
					push( newPath, args[argIndex+4] + relativeY)
				elseif command_letter=="A" then
					push( newPath, args[argIndex+6] + relativeX)
					push( newPath, args[argIndex+7] + relativeY)
				elseif command_letter=="Z" then
					push( newPath, newPath[1])
					push( newPath, newPath[2])
				end

				previousX = newPath[#newPath-1]
				previousY = newPath[#newPath]

				argIndex = argIndex + math.max(argCount, 1)
			end
		end
	end

	for rect in fileContent:gmatch("<rect.-/>") do
		local width = tonumber( rect:match("width=\"([-%d%.]+)\"") )
		local height = tonumber( rect:match("height=\"([-%d%.]+)\"") )
		local x = tonumber( rect:match("x=\"([-%d%.]+)\"") )
		local y = tonumber( rect:match("y=\"([-%d%.]+)\"") )

		local name = rect:match("id=\"(.-)\"")
		if not name then name = #result + 1 end
		result[name] = {
			x, y,
			x+width, y,
			x+width, y+height,
			x, y+height,
			x, y,
		}
	end

	return result
end


