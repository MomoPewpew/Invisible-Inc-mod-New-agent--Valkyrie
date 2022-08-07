local actions = include("sim/btree/actions")
local senses = include("sim/btree/senses")
local simdefs = include("sim/simdefs")

-- This function controls what happens when a guard reaches an 'interest' spot
local old_MarkInterestInvestigated = actions.MarkInterestInvestigated
actions.MarkInterestInvestigated = function(sim, unit)
    if not unit:getBrain():getInterest() then
		return simdefs.BSTATE_FAILED
	end

    local units = {}
	local cell = unit:getSim():getCell(unit:getLocation())

    for _,checkUnit in ipairs(cell.units) do
		if checkUnit:getTraits().blackEye then
            sim:warpUnit(checkUnit)
		    sim:despawnUnit(checkUnit)
            local params = {color ={{symbol="inner_line",r=1,g=0,b=0,a=0.75},{symbol="wall_digital",r=1,g=0,b=0,a=0.75},{symbol="boxy_tail",r=1,g=0,b=0,a=0.75},{symbol="boxy",r=1,g=0,b=0,a=0.75}} }
            sim:dispatchEvent( simdefs.EV_UNIT_ADD_FX, { unit = unit, kanim = "fx/emp_effect", symbol = "character", anim="idle", above=true, params=params} )
            local x1, y1 = unit:getLocation()
            sim:dispatchEvent( simdefs.EV_PLAY_SOUND, {sound="SpySociety/HitResponse/hitby_tazer_flesh", x=x1,y=y1} )
		end
	end

    return old_MarkInterestInvestigated(sim, unit)
end

-- Handles when a something warps into a guards vision.
local old_processWarpTrigger = senses.processWarpTrigger
senses.processWarpTrigger = function(self, sim, evData)
	old_processWarpTrigger(self, sim, evData)
    if evData.unit:isValid() and evData.unit:getTraits().blackEye then
        if evData.to_cell then
            local canSee, canSense = sim:canUnitSeeUnit(self.unit, evData.unit)
            if canSee == true or canSense == true then
                self:addInterest(evData.to_cell.x, evData.to_cell.y, simdefs.SENSE_SIGHT, simdefs.REASON_FOUNDOBJECT)
            end
        end
    end
end