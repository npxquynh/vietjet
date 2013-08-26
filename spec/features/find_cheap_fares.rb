require 'spec_helper'

feature "visit homepage", js: :true do
	scenario "find cheap fare for all routes" do
		no_of_destinations = 10
		(4..no_of_destinations).each do |index|
			visit 'http://www.vietjetair.com/Sites/Web/vi-VN/Home'
			origin = select_origin(1)
			sleep 2
			destination = select_destination(index)

			# common steps
			fill_in_date
			turn_on_cheapest_fare
			submit_form

			wait_for_ajax

			file_name = origin + " - " + destination

			printout_cheap_fare(file_name)
		end
	end
end

# 1 Ha Noi
# 2 Da Nang
# 3 Hai Phong
# 4 Nha Trang
# 5 Hue
# 6 Vinh
# 7 Phu Quoc
# 8 Bangkok
# 9 Buon Ma Thuot
# 10 Qui Nhon