require "srt_processor/version"

module SrtProcessor
  class TimeProcess
    def self.hours(time)
      time.split(":")[0].to_i
    end
    def self.minutes(time)
      time.split(":")[1].to_i
    end
    def self.seconds(time)
      time.split(":")[2].split(",")[0].to_i
    end
    def self.milliseconds(time)
      time.split(":")[2].split(",")[1].to_i
    end
    def self.totalmilliseconds(time)
      totalmilliseconds = (hours(time)*3600000)+(minutes(time)*60000)+(seconds(time)*1000)+milliseconds(time)
    end
    def self.timestamp(milliseconds)
      rest_milliseconds = milliseconds.to_s[-3,3]
      x = milliseconds / 1000
      seconds = (x % 60).to_s.rjust(2, "0")
      x /= 60
      minutes = (x % 60).to_s.rjust(2, "0")
      x /= 60
      hours = (x % 24).to_s.rjust(2, "0")
      time = "#{hours}:#{minutes}:#{seconds},#{rest_milliseconds}"
    end
  end
end