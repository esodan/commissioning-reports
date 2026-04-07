# comrep (Vala/GXml)

`comrep` is a starter Vala library for commissioning XML payloads defined by:

- `schemas/Export.xsd`
- `schemas/SyncPackage.xsd`

## Namespace

All API is under:

- `ComRep`

## Main components

- `ComRep.Export` / `ComRep.Report` / `ComRep.AssetRef` / `ComRep.Test`
- `ComRep.SyncPackage` / `ComRep.Catalog` / `ComRep.Project`
- `ComRep.XmlIO` for loading and saving XML files.

## Build

```bash
meson setup build
meson compile -C build
```

