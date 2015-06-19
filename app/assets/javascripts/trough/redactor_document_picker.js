if (!RedactorPlugins) var RedactorPlugins = {};

RedactorPlugins.documentPicker = function()
{
  return {
    init: function()
    {
      var button = this.button.add('document-picker', 'Add Document');
      this.button.setAwesome('document-picker', 'fa-file-o');
      this.button.addCallback(button, this.documentPicker.show);
    },
    show: function()
    {
      var self = this;
      // Save the redactor cursor position so we can restore it when the modal closes
      self.selection.save();
      RemoteModal.show(function(document) {
        var node = $('<a />');
        node.html(document.name);
        node.attr('href', document.url);

        //Add a marker to the node
        var marker = self.selection.getMarker();
        node.append(marker);

        //Restore the selection we saved before opening the modal
        self.selection.restore();

        var container = $("<div />").append(node);
        self.insert.htmlWithoutClean(container.html());

        //Show the redactor link modal
        self.link.show();
      });
    }
  };
};
