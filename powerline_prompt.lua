-- Extracts only the folder name from the input Path
-- Ex: Input C:\Windows\System32 returns System32
---
local function get_folder_name(path)
	local reversePath = string.reverse(path)
	local slashIndex = string.find(reversePath, "\\")
	return string.sub(path, string.len(path) - slashIndex + 2)
end

-- * Segment object with these properties:
---- * isNeeded: sepcifies whether a segment should be added or not. For example: no Git segment is needed in a non-git folder
---- * text
---- * textColor: Use one of the color constants. Ex: colorWhite
---- * fillColor: Use one of the color constants. Ex: colorBlue
local segment = {
    isNeeded = true,
    text = "",
    textColor = "7;54;66", 
    fillColor = "42;161;152"
}

---
-- Sets the properties of the Segment object, and prepares for a segment to be added
---
local function init()
    -- fullpath
    cwd = clink.get_cwd()

    -- show 'smart' folder name
    -- This will show the full folder path unless a Git repo is active in the folder
    -- If a Git repo is active, it will only show the folder name
    -- This helps users avoid having a super long prompt
    local git_dir = get_git_dir()
    if string.find(cwd, clink.get_env("HOME")) and git_dir ==nil then 
        -- in both smart and full if we are in home, behave like a proper command line
        cwd = string.gsub(cwd, clink.get_env("HOME"), plc_prompt_homeSymbol)
    else 
        -- either not in home or home not supported then check the smart path
        if git_dir then
            cwd = get_folder_name(cwd)
            if plc_npm_gitSymbol then
                cwd = gitSymbol.." "..cwd
            end
        end        
    end
	
	segment.text = "  "..cwd.." "
end 

---
-- Uses the segment properties to add a new segment to the prompt
---
local function addAddonSegment()
    init()
    addSegment(segment.text, segment.textColor, segment.fillColor)
end 

-- Register this addon with Clink
clink.prompt.register_filter(addAddonSegment, 55)
