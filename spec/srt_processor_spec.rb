require "srt_processor/version"
require_relative "../lib/srt_processor"

module SrtProcessor
	
	describe Movie do
		
		# describe 'We should shift the time of the subtitles' do
		# 	context "if the file has been opened" do
		# 		it 'returns fizz' do
		# 			expect(fiz.translate(3)).to eq('Fizz')
		# 		end
		# 	end
		# end
		movie = Movie.new('/vagrant/ruby_exercices/srt_processor/spec/support/thewalkingdead.srt')

		describe 'We should open the subtitle file' do
			context "the file has been opened" do
				it 'should have 32699 characters' do
					expect(movie.contents.length).to eq(32699)
				end
			end
		end

		describe 'We should process the dialogs' do
			context 'the file has been processed' do

				it 'shoud have 463 scenes' do
					expect(movie.scenes.length).to eq(463)
				end
			end
		end

		describe 'We should process the different attributes of each scene' do
			
			context 'if we open the second scene' do
				it 'the id should be 2' do
					expect(movie.scenes[1].id).to eq("2")
				end

				it 'the start timeline should be 00:03:27,571' do
					expect(movie.scenes[1].start_time).to eq('00:03:27,571')
				end

				it 'the end timeline should be 00:03:29,651' do
					expect(movie.scenes[1].end_time).to eq('00:03:29,651')
				end

				it 'the text should be Little girl?' do
					expect(movie.scenes[1].text).to eq('Little girl?')
				end
			end
		end

		describe 'We want to be able shift the times of the scenes' do

			context 'if we want to shift the second scene by 1 second' do

				movie.scenes[1].shift_scene(1000)
				it 'the start timeline should be 00:03:28,571' do

					expect(movie.scenes[1].shifted_start_time).to eq('00:03:28,571')
				end

				it 'the end timeline should be 00:03:30,651' do
					
					expect(movie.scenes[1].shifted_end_time).to eq('00:03:30,651')
				end
			end

			context 'if we want to save the shifted times into a new file' do

				it 'the start time on the second scene should be XX' do

					Processor.do_shift(movie, 1000, 'thewalkingdead.srt')

					shiftedmovie = Movie.new('/vagrant/ruby_exercices/srt_processor/shifted_thewalkingdead.srt')
					expect(shiftedmovie.scenes[1].start_time).to eq('00:03:28,571')

				end
			end
		end
	end
end
