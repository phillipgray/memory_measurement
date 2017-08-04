class WholeJsonSingleBlobQuery
  def self.call
    company = Financial.where(company: '10001', year: 2010)
    data = company.first.data
    # data.map { |e| e.sort_by { |_,v| v['value'].to_i } }
    p data
  end
end
