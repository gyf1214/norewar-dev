$ENV = :test
require 'bundler'
Bundler.require :default, $ENV

require_all 'judge'

module Judge
	def self.help(args = [])
		puts 'Usage: ./run { help | run <data file> }'
	end

	def self.run(line)
		case line[0]
		when 'next'
			i = if line[1].nil? then 1 else line[1].to_i end
			i.times do
				@match.next_frame
			end
			@match.print
		when 'print'
			@match.print
		when 'code'
			robot = @match.map[line[1].to_i][line[2].to_i]
			return if robot.nil?
			seek = if line[3].nil? then robot.seek else line[3].to_i end
			puts "::#{seek}"
			for i in (seek - 10)..(seek + 10)
				unless i < 0 || robot.code[i].nil?
					print(if i == seek then ">" else " " end)
					printf "%4d ", i
					puts robot.code[i]
				end
			end
		puts
	end

	def self.start(args = [])
		return help if args[0].nil?
		str = ''
		File.foreach(args[0]) do |line|
			str += line
		end
		data = JSON.parse str
		codes = []
		data['competitors'].each do |competitor|
			str = ''
			File.foreach(competitor) do |line|
				str += line
			end
			codes.push str
		end
		@match = Match.new(codes)
		printf '> '
		line = STDIN.gets.chomp.strip
		until line == 'quit'
			run line.split
			printf '> '
			line = STDIN.gets.chomp.strip
		end
	end
end
