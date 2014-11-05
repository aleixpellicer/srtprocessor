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
end