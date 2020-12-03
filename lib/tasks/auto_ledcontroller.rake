require 'firebase_connect'
namespace :auto_ledcontroller do
  desc "auto control leds"
  task :auto_leds => :environment do
    date = DateTime.now.strftime("%Y-%m-%d %H:%M")
    time = DateTime.now.strftime("%H:%M")
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    responses = firebase.get(FIREBASE_URL).body
    responses.each do |res|
      house_name =  res[0]
      res[1].each do |re|
        room_name = re[0]
        re[1].each do |r|
          chip = r[0]
          if r[1]['turnoff'] == date
            response = firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{chip}/status": "off"})
          end
          if r[1]['turnon'] == date
            response = firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{chip}/status": "on"})
          end
          # if r[1]['time'] == time
          #   response = firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{chip}/status": "on"})
          # end
        end
      end
    end
  end

  task :insert_time => :environment do
    date = DateTime.now.strftime("%Y-%m-%d %H:%M")
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    responses = firebase.get(FIREBASE_URL).body
    responses.each do |res|
      house_name =  res[0]
      res[1].each do |re|
        room_name = re[0]
        re[1].each do |r|
          chip = r[0]
          response = firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{chip}/time": "00:00"})
        end
      end
    end
  end
  task :leds => :environment do
    date = DateTime.now.strftime("%Y-%m-%d %H:%M")
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    responses = firebase.get(FIREBASE_URL).body
    leds = responses['90DODOCLOC']["Phong2"]
    house_name = "90DODOCLOC"
    room_name = "Phong1"
    equiment_status = "6"
    leds.each do |res|
      puts res[1]['active']
      if res[1]['kind'] == "1" && equiment_status == "2"
        firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "on"})
      elsif res[1]['kind'] == "1" && equiment_status == "3"
        firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "off"})
      elsif res[1]['kind'] == "2" && equiment_status == "4"
        firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "on"})
      elsif res[1]['kind'] == "2" && equiment_status == "5"
        firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "off"})
      elsif res[1]['kind'] == "3" && equiment_status == "6"
        firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "on"})
      elsif res[1]['kind'] == "3" && equiment_status == "7"
        firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "off"})
      end
    end
  end
end
