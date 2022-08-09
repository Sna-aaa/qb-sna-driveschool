local Translations = {
    you_paid = 'You paid $%{value}',
  go_next_point = 'Go to the next point!',
  in_town_speed = 'You enter in town, watch your speed! Limit speed: ~y~%{value}~s~ km/h',
  next_point_speed = 'Go to the next point! Limit speed: ~y~%{value}~s~ km/h',
  stop_for_ped = 'Please ~r~stop~s~ for the pedestrian that ~y~cross',
  good_lets_cont = '~g~Good!~s~ Continue!',
  stop_look_left = '~r~Stop~s~ and look ~y~left~s~. Limit speed: ~y~%{value}~s~ km/h',
  good_turn_right = '~g~Good!~s~ Take next ~y~right~s~ and follow your lane',
  watch_traffic_lightson = 'Watch the traffic, ~y~Open you headlight~s~!',
  stop_for_passing = 'Stop and let vehicles pass!',
  hway_time = 'Time to go on the highway! Limit speed: ~y~%{value}~s~ km/h',
  gratz_stay_alert = 'Nice, stay alert!',
  passed_test = 'You ~g~passed~s~ the test',
  failed_test = 'You ~r~fail~s~ the test',
  theory_test = 'Theory test',
  road_test_car = 'Driving test [Car]',
  road_test_bike = 'Driving test [Bike]',
  road_test_truck = 'Driving test [Truck]',
  school_item = '$%{value}',
  driving_school = 'Driving School',
  press_open_menu = 'Press ~INPUT_CONTEXT~ to open the menu',
  driving_school_blip = 'Drive School',
  driving_test_complete = 'Drive test finished',
  driving_too_fast = 'You are riding too fast! Limit speed: ~y~%{value}~s~ km/h!',
  errors = 'Errors: ~r~%{value}~s~/%{value2}',
  you_damaged_veh = 'You damaged the vehicle',
  not_enough_money = 'You have not enough money',
  drive_school_e = '[~g~E~w~] Drive School',
}

if not Lang then            --This test is only needed in locale en, please comment it on other languages

  local templocale = Locale:new({
      phrases = Translations,
      warnOnMissing = true,
      locale = "en"
  }) 
  if templocale then
      Lang = templocale
  end
  
end                         --Comment this line also
