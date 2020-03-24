json.extract! office_visit, :id, :date, :hour, :status, :payment_method, :treatment, :value, :upload, :created_at, :updated_at
json.url office_visit_url(office_visit, format: :json)
