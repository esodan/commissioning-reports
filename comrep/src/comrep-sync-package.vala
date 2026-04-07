using GLib;
using GXml;

namespace ComRep {
  public class SyncPackage : XmlElementBase {
    public string version {
      get { return this.get_attribute ("version"); }
      set { this.set_attribute ("version", value); }
    }

    public string source_format {
      get { return this.get_attribute ("sourceFormat"); }
      set { this.set_attribute ("sourceFormat", value); }
    }

    public Catalog? catalog () {
      return (Catalog?) child_element ("Catalog");
    }

    public Project? project () {
      return (Project?) child_element ("Project");
    }
  }

  public class Catalog : XmlElementBase {
    public string version {
      get { return this.get_attribute ("version"); }
      set { this.set_attribute ("version", value); }
    }
  }

  public class Project : XmlElementBase {
    public string id {
      get { return this.get_attribute ("id"); }
      set { this.set_attribute ("id", value); }
    }

    public string code {
      get { return child_text ("Code") ?? ""; }
      set { set_child_text ("Code", value); }
    }

    public string name {
      get { return child_text ("Name") ?? ""; }
      set { set_child_text ("Name", value); }
    }
  }

  public class Asset : XmlElementBase {
    public string id {
      get { return this.get_attribute ("id"); }
      set { this.set_attribute ("id", value); }
    }

    public string cim_id {
      get { return child_text ("CIM_ID") ?? ""; }
      set { set_child_text ("CIM_ID", value); }
    }
  }

  public class TestDefinition : XmlElementBase {
    public string id {
      get { return this.get_attribute ("id"); }
      set { this.set_attribute ("id", value); }
    }

    public string gguid {
      get { return this.get_attribute ("gguid"); }
      set { this.set_attribute ("gguid", value); }
    }

    public string code {
      get { return child_text ("Code") ?? ""; }
      set { set_child_text ("Code", value); }
    }

    public string name {
      get { return child_text ("Name") ?? ""; }
      set { set_child_text ("Name", value); }
    }
  }
}
