local util = include( "modules/util" )
local commondefs = include( "sim/unitdefs/commondefs" )
local simdefs = include( "sim/simdefs" )

local tool_templates =
{
	valkyrie_augment_strict_surveillance = util.extend( commondefs.augment_template )
	{
		name = STRINGS.MOD_VALKYRIE.ITEMS.AUGMENT_SURVEILLANCE,
		desc = STRINGS.MOD_VALKYRIE.ITEMS.AUGMENT_SURVEILLANCE_DESC,
		flavor = STRINGS.MOD_VALKYRIE.ITEMS.AUGMENT_SURVEILLANCE_FLAV,
		traits = util.extend( commondefs.DEFAULT_AUGMENT_TRAITS ){
			installed = true,
		},
		abilities = util.tconcat( commondefs.augment_template.abilities, { "strict_surveillance" }),
		profile_icon = "gui/icons/skills_icons/skills_icon_small/icon-item_augment_shalem_small.png",
    	profile_icon_100 = "gui/icons/skills_icons/icon-item_augment_shalem.png",
	},
	item_camera_launcher = util.extend( commondefs.grenade_template )
	{
		name =  STRINGS.MOD_VALKYRIE.ITEMS.ITEM_CAMERA_LAUNCHER,
		desc =  STRINGS.MOD_VALKYRIE.ITEMS.ITEM_CAMERA_LAUNCHER_DESC,
		flavor = STRINGS.MOD_VALKYRIE.ITEMS.ITEM_CAMERA_LAUNCHER_FLAV,
		--icon = "itemrigs/FloorProp_Heavy_Pistol.png",
		profile_icon = "gui/icons/item_icons/items_icon_small/icon-item_Sticky_Cam_small.png",	
		profile_icon_100 = "gui/icons/item_icons/icon-item_Sticky_Cam.png",
		kanim = "kanim_stickycam",
		sounds = {activate="SpySociety/Grenades/stickycam_deploy", bounce="SpySociety/Grenades/bounce"},
		traits = {
			camera=true,
			LOSarc = math.pi * 2,
			disposable= false,
			agent_filter=true,
			ammo = 3,
			maxAmmo = 3,
			noReload = true,
		},
		abilities = { "carryable", "throw_camera_launcher",},
		value = 600,
		floorWeight = 2, 
		locator=true,
		createUpgradeParams = function( self, unit )
			return { traits = { ammo =  unit:getTraits().maxAmmo } }
		end,
	},
	item_blackeye_camera = util.extend( commondefs.item_template )
	{
		type = "simgrenade",
		--icon = "itemrigs/FloorProp_MotionDetector.png",
		name =  STRINGS.MOD_VALKYRIE.ITEMS.ITEM_BLACKEYE,
		desc =  STRINGS.MOD_VALKYRIE.ITEMS.ITEM_BLACKEYE_DESC,
		profile_icon = "gui/icons/item_icons/items_icon_small/icon-item_Sticky_Cam_small.png",	
		profile_icon_100 = "gui/icons/item_icons/icon-item_Sticky_Cam.png",
		kanim = "kanim_stickycam",
		abilities = {},
		traits = {
			camera=true,
			laptop=true,
			LOSarc = math.pi * 2,
			disposable= true,
			mainframe_icon_on_deploy=true,
			mainframe_status = "active",
			sightable = true,
			hidesInCover = true,
			agent_filter=true,
		},
		sounds = {activate="SpySociety/Grenades/stickycam_deploy", bounce="SpySociety/Grenades/bounce"},
	},
}
return tool_templates