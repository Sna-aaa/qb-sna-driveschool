# qb-sna-driveschool
Realistic Drive School for QB-Core, forked from esx_dmvschool

## Requirements
- [qb-core](https://github.com/qbcore-framework/qb-core)

## Installation
- Change this in qb-core/server/player.lua to have licences available
```
    PlayerData.metadata['licences'] = PlayerData.metadata['licences'] or {
        ['driver'] = false,                                                         --Change
        ['business'] = false,
        ['weapon'] = false, 
        ['bike'] = false,                                                           --Add
        ['truck'] = false,                                                          --Add
        ['thdriver'] = false,                                                       --Add
    }
```
- Add this in qb-core/shared/items.lua for the theorical permit
```
	--DriveShool permit
	['driving_test_permit'] 				 = {['name'] = 'driving_test_permit',				['label'] = 'Driving Test Permit',			['weight'] = 0,			['type'] = 'item',		['image'] = 'dmv.png',		['unique'] = true,		['useable'] = true,		['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Permite for Driving Test'},
```

- Insert images from /img into qb-inventory\html\images

- Add this in your `server.cfg`:
```
start qb-sna-driveschool
```

# Credits
Credits to :
esx_dmvschool - realistic DMV school for ESX
