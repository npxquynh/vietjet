module Features
	module PlaceHelpers
		def select_origin(position)
			select_place(0, position)
			name = find("#ctl00_UcRightV31_CbbOrigin_TextBox").value
			puts "\nFrom: " + name
			name
		end

		def select_destination(position)
			select_place(1, position)
			name = find("#ctl00_UcRightV31_CbbDepart_TextBox").value
			puts "To: " + name
			name
		end

		# type = 0: origin
		# type = 1: destination
		def select_place(type, position)
			page.all(".ajax__combobox_buttoncontainer")[type].click
			page.first(".ajax__combobox_itemlist").all("li")[position].click
		end

		def fill_in_date
			day = Date.today.day
			page.find("#ctl00_UcRightV31_TxtDepartDate").click
			page.all(".ui-state-default")[day].click
			page.find("#ctl00_UcRightV31_TxtReturnDate").click
			page.all(".ui-state-default")[day + 1].click
		end

		def turn_on_cheapest_fare
			check "ctl00_UcRightV31_ChkInfare"
		end

		def submit_form
			page.find("#ctl00_UcRightV31_BtSearch").click
		end

		def printout_cheap_fare(file_name = nil)
			filter_cheap_fare
			(1..14).each do |index|
				switch_to_next_month
				sleep 1
				filter_cheap_fare(file_name)
			end
		end

		def filter_cheap_fare(file_name = nil)
			content = ""
			within "#ctrValueViewerDepGrid" do
				content += <<-CONTENT
					puts "--> " + #{all("th")[1].text} + " - Khoi hanh"
				CONTENT

				all(".vvFare", :text => "3,000").each do |f|
					content += <<-CONTENT
						puts #{f.find(:xpath, '..').text}
					CONTENT
				end
			end

			within "#ctrValueViewerRetGrid" do
				content += <<-CONTENT
					puts "<== " + #{all("th")[1].text} + " - Tro ve"
				CONTENT

				all(".vvFare", :text => "3,000").each do |f|
					content += <<-CONTENT
						puts #{f.find(:xpath, '..').text}
					CONTENT
				end
			end

			if file_name
				target = "#{file_name}.txt"

				File.open(target, "a+") do |f|
					f.write(content)
				end
			end
		end

		def switch_to_next_month
			find("#ctrValueViewerRetGrid").find(".vvNext").find("a").click
			wait_for_ajax
			sleep 1
			find("#ctrValueViewerDepGrid").find(".vvNext").find("a").click
			wait_for_ajax
			sleep 1
		end

		def wait_for_ajax
		  Timeout.timeout(Capybara.default_wait_time) do
		    active = page.evaluate_script('jQuery.active')
		    until active == 0
		      active = page.evaluate_script('jQuery.active')
		    end
		  end
		end
	end
end