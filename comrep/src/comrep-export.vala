using GLib;
using GXml;

namespace ComRep {
  public class Export : XmlElementBase {
    public string version {
      get { return this.get_attribute ("version"); }
      set { this.set_attribute ("version", value); }
    }

    public string? generated_at {
      get { return this.get_attribute ("generatedAt"); }
      set {
        if (value == null) {
          this.remove_attribute ("generatedAt");
        } else {
          this.set_attribute ("generatedAt", value);
        }
      }
    }

    public Gee.ArrayList<Report> reports () {
      var result = new Gee.ArrayList<Report> ();
      foreach (var child in child_elements ("Report")) {
        result.add ((Report) child);
      }
      return result;
    }
  }

  public class Report : XmlElementBase {
    public string id {
      get { return this.get_attribute ("id"); }
      set { this.set_attribute ("id", value); }
    }

    public string folio {
      get { return this.get_attribute ("folio"); }
      set { this.set_attribute ("folio", value); }
    }

    public string created_at {
      get { return this.get_attribute ("createdAt"); }
      set { this.set_attribute ("createdAt", value); }
    }

    public string status {
      get { return this.get_attribute ("status"); }
      set { this.set_attribute ("status", value); }
    }

    public string title {
      get { return child_text ("Title") ?? ""; }
      set { set_child_text ("Title", value); }
    }

    public AssetRef? asset_ref () {
      return (AssetRef?) child_element ("AssetRef");
    }

    public Tests? tests () {
      return (Tests?) child_element ("Tests");
    }
  }

  public class AssetRef : XmlElementBase {
    public string cim_id {
      get { return child_text ("CIM_ID") ?? ""; }
      set { set_child_text ("CIM_ID", value); }
    }

    public string? ifc_id {
      get { return child_text ("IFC_ID"); }
      set {
        if (value != null) {
          set_child_text ("IFC_ID", value);
        }
      }
    }
  }

  public class Tests : XmlElementBase {
    public Gee.ArrayList<Test> items () {
      var result = new Gee.ArrayList<Test> ();
      foreach (var child in child_elements ("Test")) {
        result.add ((Test) child);
      }
      return result;
    }
  }

  public class Test : XmlElementBase {
    public string id {
      get { return this.get_attribute ("id"); }
      set { this.set_attribute ("id", value); }
    }

    public string status {
      get { return this.get_attribute ("status"); }
      set { this.set_attribute ("status", value); }
    }

    public string name {
      get { return child_text ("Name") ?? ""; }
      set { set_child_text ("Name", value); }
    }

    public Measurements? measurements () {
      return (Measurements?) child_element ("Measurements");
    }
  }

  public class Measurements : XmlElementBase {
    public Gee.ArrayList<Measurement> items () {
      var result = new Gee.ArrayList<Measurement> ();
      foreach (var child in child_elements ("Measurement")) {
        result.add ((Measurement) child);
      }
      return result;
    }
  }

  public class Measurement : XmlElementBase {
    public string id {
      get { return this.get_attribute ("id"); }
      set { this.set_attribute ("id", value); }
    }

    public string parameter {
      get { return child_text ("Parameter") ?? ""; }
      set { set_child_text ("Parameter", value); }
    }

    public string? measured_value_text {
      get { return child_text ("MeasuredValueText"); }
      set {
        if (value != null) {
          set_child_text ("MeasuredValueText", value);
        }
      }
    }
  }
}
