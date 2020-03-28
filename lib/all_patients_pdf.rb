require 'prawn'

module AllPatientsPdf
  PDF_OPTIONS = {
    # Escolhe o Page size como uma folha A4
    :page_size   => "A4",
    # Define o formato do layout como portrait (poderia ser landscape)
    :page_layout => :portrait,
    # Define a margem do documento
    :margin      => [120, 75],

    :background => "#{Rails.root.to_s}/app/assets/images/letterhead.png"
  }

  def self.patients patients
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
        @cont = 0

        pdf.fill_color "40464e"
        pdf.move_down 40

        pdf.text "Listagem geral de Pacientes", align: :center, size: 24
        pdf.move_down 30

        pdf.font_size 12
        
        data = [["Id", "Nome", "CPF", "Telefone", "Endereço"]]
        patients.each do |patient|
          @cont = @cont + 1
          data += [ [@cont, patient.name, patient.document,  
                    patient.telephone, patient.address] ]
        end

        pdf.table(data, position: :center, :cell_style => {size: 12}, :header => true)

        pdf.number_pages "Gerado: #{(Time.now).strftime("%d/%m/%y as %H:%M")} - Página <page>", :start_count_at => 0, :page_filter => :all, :at => [pdf.bounds.right - 140, -50], :align => :right, :size => 8
    end
  end
 
end