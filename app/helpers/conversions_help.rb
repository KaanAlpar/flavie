module ConversionsHelper
  def get_conversion(id)
    Conversion.find(id)
  end
end
