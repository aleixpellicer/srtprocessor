require "srt_processor/version"

module SrtProcessor
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
end