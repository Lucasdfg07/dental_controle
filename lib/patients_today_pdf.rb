require 'prawn'

module PatientsTodayPdf
  PDF_OPTIONS = {
    # Escolhe o Page size como uma folha A4
    :page_size   => "A4",
    # Define o formato do layout como portrait (poderia ser landscape)
    :page_layout => :portrait,
    # Define a margem do documento
    :margin      => [120, 75],

    :background => "#{Rails.root.to_s}/app/assets/images/letterhead.png"
  }

  def self.office_visits office_visits
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      @cont = 0

      pdf.fill_color "40464e"
      pdf.move_down 40

      pdf.text "Listagem de consultas do dia", align: :center, size: 24
      pdf.move_down 30

      pdf.font_size 12
      
      data = [["Id", "Nome", "Data da consulta", "Tratamento realizado"]]
      
      office_visits.each do |office_visit|
        @cont = @cont + 1
        data += [ [@cont, office_visit.patient.name, office_visit.date,  
                  office_visit.treatment] ]
      end

      pdf.table(data, position: :center, :cell_style => {size: 12}, :header => true)

      pdf.number_pages "Gerado: #{(Time.now).strftime("%d/%m/%y as %H:%M")} - Página <page>", :start_count_at => 0, :page_filter => :all, :at => [pdf.bounds.right - 140, -50], :align => :right, :size => 8
    end
  end
 
end