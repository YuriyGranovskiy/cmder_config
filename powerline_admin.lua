local segment = {
    isNeeded = false,
    text = "",
    textColor = "7;54;66", 
    fillColor = "255;255;102"
}



local function get_is_admin()
	local admin_check = io.popen("whoami /priv | findstr SeImpersonatePrivilege 2>nul")
	for line in admin_check:lines() do
        admin_check:close()
        return true;
    end
    admin_check:close()
    return false
end

---
-- Sets the properties of the Segment object, and prepares for a segment to be added
---
local function init()
	segment.isNeeded = get_is_admin()	
    segment.text = " "..plc_admin_symbol.." "
end 

---
-- Uses the segment properties to add a new segment to the prompt
---
local function addAddonSegment()
    init()
	if (segment.isNeeded == true) then
		addSegment(segment.text, segment.textColor, segment.fillColor)
	end
end 

-- Register this addon with Clink
clink.prompt.register_filter(addAddonSegment, 62)
