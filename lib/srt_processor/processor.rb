require "srt_processor/version"

module SrtProcessor
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