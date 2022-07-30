local serverdefs = include( "modules/serverdefs" )

local TEMPLATE_AGENCY = 
{
	unitDefsPotential = {
		serverdefs.createAgent( "valkyrie", {"valkyrie_augment_strict_surveillance", "item_camera_launcher"} ),
	},
}
return
{
	TEMPLATE_AGENCY = TEMPLATE_AGENCY,
}