module ApplicationHelper
  def isEmail(str)
    return str.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]+\.)[a-zA-Z]{2,4}/)
  end
end
