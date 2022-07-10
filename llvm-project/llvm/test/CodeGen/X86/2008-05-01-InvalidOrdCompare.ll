; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -enable-unsafe-fp-math -mtriple=i686-- | FileCheck %s
; rdar://5902801

declare void @test2()

define i32 @test(double %p) nounwind {
; CHECK-LABEL: test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-NEXT:    fucomp %st(0)
; CHECK-NEXT:    fnstsw %ax
; CHECK-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-NEXT:    sahf
; CHECK-NEXT:    jp .LBB0_1
; CHECK-NEXT:  # %bb.2: # %UnifiedReturnBlock
; CHECK-NEXT:    movl $42, %eax
; CHECK-NEXT:    retl
; CHECK-NEXT:  .LBB0_1: # %bb
; CHECK-NEXT:    calll test2
; CHECK-NEXT:    movl $17, %eax
; CHECK-NEXT:    retl
	%tmp5 = fcmp uno double %p, 0.000000e+00
	br i1 %tmp5, label %bb, label %UnifiedReturnBlock
bb:
	call void @test2()
	ret i32 17
UnifiedReturnBlock:
	ret i32 42
}
