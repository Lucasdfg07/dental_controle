module GraphHelper
	def week_data
	    (4.weeks.ago.to_date..Date.today).map do |date| {
	      created_at: date,
	      collected: parcels_value(date),
	      spent: spent_value(date)
	    }
	    end
  	end

  	def month_data
	    (4.months.ago.to_date..Date.today).map do |date| {
	      created_at: date,
	      collected: parcels_value(date),
	      spent: spent_value(date)
	    }
	    end
  	end

  	def annual_data
	    (4.years.ago.to_date..Date.today).map do |date| {
	      created_at: date,
	      collected: parcels_value(date),
	      spent: spent_value(date)
	    }
	    end
  	end

  	def parcels_value(date)
  		OfficeVisit.joins(:patient).joins(:parcels).where("date(office_visits.created_at) = ? AND patients.user_id = ?", date, current_user.id).count
  	end

  	def spent_value(date)
  		Spent.where("date(created_at) = ? AND user_id = ?", date, current_user.id).sum(:value)
  	end
end
