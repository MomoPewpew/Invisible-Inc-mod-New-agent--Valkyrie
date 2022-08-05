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

	wallcover = "SpySociety/Movement/foley_suit/wallcover", 
	crouchcover = "SpySociety/Movement/foley_suit/crouchcover",
	fall = "SpySociety/Movement/foley_suit/fall",	
	land = "SpySociety/Movement/deathfall_agent_hardwood",
	land_frame = 16,	
	getup = "SpySociety/Movement/foley_suit/getup",
	grab = "SpySociety/Movement/foley_suit/grab_guard",
	pin = "SpySociety/Movement/foley_suit/pin_guard",
	pinned = "SpySociety/Movement/foley_suit/pinned",
	peek_fwd = "SpySociety/Movement/foley_suit/peek_forward",	
	peek_bwd = "SpySociety/Movement/foley_suit/peek_back",
	move = "SpySociety/Movement/foley_suit/move",		
	hit = "SpySociety/HitResponse/hitby_ballistic_flesh",
}

local agent_templates =
{
	valkyrie=
	{
		type = "simunit",
		agentID = "Momo-R6-Valkyrie",
		name = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.NAME,
		fullname = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.FULLNAME,
		codename = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.FULLNAME,
		loadoutName = STRINGS.UI.ON_FILE,
		file = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.FILE,
		yearsOfService = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.ALT_1.YEARS_OF_SERVICE,
		age = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.ALT_1.AGE,
		homeTown =  STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.HOMETOWN,
		gender = "female",
		toolTip = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.ALT_1.TOOLTIP,
		onWorldTooltip = commondefs.onAgentTooltip,
		
		profile_icon_36x36= "gui/profile_icons/valkyrie_32.png",
		profile_icon_64x64= "gui/profile_icons/valkyrie_64.png",
		splash_image = "gui/agents/valkyrie_1024.png",
		profile_anim = "portraits/lady_sharpshooter_face",	
		team_select_img = {
			"gui/agents/valkyrie_256.png"
		},
		
		kanim = "kanim_female_sharpshooter_2",
		hireText =  STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.RESCUED,
		traits = util.extend( commondefs.DEFAULT_AGENT_TRAITS ) { mp=8, mpMax =8, },
		skills = util.extend( commondefs.DEFAULT_AGENT_SKILLS ) {}, 
		startingSkills = { hacking= 2 },
		abilities = util.tconcat( {  "sprint",  }, commondefs.DEFAULT_AGENT_ABILITIES ),
		children = {},
		sounds = VALKYRIE_SOUNDS ,
		speech = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.BANTER,
		blurb = STRINGS.MOD_VALKYRIE.AGENTS.VALKYRIE.ALT_1.BIO,
		upgrades = { "valkyrie_augment_strict_surveillance","item_dartgun","item_camera_launcher"},
	},
}

return agent_templates
