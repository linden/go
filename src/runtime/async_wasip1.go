package runtime

import "internal/runtime/sys"

func suspend(sp uintptr)

func Suspend() {
	suspend(sys.GetCallerSP() - 16)
}
