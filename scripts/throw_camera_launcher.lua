local array = include( "modules/array" )
local util = include( "modules/util" )
local mathutil = include( "modules/mathutil" )
local cdefs = include( "client_defs" )
local simdefs = include("sim/simdefs")
local simquery = include("sim/simquery")
local inventory = include("sim/inventory")
local speechdefs = include("sim/speechdefs")
local abilityutil = include( "sim/abilities/abilityutil" )
local mathutil = include( "modules/mathutil" )
local unitdefs = include("sim/unitdefs")
local simfactory = include( "sim/simfactory" )
local itemdefs = include("sim/unitdefs/itemdefs")
local guarddefs = include("sim/unitdefs/guarddefs")
local propdefs = include("sim/unitdefs/propdefs")







-------------------------------------------------------------
-- Stolen from cloak tooltip for showing range - may work with later

local camera_launcher_throw_tooltip = class( abilityutil.hotkey_tooltip )

function camera_launcher_throw_tooltip:init( hud, unit, range, ... )
	abilityutil.hotkey_tooltip.init( self, ... )
	self._game = hud._game
	self._unit = unit
	self._range = range
    if range then
        local x0, y0 = unit:getLocation() 
        self._targets = getTargetUnits( hud._game.simCore, unit, x0, y0, range)
    end
end

function camera_launcher_throw_tooltip:activate( screen )
	abilityutil.hotkey_tooltip.activate( self, screen )
	if self._range then
		local x0, y0 = self._unit:getLocation()
		local coords = simquery.rasterCircle( self._game.simCore, x0, y0, self._range )
		self._hiliteID = self._game.boardRig:hiliteCells( coords, cdefs.HILITE_TARGET_COLOR )
        for i, target in ipairs( self._targets ) do
            self._game.boardRig:getUnitRig( target:getID() ):getProp():setRenderFilter( cdefs.RENDER_FILTERS["focus_target"] )
        end
	end
end

function camera_launcher_throw_tooltip:deactivate()
	abilityutil.hotkey_tooltip.deactivate( self )
	if self._range then
		self._game.boardRig:unhiliteCells( self._hiliteID )	
		self._hiliteID = nil
        for i, target in ipairs( self._targets ) do
            self._game.boardRig:getUnitRig( target:getID() ):refreshRenderFilter()
        end
	end
end

local throw_camera_launcher =
	{
		name = STRINGS.ABILITIES.THROW,

		getName = function( self, sim, unit, userUnit )
			return self.name
		end,
	
		createToolTip = function( self,sim,unit,targetCell)
			return abilityutil.formatToolTip( STRINGS.ABILITIES.THROW,  STRINGS.ABILITIES.THROW_DESC, 1 )
		end,
		
		--onTooltip = function( self, hud, sim, abilityOwner, abilityUser )
		--	return camera_launcher_throw_tooltip( hud, abilityUser, abilityOwner:getTraits().range, self, sim, abilityOwner, STRINGS.ABILITIES.CLOAK_DESC )
		--end,
	
		profile_icon = "gui/icons/action_icons/Action_icon_Small/icon-item_shoot_small.png",
		usesAction = true,

		acquireTargets = function( self, targets, game, sim, grenadeUnit, unit)
			if not self:canUseAbility( sim, grenadeUnit, unit ) then
				return nil
			end
			return targets.throwTarget( game, grenadeUnit:getTraits().range or 0, sim, unit, unit:getTraits().maxThrow, grenadeUnit:getTraits().targeting_ignoreLOS)
		end, 


		canUseAbility = function( self, sim, grenadeUnit, unit, targetCell )
		
            if unit:getTraits().movingBody then
                return false, STRINGS.UI.REASON.DROP_BODY_TO_USE
            end
			
			local ok, reason = abilityutil.canConsumeAmmo( sim, grenadeUnit )
            if not ok then
                return false
            end

			if grenadeUnit:getTraits().restrictedUse then

				local userUnitAgentID = unit:getUnitData().agentID
				local canUse =false
				for i,set in pairs(grenadeUnit:getTraits().restrictedUse )do
					if set.agentID == userUnitAgentID then
						canUse=true
					end
				end


				if not canUse then
					return false,  STRINGS.UI.REASON.RESTRUCTED_USE
				end				
			end

			if grenadeUnit:getTraits().cooldown and grenadeUnit:getTraits().cooldown > 0 then
				return false, util.sformat(STRINGS.UI.REASON.COOLDOWN,grenadeUnit:getTraits().cooldown)
			end

			if grenadeUnit:getTraits().usesCharges and grenadeUnit:getTraits().charges < 1 then
				return false, util.sformat(STRINGS.UI.REASON.CHARGES)
			end

			if grenadeUnit:getTraits().pwrCost and unit:getPlayerOwner():getCpus() < grenadeUnit:getTraits().pwrCost then
				return false, util.sformat(STRINGS.UI.REASON.NOT_ENOUGH_PWR)
			end

			if targetCell then
				local targetX,targetY = unpack(targetCell)
				local unitX, unitY = unit:getLocation()
	    		local raycastX, raycastY = sim:getLOS():raycast(unitX, unitY, targetX, targetY)
				if raycastX ~= targetX or raycastY ~= targetY then
					return false
				end
				local range = mathutil.dist2d(unitX, unitY, targetX, targetY)
				if range > 5 then
					return false
				end
			end

			return true
		end,
	   
		-----------------
		
		executeAbility = function( self, sim, grenadeUnit, userUnit, targetCell )
			local sim = grenadeUnit:getSim()
			local x0,y0 = userUnit:getLocation()
					
			local x1,y1 = unpack(targetCell)
			local cell = sim:getCell( userUnit:getLocation() )
			userUnit:getTraits().throwing = true
		
			local facing = simquery.getDirectionFromDelta(x1-x0, y1-y0)
			simquery.suggestAgentFacing(userUnit, facing)
			if userUnit:getBrain() then	
				if grenadeUnit:getTraits().baseDamage then
					sim:emitSpeech(userUnit, speechdefs.HUNT_GRENADE)
				end
				sim:refreshUnitLOS( userUnit )
				sim:processReactions( userUnit )
			end

			if userUnit:isValid() and not userUnit:getTraits().interrupted then
			
			--sim:removeTrigger( simdefs.TRG_UNIT_WARP, self )
			
			--[==[------------
			local player = sim:getPC()
			sim:forEachUnit(
					function ( existingMines )
						local x1, y1 = existingMines:getLocation()
						if x1 and y1 and existingMines:getTraits().isWidowMine then
							mineUnitID = existingMines:getID()				
							sim:warpUnit(existingMines, nil)
							sim:despawnUnit( existingMines )
							player:glimpseUnit(sim, mineUnitID)
							sim:removeTrigger( simdefs.TRG_UNIT_WARP, self)
						end
					end
				)
			]==]------------
			
				--sim:dispatchEvent( simdefs.EV_UNIT_START_SHOOTING, { unitID = userUnit:getID(), newFacing = newFacing, oldFacing = oldFacing, overwatch = true, targetUnitID = targetUnit:getID() } )
				sim:dispatchEvent( simdefs.EV_UNIT_THROW, { unit = userUnit, x1=x1, y1=y1, facing=facing } )
				--sim:dispatchEvent( simdefs.EV_UNIT_STOP_SHOOTING, { unitID = userUnit:getID(), facing=facing } )	
				

				local newUnit = nil
				local player = userUnit:getPlayerOwner()

				newUnit = simfactory.createUnit( itemdefs.item_blackeye_camera, sim )
				newUnit:setPlayerOwner( player )
	
				-- Spawn and warp the new unit
				sim:spawnUnit( newUnit )
				sim:warpUnit( newUnit, sim:getCell(x1, y1) )
				newUnit:activate()

				sim:emitSound( simdefs.SOUND_ITEM_PUTDOWN, cell.x, cell.y, userUnit)
			sim:emitSound( simdefs.SOUND_PRIME_EMP, cell.x, cell.y, userUnit)
			
			--self.abilityOwner = userUnit
			--sim:addTrigger( simdefs.TRG_UNIT_WARP, self )
			
			

			sim:dispatchEvent( simdefs.EV_UNIT_REFRESH, { unit = newUnit} ) 

			--if newUnit:getTraits().trigger_mainframe then
				--newUnit:getTraits().mainframe_item = true
				newUnit:getTraits().mainframe_status = "on"
				--newUnit:getTraits().isWidowMine = true
				newUnit:setPlayerOwner( userUnit:getPlayerOwner() )
			--end
				
				userUnit:resetAllAiming()

			inventory.useItem( sim, userUnit, grenadeUnit )

				sim:dispatchEvent( simdefs.EV_UNIT_STOP_THROW, { unitID = userUnit:getID(), x1=x1, y1=y1, facing=facing } )
			-- sim:addTrigger( simdefs.TRG_UNIT_WARP, self)

				sim:processReactions( userUnit )
			end
			userUnit:getTraits().throwing = nil
			if userUnit:isValid() and not userUnit:getTraits().interrupted then
				simquery.suggestAgentFacing(userUnit, facing)
			end

			
			
		end,
	}

return throw_camera_launcher
