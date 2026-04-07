comrep_sources = files(
  'src/comrep-core.vala',
  'src/comrep-export.vala',
  'src/comrep-sync-package.vala',
  'src/comrep-io.vala',
)

gxml_candidates = [
  dependency('gxml-0.20', required: false),
  dependency('gxml', required: false),
]

resolved_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gio-2.0'),
  dependency('gee-0.8'),
]

foreach d : gxml_candidates
  if d.found()
    resolved_deps += d
    break
  endif
endforeach

library(
  'comrep',
  comrep_sources,
  dependencies: resolved_deps,
  vala_header: 'comrep.h',
  vala_vapi: 'comrep.vapi',
  install: true,
)
