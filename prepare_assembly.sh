#!/usr/bin/env bash

set -euo pipefail
#shopt -s inherit_errexit

BOARD=HALSPA

# Create a 1x1 "panel" with top and bottom rails

echo "↔️ Panelizing..."

kikit panelize \
    --layout 'grid; rows: 1; cols: 1; space: 2mm' \
    --tabs 'fixed; vwidth: 75mm; hwidth:66.5mm; vcount: 1; hcount: 1' \
    --cuts 'vcuts; layer: Edge.Cuts' \
    --framing 'frame; width: 5mm; space: 2 mm' \
    --tooling '4hole; hoffset: 2.5mm; voffset: 2.5mm; size: 1.152mm' \
    --fiducials '4fid; hoffset: 5mm; voffset: 3.85mm; coppersize: 2mm; opening: 1mm;' \
    --text 'simple; text: JLCJLCJLCJLC; anchor: mt; voffset: 2.5mm; hoffset: 20mm; hjustify: center; vjustify: center;' \
    --post 'millradius: 1mm' \
    ${BOARD}.kicad_pcb ${BOARD}-panel.kicad_pcb

echo "🔩 Generating fabrication files..."

kikit fab jlcpcb \
    --no-drc \
    --assembly \
    --no-autoname \
    --schematic ${BOARD}.kicad_sch \
    ${BOARD}-panel.kicad_pcb \
    assembly-panel
