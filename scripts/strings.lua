local MOD_STRINGS =
{
	OPTIONS =
	{
		OF_RESCUABLE = "VALKYRIE RESCUABLE",
		OF_RESCUABLE_DESC = "Whether On-File Valkyrie can be rescued from a Detention Center",
	},
	AGENTS =
	{
		VALKYRIE =
		{
			NAME = "Valkyrie",
			FILE = "MOMO-001",
			FULLNAME = "Anna Magnusdotter",
			HOMETOWN = "Malmö, Sweden",
			RESCUED = "This exfiltration is passable at best. Let's see what we can do to improve that.",
			BANTER = {
				START ={
					"Establishing a perimeter of control.",
					"Let's see what we can see.",
				},
				FINAL_WORDS =
				{
					"I want you to look into my eyes when you shoot.",
					"It was always going to end like this.",
				},
			},
			ALT_1 =
			{
				TOOLTIP = "Surveillance Specialist",
				BIO = "Anna spent her twenties working as a special operations consultant for corporations and intelligence agencies, specializing in reconnaissance and exfiltration. \n\nAs she grew older she desired a more noble line of work with a bigger paycheck, and joined Invisible. I sometimes doubt her loyalty to our cause, but I trust that we can count on her. So long as the credits keep flowing.",
				YEARS_OF_SERVICE = "2",
				AGE = "34",
			},
		},
	},
	ITEMS =
	{
		AUGMENT_SURVEILLANCE = "Strict Surveillance",
		AUGMENT_SURVEILLANCE_DESC = "Black Eye Cameras and Camera Canisters placed by this agent have a microphone unit, which allows them to hear. \nAt the start of your turn, you will automatically observe the movements of every guard that is within sight of a Black Eye Camera or a Camera Canister that was placed by this agent.",
		AUGMENT_SURVEILLANCE_FLAV = "Her years of working as an exfiltration specialist have taught Valkyrie how to get the most out of surveillance tools in a hostile territory.",
		ITEM_CAMERA_LAUNCHER = "Camera Launcher",
		ITEM_CAMERA_LAUNCHER_DESC = "Launch a compact Black Eye Camera at a location that you can see, providing 360 degree vision in an area. Black Eye Cameras can not be recovered. \nThe camera launcher can not be reloaded manually, but is automatically reloaded at the start of each mission.",
		ITEM_CAMERA_LAUNCHER_FLAV = "Experimental disposable surveillance tools that can be placed from a distance to quickly establish surveillance in a hostile area of operation. \nThe battery life is limited and the propelling mechanism is single-use, so these cameras can not be recovered once launched.",
		ITEM_BLACKEYE = "Black Eye Camera",
		ITEM_BLACKEYE_DESC = "Surveillance equipment that was deployed by a Camera Launcher. This camera can not be recovered. \nIf a guard sees this camera, they will destroy it and start hunting."
	},
	ABILITIES =
	{
		ABILITY_SURVEILLANCE = "Strict Surveillance",
	},
}
return MOD_STRINGS
