module TodosHelper
  def format_datetime(date)
    formatted_date = ""

    if date.present? 
      formatted_date = date.strftime('%m/%d/%Y')
    end
    
    formatted_date
  end
end
