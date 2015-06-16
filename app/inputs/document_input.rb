class DocumentInput < Formtastic::Inputs::CheckBoxesInput
    include Formtastic::Inputs::Base
    include Formtastic::Inputs::Base::Stringish
    include Formtastic::Inputs::Base::Placeholder
    def to_html
       input_wrapping do
         label_html <<
         "<div class='modal fade trough-modal js-trough-modal' id='modal-#{method}' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
            <div class='modal-dialog'>
              <div class='modal-content'>

              </div>
            </div>
          </div>".html_safe <<
         "<a class='btn btn-primary' data-toggle='modal' data-target='#modal-#{method}'>Choose File</a>
         #{builder.hidden_field method}".html_safe
       end
    end
  end
