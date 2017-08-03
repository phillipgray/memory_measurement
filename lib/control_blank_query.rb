class ControlBlankQuery
  def self.call
    Financial.where(id: nil)
  end
end
