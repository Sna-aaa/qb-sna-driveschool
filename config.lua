local QBCore = exports['qb-core']:GetCoreObject()
Config                 = {}
Config.DrawDistance    = 100.0
Config.MaxErrors       = 5
Config.SpeedMultiplier = 3.6

Config.Licenses = {
	thdriver	= {name = Lang:t("theory_test"),		price = 500},
	driver		= {name = Lang:t("road_test_car"),		price = 2500},
	bike  		= {name = Lang:t("road_test_bike"),		price = 3000},
	truck		= {name = Lang:t("road_test_truck"),	price = 5000},
}

Config.VehicleModels = {
	driver       = 'blista',
	bike  		 = 'sanchez',
	truck 		 = 'mule3'
}

Config.SpeedLimits = {
	residence = 50,
	town      = 80,
	freeway   = 120
}

Config.Zones = {

	DMVSchool = {
		Pos   = vector3(214.95, -1398.28, 30.58),
	},

	VehicleSpawnPoint = {
		Pos   = vector4(249.409, -1407.230, 30.4094, 317.0),
	}

}

Config.CheckPoints = {

	{
		Pos = {x = 255.139, y = -1400.731, z = 29.537},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t('next_point_speed', {value = Config.SpeedLimits['residence']}), 5000)
		end
	},

	{
		Pos = {x = 271.874, y = -1370.574, z = 30.932},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t("go_next_point"), 5000)
		end
	},

	{
		Pos = {x = 234.907, y = -1345.385, z = 29.542},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Citizen.CreateThread(function()
				DrawMissionText(Lang:t("stop_for_ped"), 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Wait(4000)

				FreezeEntityPosition(vehicle, false)
				DrawMissionText(Lang:t("good_lets_cont"), 5000)
			end)
		end
	},

	{
		Pos = {x = 217.821, y = -1410.520, z = 28.292},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')

			Citizen.CreateThread(function()
				DrawMissionText(Lang:t('stop_look_left', {value = Config.SpeedLimits['town']}), 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Wait(6000)

				FreezeEntityPosition(vehicle, false)
				DrawMissionText(Lang:t("good_turn_right"), 5000)
			end)
		end
	},

	{
		Pos = {x = 178.550, y = -1401.755, z = 27.725},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t("watch_traffic_lightson"), 5000)
		end
	},

	{
		Pos = {x = 113.160, y = -1365.276, z = 27.725},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t("go_next_point"), 5000)
		end
	},

	{
		Pos = {x = -73.542, y = -1364.335, z = 27.789},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t("stop_for_passing"), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = -355.143, y = -1420.282, z = 27.868},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t("go_next_point"), 5000)
		end
	},

	{
		Pos = {x = -439.148, y = -1417.100, z = 27.704},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t("go_next_point"), 5000)
		end
	},

	{
		Pos = {x = -453.790, y = -1444.726, z = 27.665},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('freeway')

			DrawMissionText(Lang:t('hway_time', {value = Config.SpeedLimits['freeway']}), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = -463.237, y = -1592.178, z = 37.519},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t("go_next_point"), 5000)
		end
	},

	{
		Pos = {x = -900.647, y = -1986.28, z = 26.109},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t("go_next_point"), 5000)
		end
	},

	{
		Pos = {x = 1225.759, y = -1948.792, z = 38.718},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t("go_next_point"), 5000)
		end
	},

	{
		Pos = {x = 1225.759, y = -1948.792, z = 38.718},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')
			DrawMissionText(Lang:t('in_town_speed', {value = Config.SpeedLimits['town']}), 5000)
		end
	},

	{
		Pos = {x = 1163.603, y = -1841.771, z = 35.679},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(Lang:t("gratz_stay_alert"), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 235.283, y = -1398.329, z = 28.921},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			QBCore.Functions.DeleteVehicle(vehicle)
		end
	}

}
