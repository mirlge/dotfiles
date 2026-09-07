//@ pragma UseQApplication
//@ pragma IconTheme kora
import Quickshell
import QtQuick
import qs.modules

ShellRoot {
  Bar { id: bar }
  Notifications { id: notifications }
  Controls { id: controls }
}
