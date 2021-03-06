; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-linux-gnu    -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefix=CHECK --check-prefix=X64
; RUN: llc -mtriple=i386-linux-gnu      -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefix=CHECK --check-prefix=X32

define i32 @test_1(i32 %a, i32 %b, i32 %tValue, i32 %fValue) {
; X64-LABEL: test_1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    cmpl %esi, %edi
; X64-NEXT:    setl %al
; X64-NEXT:    testb $1, %al
; X64-NEXT:    je .LBB0_2
; X64-NEXT:  # %bb.1: # %if.then
; X64-NEXT:    movl %edx, -{{[0-9]+}}(%rsp)
; X64-NEXT:    movl -{{[0-9]+}}(%rsp), %eax
; X64-NEXT:    retq
; X64-NEXT:  .LBB0_2: # %if.else
; X64-NEXT:    movl %ecx, -{{[0-9]+}}(%rsp)
; X64-NEXT:    movl -{{[0-9]+}}(%rsp), %eax
; X64-NEXT:    retq
;
; X32-LABEL: test_1:
; X32:       # %bb.0: # %entry
; X32-NEXT:    pushl %eax
; X32-NEXT:    .cfi_def_cfa_offset 8
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    cmpl %eax, {{[0-9]+}}(%esp)
; X32-NEXT:    setl %al
; X32-NEXT:    testb $1, %al
; X32-NEXT:    je .LBB0_2
; X32-NEXT:  # %bb.1: # %if.then
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    jmp .LBB0_3
; X32-NEXT:  .LBB0_2: # %if.else
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:  .LBB0_3: # %return
; X32-NEXT:    movl %eax, (%esp)
; X32-NEXT:    movl (%esp), %eax
; X32-NEXT:    popl %ecx
; X32-NEXT:    .cfi_def_cfa_offset 4
; X32-NEXT:    retl
entry:
  %retval = alloca i32, align 4
  %cmp = icmp slt i32 %a, %b
  br i1 %cmp, label %if.then, label %if.else

if.then:
  store i32 %tValue, i32* %retval, align 4
  br label %return

if.else:
  store i32 %fValue, i32* %retval, align 4
  br label %return

return:
  %0 = load i32, i32* %retval, align 4
  ret i32 %0
}

define i32 @test_2(i32 %a) {
; X64-LABEL: test_2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    testb $1, %dil
; X64-NEXT:    je .LBB1_2
; X64-NEXT:  # %bb.1: # %if.then
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    retq
; X64-NEXT:  .LBB1_2: # %if.else
; X64-NEXT:    movl $1, %eax
; X64-NEXT:    retq
;
; X32-LABEL: test_2:
; X32:       # %bb.0: # %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    testb $1, %al
; X32-NEXT:    je .LBB1_2
; X32-NEXT:  # %bb.1: # %if.then
; X32-NEXT:    xorl %eax, %eax
; X32-NEXT:    retl
; X32-NEXT:  .LBB1_2: # %if.else
; X32-NEXT:    movl $1, %eax
; X32-NEXT:    retl
entry:
  %cmp = trunc i32 %a to i1
  br i1 %cmp, label %if.then, label %if.else

if.then:
  ret i32 0
if.else:
  ret i32 1
}

