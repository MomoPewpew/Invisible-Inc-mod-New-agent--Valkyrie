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
		profile_icon = "gui/icons/skills_icons/skills_icon_small/icon-item_augment_shalem_small.png",
    	profile_icon_100 = "gui/icons/skills_icons/icon-item_augment_shalem.png",
	},
	item_camera_launcher = util.extend( commondefs.weapon_template )
	{
		name =  STRINGS.MOD_VALKYRIE.ITEMS.ITEM_CAMERA_LAUNCHER,
		desc =  STRINGS.MOD_VALKYRIE.ITEMS.ITEM_CAMERA_LAUNCHER_DESC,
		flavor = STRINGS.MOD_VALKYRIE.ITEMS.ITEM_CAMERA_LAUNCHER_FLAV,
		icon = "itemrigs/FloorProp_Pistol.png",	
		profile_icon = "gui/icons/item_icons/items_icon_small/icon-item_Sticky_Cam_small.png",	
		profile_icon_100 = "gui/icons/item_icons/icon-item_Sticky_Cam.png",		
		equipped_icon = "gui/items/equipped_pistol.png",
		traits = {
			weaponType="pistol",
			baseDamage = 0,
			canTag= true,
			noTargetAlert=true,
			ignoreArmor=true,
			nopwr_guards = {},
			doNotInterruptMove = true,
		},
		sounds = {shoot="SpySociety/Weapons/Precise/shoot_dart", reload="SpySociety/Weapons/LowBore/reload_handgun", use="SpySociety/Actions/item_pickup"},
		weapon_anim = "kanim_precise_revolver",
		agent_anim = "anims_1h",
		value = 500,
	},	
}
return tool_templates