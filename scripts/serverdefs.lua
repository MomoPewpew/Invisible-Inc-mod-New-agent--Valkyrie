local serverdefs = include( "modules/serverdefs" )

local TEMPLATE_AGENCY = 
{
	unitDefsPotential = {
		serverdefs.createAgent( "valkyrie", {"placeHolderName2"} ),
	},
}
return
{
	TEMPLATE_AGENCY = TEMPLATE_AGENCY,
}