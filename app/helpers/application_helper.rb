module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | LevEhad"      
    end
  end
end
