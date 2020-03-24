json.extract! patient, :id, :name, :document, :address, :telephone, :created_at, :updated_at
json.url patient_url(patient, format: :json)
