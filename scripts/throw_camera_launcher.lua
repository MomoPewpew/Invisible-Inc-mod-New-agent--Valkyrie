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

local throw_camera_launcher =
	{
		name = STRINGS.ABILITIES.THROW,

		getName = function( self, sim, unit, userUnit )
			return self.name
		end,
	
		createToolTip = function( self,sim,unit,targetCell)
			return abilityutil.formatToolTip( STRINGS.ABILITIES.THROW,  STRINGS.ABILITIES.THROW_DESC, 1 )
		end,
	
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
		
			local oldFacing = userUnit:getFacing()
			local newFacing = simquery.getDirectionFromDelta(x1-x0, y1-y0)
			simquery.suggestAgentFacing(userUnit, newFacing)
			if userUnit:getBrain() then	
				if grenadeUnit:getTraits().baseDamage then
					sim:emitSpeech(userUnit, speechdefs.HUNT_GRENADE)
				end
				sim:refreshUnitLOS( userUnit )
				sim:processReactions( userUnit )
			end

			if userUnit:isValid() and not userUnit:getTraits().interrupted then
				--sim:dispatchEvent( simdefs.EV_UNIT_THROW, { unit = userUnit, x1=x1, y1=y1, facing=newFacing } )

				local newUnit = nil
				local player = userUnit:getPlayerOwner()

				newUnit = simfactory.createUnit( itemdefs.item_blackeye_camera, sim )

				local x0, y0 = userUnit:getLocation()

				assert( player )
				newUnit:setPlayerOwner(player)
				newUnit:getTraits().throwingUnit = userUnit:getID()
				
				sim:dispatchEvent( simdefs.EV_UNIT_THROWN, { unit = newUnit, x=x1, y1 } )
				
				local pinning, pinnee = simquery.isUnitPinning(userUnit:getSim(), userUnit)
				sim:dispatchEvent( simdefs.EV_UNIT_START_SHOOTING, { unitID = userUnit:getID(), newFacing=newFacing, oldFacing=oldFacing,targetUnitID = userUnit:getID(), pinning=pinning } )
				
				if userUnit:countAugments( "valkyrie_augment_strict_surveillance" ) > 0 then
					newUnit:getTraits().hasHearing = true
					newUnit:getTraits().doAutoMarking = true
				end
				
				sim:spawnUnit( newUnit )

				if x0 ~= targetCell.x or y0 ~= targetCell.y then
					sim:warpUnit(newUnit, sim:getCell(x1, y1))
				end

				newUnit:getTraits().throwingUnit = player:getID()
				newUnit:getTraits().cooldown = newUnit:getTraits().cooldownMax

				sim:dispatchEvent( simdefs.EV_UNIT_STOP_SHOOTING, { unitID = userUnit:getID(), facing=newFacing, pinning=pinning} )	

				newUnit:activate()
				
				if newUnit:getTraits().keepPathing == false and player:getBrain() then
					player:useMP(player:getMP(), sim)
				end
				
				sim:processReactions()
				
				grenadeUnit:getTraits().ammo = grenadeUnit:getTraits().ammo - 1
				
			end
			userUnit:getTraits().throwing = nil
			if userUnit:isValid() and not userUnit:getTraits().interrupted then
				simquery.suggestAgentFacing(userUnit, newFacing)
			end

		end,
	}

return throw_camera_launcher
