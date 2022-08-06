----------------------------------------------------------------
-- Copyright (c) 2012 Klei Entertainment Inc.
-- All Rights Reserved.
-- SPY SOCIETY.
----------------------------------------------------------------

local cdefs = include( "client_defs" )
local util = include( "client_util" )
local commonanims = include("common_anims")
local commondefs = include( "sim/unitdefs/commondefs" )

local AGENT_ANIMS = commondefs.AGENT_ANIMS
local Layer = commondefs.Layer
local BoundType = commondefs.BoundType

-------------------------------------------------------------------
-- Data for anim definitions.

local animdefs =
{
    kanim_valkyrie =
	{
		wireframe =
		{
			"data/anims/characters/agents/overlay_agent_nika.abld",
		},
		build = 
		{ 			
			"data/anims/characters/anims_female/shared_female_hits_01.abld",		 
			"data/anims/characters/anims_female/shared_female_attacks_a_01.abld",	
			"data/anims/characters/agents/agent_valkyrie.abld",			
		},
		grp_build = 
		{
			"data/anims/characters/agents/grp_agent_nika.abld",
		},
		grp_anims = commonanims.female.grp_anims,

		anims = commonanims.female.default_anims_unarmed,
		anims_1h = commonanims.female.default_anims_1h,
		anims_2h = commonanims.female.default_anims_2h,
		animMap = AGENT_ANIMS,

		symbol = "character",
		anim = "idle",
		shouldFlip = true,
		scale = 0.25,
		layer = Layer.Unit,
		boundType = BoundType.Character,
		boundTypeOverrides = {			
			{anim="idle_ko" ,boundType= BoundType.CharacterFloor},
			{anim="dead" ,boundType= BoundType.CharacterFloor},
		},		
		peekBranchSet = 1,
	},
}
return animdefs