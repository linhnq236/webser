json.extract! paytherent, :id, :senddate, :receivedate, :status, :created_at, :updated_at
json.url paytherent_url(paytherent, format: :json)
