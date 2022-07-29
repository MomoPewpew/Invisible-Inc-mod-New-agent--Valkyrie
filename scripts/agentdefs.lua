local util = include( "modules/util" )
local commondefs = include( "sim/unitdefs/commondefs" )
local simdefs = include("sim/simdefs")
local speechdefs = include("sim/speechdefs")

local VALKYRIE_SOUNDS =
{	  
	bio = nil,
                escapeVo = nil,    
	speech="SpySociety/Agents/dialogue_player",  
	step = simdefs.SOUNDPATH_FOOTSTEP_FEMALE_HARDWOOD_NORMAL, 
	stealthStep = simdefs.SOUNDPATH_FOOTSTEP_FEMALE_HARDWOOD_SOFT,	
	wallcover = "SpySociety/Movement/foley_trench/wallcover",
	crouchcover = "SpySociety/Movement/foley_trench/crouchcover",
	fall = "SpySociety/Movement/foley_trench/fall",
	fall_knee = "SpySociety/Movement/bodyfall_agent_knee_hardwood",
	fall_kneeframe = 9,
	fall_hand = "SpySociety/Movement/bodyfall_agent_hand_hardwood",
	fall_handframe = 20,
	land = "SpySociety/Movement/deathfall_agent_hardwood",
	land_frame = 35,						
	getup = "SpySociety/Movement/foley_trench/getup",
	grab = "SpySociety/Movement/foley_trench/grab_guard",
	pin = "SpySociety/Movement/foley_trench/pin_guard",
	pinned = "SpySociety/Movement/foley_trench/pinned",	
	peek_fwd = "SpySociety/Movement/foley_trench/peek_forward",	
	peek_bwd = "SpySociety/Movement/foley_trench/peek_back",	
	move = "SpySociety/Movement/foley_trench/move",
	hit = "SpySociety/HitResponse/hitby_ballistic_flesh",
}

local agent_templates =
{
	valkyrie=
	{
		type = "simunit",
		agentID = "Momo-Valkyrie",
		name = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.NAME,
		fullname = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.ALT_1.FULLNAME,
		codename = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.ALT_1.FULLNAME,
		loadoutName = STRINGS.UI.ON_ARCHIVE,
		file = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.FILE,
		yearsOfService = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.YEARS_OF_SERVICE,
		age = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.AGE,
		homeTown =  STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.HOMETOWN,
		gender = "female",
		toolTip = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.ALT_1.TOOLTIP,
		onWorldTooltip = commondefs.onAgentTooltip,
		team_select_img = {"gui/agents/team_select_2_deckard.png"},
		profile_icon_36x36= "gui/profile_icons/stealth_36.png",
		profile_icon_64x64= "gui/profile_icons/stealth2_64x64.png",
		splash_image = "gui/agents/deckard2_1024.png",
		gender = "female",				
		profile_anim = "portraits/stealth_guy_face",
		kanim = "kanim_stealth_female",
		hireText =  STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.RESCUED,
		traits = util.extend( commondefs.DEFAULT_AGENT_TRAITS ) { mp=8, mpMax =8, },
		skills = util.extend( commondefs.DEFAULT_AGENT_SKILLS ) {}, 
		startingSkills = { inventory= 2 },
		abilities = util.tconcat( {  "sprint",  }, commondefs.DEFAULT_AGENT_ABILITIES ),
		children = {},
		sounds = VALKYRIE_SOUNDS ,
		speech = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.BANTER,
		blurb = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.ALT_1.BIO,
		upgrades = { "augment_subdermal_pda","item_revolver_deckard" },
	},
}

return agent_templates
