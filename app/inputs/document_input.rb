class DocumentInput < Formtastic::Inputs::CheckBoxesInput
    include Formtastic::Inputs::Base
    include Formtastic::Inputs::Base::Stringish
    include Formtastic::Inputs::Base::Placeholder
    def to_html
       input_wrapping do
         label_html <<
         "<a class='btn btn-primary js-open-trough-modal'>Choose File</a>
         #{builder.hidden_field method}".html_safe
       end
    end
  end
