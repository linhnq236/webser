json.extract! report, :id, :title, :content, :rep_content, :mark, :created_at, :updated_at
json.url report_url(report, format: :json)
