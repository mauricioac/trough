if (!RedactorPlugins) var RedactorPlugins = {};

RedactorPlugins.documentPicker = function()
{
  return {
    highlightedTitle: "",
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
      this.documentPicker.highlightedTitle = self.selection.getText();
      RemoteModal.show(function(document) {
        var node = $('<a />');
        var title = self.documentPicker.highlightedTitle || document.name
        var url = document.url;
        node.html(title);
        node.attr('href', url);

        //Add a marker to the node
        var marker = self.selection.getMarker();
        node.append(marker);

        //Restore the selection we saved before opening the modal
        self.selection.restore();

        var container = $("<div />").append(node);
        self.insert.htmlWithoutClean(container.html());

        //Show the redactor link modal
        self.link.set(title, url)
        self.link.show();
      });
    }
  };
};
