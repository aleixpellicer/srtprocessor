require "srt_processor/version"

module SrtProcessor
	class Movie
    attr_accessor :scenes,:contents
		def initialize(file)
			@file = file
      self.read
      @scenes = []
      self.create_scenes
		end
		def read
			@contents = IO.read(@file)
		end
		def create_scenes
			scenes_as_strings = @contents.split("\r\n\r\n")

      scenes_as_strings.each do |scene_as_string|
        lines = scene_as_string.split("\r\n")
        id = lines.delete_at(0)
        times = lines.delete_at(0)
        times = times.scan(/\d{2}[:]\d{2}[:]\d{2}[,]\d{3}/)
        text = lines.join("\r\n")

        @scenes << Scene.new(id,times[0],times[1],text) 

      end
		end
	end

  class Scene
    attr_accessor :id, :start_time, :end_time, :text, :shifted_start_time, :shifted_end_time
    def initialize(id,start_time,end_time,text)
      @id = id
      @start_time = start_time
      @end_time = end_time
      @text = text
      @shifted_start_time
      @shifted_end_time
    end
    def shift_scene(shiftAmmount)
      @shifted_start_time = TimeProcess.timestamp(TimeProcess.totalmilliseconds(@start_time) + shiftAmmount)
      @shifted_end_time = TimeProcess.timestamp(TimeProcess.totalmilliseconds(@end_time) + shiftAmmount)
    end
  end

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

  class Processor

    def self.do_shift(movie, shiftAmmount, output_file)
      
      file_contents = ""

      movie.scenes.each do |scene|
        scene.shift_scene(shiftAmmount)
        
        file_contents << scene.id << "\r\n"
        file_contents << scene.shifted_start_time << " --> " << scene.shifted_end_time << "\r\n"
        file_contents << scene.text << "\r\n\r\n"  

      end
      dest_file = "shifted_#{output_file}"
      IO.write(dest_file, file_contents)

    end

  end

end