local array = include( "modules/array" )
local util = include( "modules/util" )
local cdefs = include( "client_defs" )
local simdefs = include("sim/simdefs")
local simquery = include("sim/simquery")
local abilityutil = include( "sim/abilities/abilityutil" )

local strict_surveillance =
{
	name = STRINGS.MOD_VALKYRIE.ABILITIES.ABILITY_SURVEILLANCE,

	getName = function( self, sim, abilityOwner, abilityUser, targetUnitID )
		return self.name
	end,

	onSpawnAbility = function( self, sim, unit )
		self.abilityOwner = unit
		sim:addTrigger( simdefs.TRG_START_TURN, self )
		sim:addTrigger( simdefs.EV_UNIT_THROW, self )
	end,
		
	onDespawnAbility = function( self, sim, unit )
		sim:removeTrigger( simdefs.TRG_START_TURN, self )
		sim:removeTrigger( simdefs.EV_UNIT_THROW, self )
		self.abilityOwner = nil
	end,
	
	profile_icon = nil,

	canUseAbility = function( self, sim, abilityOwner, unit )
		return abilityutil.checkRequirements( abilityOwner, abilityUser )
	end,
	
	createObserveTab = function( self, unit )
		if not unit:getBrain() then return end

		local subtext = ""
		local brainClassType = unit:getBrain():getSituation().ClassType
		local x0, y0 = unit:getLocation()

		if brainClassType == simdefs.SITUATION_INVESTIGATE then
			if unit:getBrain():getInterest().x == x0 and unit:getBrain():getInterest().y == y0 then
				subtext = STRINGS.GUARD_STATUS.START_INVESTIGATING
			else
				subtext = STRINGS.GUARD_STATUS.INVESTIGATING
			end
		elseif brainClassType == simdefs.SITUATION_HUNT then
			local interest = unit:getBrain():getInterest()
			if interest and interest.reason == simdefs.REASON_KO and interest.x == x0 and interest.y == y0 then
				subtext = STRINGS.GUARD_STATUS.START_HUNTING
			else
				subtext = STRINGS.GUARD_STATUS.HUNTING
			end
		elseif brainClassType == simdefs.SITUATION_FLEE then
			subtext = STRINGS.GUARD_STATUS.FLEEING
		elseif brainClassType == simdefs.SITUATION_COMBAT then
			if unit:getTraits().vip then
				subtext = STRINGS.GUARD_STATUS.FLEEING
			else
				subtext = STRINGS.GUARD_STATUS.COMBAT
			end
		elseif brainClassType == simdefs.SITUATION_IDLE then
			if not unit:getTraits().patrolPath or (#unit:getTraits().patrolPath == 1 and unit:getTraits().patrolPath[1].x == x0 and unit:getTraits().patrolPath[1].y == y0) then
				subtext = STRINGS.GUARD_STATUS.IDLE
			else
				subtext = STRINGS.GUARD_STATUS.PATROLLING
			end
		else
			subtext = "UNKNOWN"
		end

		unit:createTab( STRINGS.GUARD_STATUS.STATUS, subtext )
	end,
	
	onTrigger = function( self, sim, evType, evData )
		if evType == simdefs.TRG_START_TURN then
			if self.abilityOwner and evData and evData:isPC() and not self.abilityOwner:isKO() then
				userUnit = self.abilityOwner:getUnitOwner()
				local x0,y0 = userUnit:getLocation()
				if x0 and y0 then
					for _, deployedCamera in pairs(sim:getAllUnits()) do
						if deployedCamera:getTraits().doAutoMarking then
							local x1, y1 = deployedCamera:getLocation()
							if x1 and y1 then
								for _, unit in pairs( sim:getAllUnits() ) do
									if sim:canUnitSeeUnit( deployedCamera, unit ) and not unit:getTraits().noObserve and unit:getPather() and not unit:getTraits().patrolObserved and simquery.isEnemyTarget( userUnit:getPlayerOwner(), unit ) and not (unit:isKO() or unit:isDead()) then
										unit:getTraits().patrolObserved = true
										self:createObserveTab( unit )
										sim:dispatchEvent( simdefs.EV_UNIT_OBSERVED, unit )
										self.abilityOwner:getPlayerOwner():glimpseUnit( sim, unit:getID() )
									end
								end
							end
						end
					end
				end
			end
		end
		
		if evType == simdefs.EV_UNIT_THROW then
			if self.abilityOwner and evData then
				for _, unit in pairs( sim:getAllUnits() ) do
					if unit:getTraits().throwingUnit and unit:getTraits().throwingUnit > 0 then
						local throwingUnit = sim:getUnit( unit:getTraits().throwingUnit )
						if throwingUnit and throwingUnit:countAugments( "valkyrie_augment_strict_surveillance" ) > 0 and unit:getTraits().camera then
							unit:getTraits().hasHearing = true
							unit:getTraits().doAutoMarking = true
						end
					end
				end
			end
		end
	end,
}
return strict_surveillance