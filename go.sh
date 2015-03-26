#!/bin/bash
echo '### SCRAPE CHESS.COM ###'
./scripts/scrape_chess_dot_com.rb
echo '### UPDATE README ###'
./scripts/update_readme.rb
