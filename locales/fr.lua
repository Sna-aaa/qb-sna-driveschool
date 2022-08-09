local Translations = {
--Notifs
  you_paid = 'Vous avez payé $%{value}',
  passed_test = 'Vous avez réussi le test',
  failed_test = 'Vous avez raté le test',
  driving_test_complete = 'Test de conduite terminé',
  driving_too_fast = 'Vous roulez trop vite! Vitesse limite: %{value} km/h!',
  errors = 'Erreurs: %{value}/%{value2}',
  you_damaged_veh = 'Vous avez endommagé votre véhicule',
  not_enough_money = 'Vous n\'avez pas assez d\'argent',
  no_code = "Vous n'avez pas passé le code",
  goto_cityhall = "Allez à la mairie pour récupérer votre permis",
  license_updated = "Votre permis a été mis a jour",
      
  --Mission
  go_next_point = 'Allez vers le prochain point de passage!',
  in_town_speed = 'Entrée en ville, attention à votre vitesse! Vitesse limite: ~y~%{value}~s~ km/h',
  next_point_speed = 'Allez vers le prochain point de passage! Vitesse limite: ~y~%{value}~s~ km/h',
  stop_for_ped = 'Faites rapidement un ~r~stop~s~ pour le piéton qui ~y~traverse',
  good_lets_cont = '~g~Bien!~s~ continuons!',
  stop_look_left = 'Marquez rapidement un ~r~stop~s~ et regardez à votre ~y~gauche~s~. Vitesse limite: ~y~%{value}~s~ km/h',
  good_turn_right = '~g~Bien~s~! prenez à ~y~droite~s~ et suivez votre file',
  watch_traffic_lightson = 'Observez le traffic, ~y~allumez vos feux~s~!',
  stop_for_passing = 'Marquez le stop pour laisser passer les véhicules!',
  hway_time = "Il est temps d'aller sur l'autoroute'! Vitesse limite: ~y~%{value}~s~ km/h",
  gratz_stay_alert = 'Bravo, restez vigiliant!',

  --Menu
  theory_test = 'Examen du code',
  road_test_car = 'Examen de conduite [Voiture]',
  road_test_bike = 'Examen de conduite [Moto]',
  road_test_truck = 'Examen de conduite [Camion]',
  school_item = '$%{value}',
  driving_school = 'Ecole de conduite',

  --Misc
  driving_school_blip = 'Auto-école',
  drive_school_e = '[~g~E~w~] Auto-école',
-- press_open_menu = 'Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu',
}

--if not Lang then            --This test is only needed in locale en, please comment it on other languages

local templocale = Locale:new({
  phrases = Translations,
  warnOnMissing = true,
  locale = "fr"
}) 
if templocale then
  Lang = templocale
end

--end                         --Comment this line also