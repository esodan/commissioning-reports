using GLib;
using GXml;

namespace ComRep {
  /**
   * High-level XML input/output helpers for commissioning payloads.
   */
  public class XmlIO : Object {
    public static Export load_export (string path) throws Error {
      var doc = GXml.Document.from_file (path);
      var root = doc.document_element;
      if (root == null || root.local_name != "Export") {
        throw new ComRepError.INVALID_DOCUMENT ("Root element must be Export");
      }
      return (Export) root;
    }

    public static SyncPackage load_sync_package (string path) throws Error {
      var doc = GXml.Document.from_file (path);
      var root = doc.document_element;
      if (root == null || root.local_name != "SyncPackage") {
        throw new ComRepError.INVALID_DOCUMENT ("Root element must be SyncPackage");
      }
      return (SyncPackage) root;
    }

    public static void save_export (Export export_document, string path) throws Error {
      var doc = export_document.owner_document;
      if (doc == null) {
        throw new ComRepError.INVALID_DOCUMENT ("Export element has no owner document");
      }
      doc.write_file (path);
    }

    public static void save_sync_package (SyncPackage sync_package, string path) throws Error {
      var doc = sync_package.owner_document;
      if (doc == null) {
        throw new ComRepError.INVALID_DOCUMENT ("SyncPackage element has no owner document");
      }
      doc.write_file (path);
    }
  }
}
