class DocumentInput < Formtastic::Inputs::CheckBoxesInput
  include Formtastic::Inputs::Base
  include Formtastic::Inputs::Base::Stringish
  include Formtastic::Inputs::Base::Placeholder
  def to_html
    input_wrapping do
      document_id = builder.object.send(method)
      document = Trough::Document.find_by_id(builder.object.send(method)) if document_id.present?
      input_html = ''

      input_html << <<-EOS
        <div class='#{'hide' if document.nil?} js-trough-document-editor'>
          <a href='#{Trough::Engine.routes.url_helpers.document_path(document) if document}' class='trough-document-link js-trough-document-link'>
            <i class='fa fa-file-o'></i>
            <span class='js-trough-document-name'>#{document.file_filename if document}</span>
            <span class='document-link__file-type'>&nbsp;</span>
          </a>
          <a class='btn btn-link js-trough-remove' href='#'>Remove</a>
          <a class='btn btn-link js-open-trough-modal' href='#'>Edit</a>
        </div>
      EOS
      input_html << "<a class='#{'hide' if document} btn btn-primary js-trough-document-chooser js-open-trough-modal'>Choose File</a>"

      label_html <<
      input_html.html_safe <<
      builder.hidden_field(method)
    end
  end
end
