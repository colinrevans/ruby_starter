# typed: strict

require "sinatra"
require "sinatra/cors"

set :allow_origin, "http://localhost:8000"
set :allow_methods, "GET"

groups = File.read("groups.txt").each_line.map(&:strip)

get "/" do
  group = groups.sample

  return "no group found." if group.nil? || groups.empty?

  history = File.open("history.txt", "a")
  history.write(group + "\n")
  history.close

  return(
    "#{group}<br /><br /><a target=\"_blank\" rel=\"noopener noreferrer\" href=\"https://en.wikipedia.org/wiki/#{group}\">WIKIPEDIA</a>
        <br /><br />
          <a target=\"_blank\" rel=\"noopener noreferrer\" href=\"https://www.jstor.org/action/doBasicSearch?Query=#{group}\">JSTOR</a>
          <br /><br />
          <a target=\"_blank\" rel=\"noopener noreferrer\" href=\"https://www.wikidata.org/w/index.php?go=Go&search=#{group}&search=#{group}&title=Special%3ASearch&ns0=1&ns120=1\">WIKIDATA</a>
          <br /><br /><br /><br />
          <a href=\"/history\">HISTORY</a>
  "
  )
end

get "/history" do
  history = File.read("history.txt").each_line.map(&:strip).reverse!

  return history.join(", ")
end
