local array = include( "modules/array" )
local util = include( "modules/util" )
local cdefs = include( "client_defs" )
local simdefs = include("sim/simdefs")
local simquery = include("sim/simquery")
local speechdefs = include("sim/speechdefs")
local abilityutil = include( "sim/abilities/abilityutil" )

local strict_surveillance =
	{
		name = STRINGS.MOD_VALKYRIE.ABILITIES.ABILITY_SURVEILLANCE,
	}
return strict_surveillance
