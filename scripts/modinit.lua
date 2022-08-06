local function init( modApi )
	modApi:addGenerationOption("OF_RESCUABLE", STRINGS.MOD_VALKYRIE.OPTIONS.OF_RESCUABLE, STRINGS.MOD_VALKYRIE.OPTIONS.OF_RESCUABLE_DESC, {noUpdate=true} )
	modApi.requirements = {}
end

local function initStrings( modApi )
	local dataPath = modApi:getDataPath()
	local scriptPath = modApi:getScriptPath()
	
	local MOD_STRINGS = include( scriptPath .. "/strings" )
	modApi:addStrings( dataPath, "MOD_VALKYRIE", MOD_STRINGS )
end

local function load( modApi, options, params, mod_options )
	local dataPath = modApi:getDataPath()
	local scriptPath = modApi:getScriptPath()
	
	KLEIResourceMgr.MountPackage( dataPath .. "/gui.kwad", "data" )

	if options["OF_RESCUABLE"].enabled then
		local agentdefs = include( scriptPath .. "/agentdefs" )
		for name, agentDef in pairs(agentdefs) do
			modApi:addAgentDef( name, agentDef, { name } )
		end

		local serverdefs = include( scriptPath .. "/serverdefs" )
		if serverdefs.TEMPLATE_AGENCY and serverdefs.TEMPLATE_AGENCY.unitDefsPotential then
			for i,unitDef in ipairs(serverdefs.TEMPLATE_AGENCY.unitDefsPotential) do
				modApi:addRescueAgent( unitDef )
			end
		end

		local animdefs = include( scriptPath .. "/animdefs" )
		for name, animDef in pairs(animdefs) do
			modApi:addAnimDef( name, animDef )
		end

		local itemdefs = include( scriptPath .. "/itemdefs" )
		for name, itemDef in pairs(itemdefs) do
			modApi:addItemDef( name, itemDef )
		end

		modApi:addAbilityDef( "strict_surveillance", scriptPath .."/strict_surveillance" )
		modApi:addAbilityDef( "throw_camera_launcher", scriptPath .."/throw_camera_launcher" )
		
		KLEIResourceMgr.MountPackage( dataPath .. "/anims.kwad", "data" )
	end
end

return
{
	init = init,
	initStrings = initStrings,
	load = load,
}