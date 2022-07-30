local MOD_STRINGS =
{
	OPTIONS =
	{
		OF_RESCUABLE = "VALKYRIE RESUABLE",
		OF_RESCUABLE_DESC = "Whether On-File Valkyrie can be rescued from a Detention Center",
	},
	AGENTS =
	{
		VALKYRIE =
		{
			NAME = "Valkyrie",
			FILE = "",
			YEARS_OF_SERVICE = "",
			AGE = "",
			HOMETOWN = "",
			RESCUED = "",
			BANTER = "",
			ALT_1 =
			{
				FULLNAME = "",
				TOOLTIP = "",
				BIO = "",
			},
		},
	},
	ITEMS =
	{
		AUGMENT_SURVEILLANCE = "Strict Surveillance",
		AUGMENT_SURVEILLANCE_DESC = "Blackeye Cameras and Camera Canisters placed by this agent have a microphone unit, which allows them to hear. \nAt the start of your turn, you will automatically observe the movements of every guard that is within sight of a Blackeye Camera or a Camera Canister that was placed by this agent.",
		AUGMENT_SURVEILLANCE_FLAV = "Her years of working as an exfiltration specialist have taught Valkyrie how to get the most of surveillance tools in a hostile territory.",
		ITEM_CAMERA_LAUNCHER = "Camera Launcher",
		ITEM_CAMERA_LAUNCHER_DESC = "Launch a compact Blackeye Camera at a location that you can see, providing 360 degree vision in an area. Blackeye Cameras can not be recovered. \nThe camera launcher cannot be reloaded manually, but is automatically reloaded at the start of each mission.",
		ITEM_CAMERA_LAUNCHER_FLAV = "Experimental disposable surveillance tools that can be placed from a distance to quickly establish surveillance in a hostile area of operation. \nThe battery life is limited and the propelling mechanism is single-use, so these cameras can not be recovered once launched.",
		ITEM_BLACKEYE = "Blackeye Camera",
		ITEM_BLACKEYE_DESCR = "Surveillance equipment that was deployed by a Camera Launcher. This camera can not be recovered."
	},
	ABILITIES =
	{
		ABILITY_SURVEILLANCE = "Strict Surveillance",
	},
}
return MOD_STRINGS