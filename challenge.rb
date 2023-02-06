def group_photos_by_city(photos)
  photos_by_city = {}
  photos.each do |photo|
    name, city, datetime = photo.split(", ")
    photos_by_city[city] ||= []
    photos_by_city[city] << [name, datetime]
  end
  photos_by_city
end

def sort_photos_by_date(photos_by_city)
  photos_by_city.each do |city, city_photos|
    city_photos.sort_by!{|photo| photo[1]}
  end
end

def find_index_in_city_by_filename(filename, city, photos )
  photos[city].each_with_index do |photo, index|
    length = photos[city].length.to_s.length
    return "#{format("%0#{length}d", index+1)}" if photo[0] == filename
  end
  nil
end

def find_index_in_city_by_datetime(datetime, city, photos )
  photos[city].each_with_index do |photo, index|
    length = photos[city].length.to_s.length
    return "#{format("%0#{length}d", index+1)}" if photo[1] == datetime
  end
  nil
end

def solution(s)
  photos = s.split("\n")

  photos_by_city = group_photos_by_city(photos)
  sorted_photos = sort_photos_by_date(photos_by_city)

  result = []

  photos.each do | photo |
    filename, city, datetime = photo.split(", ")
    index = find_index_in_city_by_datetime(datetime, city, sorted_photos)
    extension = filename.split(".")[1]
    result << "#{city}#{index}.#{extension}" unless index.nil?
  end
  result.join("\n")
end

test1 = "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"

test2 = "notredame.png, Florianopolis, 2015-09-02 12:00:00
photo.jpg, Krakow, 2013-09-05 14:08:15
notredame.png, Florianopolis, 2015-09-01 12:00:00"

puts solution(test2)
