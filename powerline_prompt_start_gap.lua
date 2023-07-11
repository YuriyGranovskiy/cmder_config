local segment = {
    isNeeded = true,
    text = "",
    textColor = "0",
    fillColor = "0"
}

---
-- Sets the properties of the Segment object, and prepares for a segment to be added
---
local function init()
    segment.text = " "
end 

---
-- Uses the segment properties to add a new segment to the prompt
---
local function addAddonSegment()
    init()
    addSegment(segment.text, segment.textColor, segment.fillColor)
end 

-- Register this addon with Clink
clink.prompt.register_filter(addAddonSegment, 54)
