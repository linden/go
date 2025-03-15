// Copyright 2023 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

#include "go_asm.h"
#include "textflag.h"

TEXT _rt0_wasm_wasip1(SB),NOSPLIT,$0
	I32Const $wasm_export_resume(SB)
	Drop
	I32Const $wasm_export_getsuspend(SB)
	Drop

	MOVD $runtime·wasmStack+(m0Stack__size-16)(SB), SP

	I32Const $0 // entry PC_B
	Call runtime·rt0_go(SB)
	Drop
	Call wasm_pc_f_loop(SB)

	Return

TEXT _rt0_wasm_wasip1_lib(SB),NOSPLIT,$0
	Call _rt0_wasm_wasip1(SB)
	Return

TEXT wasm_export_resume(SB),NOSPLIT,$0
	Call wasm_pc_f_loop(SB)

	Return

TEXT wasm_export_getsuspend(SB),NOSPLIT,$0
	Get SUSPEND
	Return

// TODO: call `runtime.pause` here directly.
TEXT runtime·suspend(SB), NOSPLIT, $0-8
	MOVD newsp+0(FP), SP

	I32Const $1
	Set SUSPEND

	I32Const $1
	Set PAUSE
	
	RETUNWIND
