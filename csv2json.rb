require 'json'
inp = File.new(ARGV[0],"r")                     ## input(csv) and output file taking as command line argument
outer_hash=Hash.new()
while line = inp.gets
  if line =~ /-------- \d/			## identifier for sheet after conversion from .xlsx tro .csv file
    sheet=line.downcase.scan(/[\w]+/)[1]
    ar=Array.new				## array for each sheet
    line = inp.gets
    key_list=line.strip.split(",")		## assumption each sheet will have labels in 1st row. Extracting lable

  else
    inner_hash=Hash.new()			## creating a hash for each row
    word_list=line.strip.split(",")
    i=0
    for key in key_list
      if key.strip != ""	
        inner_hash[key]=word_list[i] 			
      end
      i+=1
    end
    ar.push(inner_hash)				## pushing the hash in array 
    outer_hash[sheet]=ar			## assigning array to corrosponding sheet
  end
end
out = File.new(ARGV[1],"w")
out.puts outer_hash.to_json			## Converting output to json and writing in file 
