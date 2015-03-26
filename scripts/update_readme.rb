#!/usr/bin/ruby

readme = File.read 'README.template.md'
members = File.readlines 'members.txt'

members.map! {|m|
    chess_dot_com_username, stack_exchange_id = m.split
    "[#{chess_dot_com_username}](http://stackexchange.com/users/#{stack_exchange_id})"
}

readme.gsub! '$MEMBERS$', '- ' + members * "\n- "

File.open('README.md', 'w') {|f|
    f.print readme
}

puts 'Done'
