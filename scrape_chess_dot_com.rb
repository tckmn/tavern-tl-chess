#!/usr/bin/ruby

require 'open-uri'

def progress a, b
    len = b.to_s.length
    print "#{(a+1).to_s.rjust len, ?0} of #{b}#{?\b * (len + 4 + len)}"
end

print 'Retrieving game IDs... '
ids = []
members = Hash[File.readlines('members.txt').map &:split]
members.keys.each_with_index do |m, i|
    progress i, members.length
    # NOTE: this does not take into account pagination.
    # remember to run in regularly; otherwise a game might fall off the page :)
    html = open("http://www.chess.com/home/game_archive?show=echess&member=#{m.split[0]}").read
    ids += html.scan(/game\?id=(\d+)/).map(&:first)
end
puts

print 'Downloading PGN files... '
ids.uniq!.reject! { |id| File::exist? "pgn/#{id}.pgn" }
ids.each_with_index do |id, i|
    progress i, ids.length
    pgn = open("http://www.chess.com/echess/download_pgn?id=#{id}").read
    if pgn.scan(/\[(?:White|Black) "([^"]+)"\]/).all? { |x| members.keys.include? x[0] }
        open "pgn/#{id}.pgn", 'wb' do |f|
            f << pgn
        end
    end
end
puts

puts 'Done'
