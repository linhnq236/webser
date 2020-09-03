require 'firebase_connect'
namespace :auto_ledcontroller do
  desc "auto control leds"
  task :auto_leds => :environment do
    date = DateTime.now.strftime("%Y-%m-%d %H:%M")
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    responses = firebase.get(FIREBASE_URL).body
    responses.each do |res|
      house_name =  res[0]
      res[1].each do |re|
        room_name = re[0]
        re[1].each do |r|
          chip = r[0]
          if r[1]['TURNOFF'] == date
            response = firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{chip}/STATUS": "OFF"})
          end
          if r[1]['TURNON'] == date
            response = firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{chip}/STATUS": "ON"})
          end
        end
      end
    end
  end
end
