using GLib;
using GXml;

namespace ComRep {
  public const string XML_NS = "https://cfe.gob.mx/commissioning/reports";

  public errordomain ComRepError {
    INVALID_DOCUMENT,
    MISSING_REQUIRED_ELEMENT
  }

  public class XmlElementBase : GXml.Element {
    public XmlElementBase () {
    }

    protected string? child_text (string name) {
      var nodes = this.child_nodes;
      for (var i = 0; i < nodes.length; i++) {
        var child = nodes.item (i) as GXml.Element;
        if (child != null && child.local_name == name) {
          return child.text_content;
        }
      }
      return null;
    }

    protected void set_child_text (string name, string value) {
      var nodes = this.child_nodes;
      for (var i = 0; i < nodes.length; i++) {
        var child = nodes.item (i) as GXml.Element;
        if (child != null && child.local_name == name) {
          child.text_content = value;
          return;
        }
      }

      var owner = this.owner_document;
      if (owner == null) {
        return;
      }

      var element = owner.create_element_ns (XML_NS, name);
      element.text_content = value;
      this.append_child (element);
    }

    protected GXml.Element? child_element (string name) {
      var nodes = this.child_nodes;
      for (var i = 0; i < nodes.length; i++) {
        var child = nodes.item (i) as GXml.Element;
        if (child != null && child.local_name == name) {
          return child;
        }
      }
      return null;
    }

    protected Gee.ArrayList<GXml.Element> child_elements (string name) {
      var list = new Gee.ArrayList<GXml.Element> ();
      var nodes = this.child_nodes;
      for (var i = 0; i < nodes.length; i++) {
        var child = nodes.item (i) as GXml.Element;
        if (child != null && child.local_name == name) {
          list.add (child);
        }
      }
      return list;
    }
  }
}
