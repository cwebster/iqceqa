require 'open-uri'
require 'pp'

open('http://localhost:3000/statistic/TVITDN') do |f|
  if f.status = 2000 then
    pp "OK"
  else
    pp "error"
  end


end