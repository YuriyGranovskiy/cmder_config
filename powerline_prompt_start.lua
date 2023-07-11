local segment = {
    isNeeded = true,
    text = "",
    textColor = "42;161;152", 
    fillColor = "147;161;161"
}

---
-- Sets the properties of the Segment object, and prepares for a segment to be added
---
local function init()
    segment.text = plc_start_symbol
end 

---
-- Uses the segment properties to add a new segment to the prompt
---
local function addAddonSegment()
    init()
    addSegment(segment.text, segment.textColor, segment.fillColor)
end 

-- Register this addon with Clink
clink.prompt.register_filter(addAddonSegment, 53)
