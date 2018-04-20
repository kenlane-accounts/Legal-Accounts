json.extract! transfer, :id, :type, :date, :reference, :amount, :fromdetails, :frombank_id, :fromnominal_id, :todetails, :tobank_id, :tonominal_id, :created_at, :updated_at
json.url transfer_url(transfer, format: :json)
