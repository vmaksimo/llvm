; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -loop-vectorize -force-vector-width=4 -S | FileCheck %s
; RUN: opt < %s -loop-vectorize -force-vector-width=2 -force-vector-interleave=2 -S | FileCheck %s -check-prefix=VF2UF2
; RUN: opt < %s -loop-vectorize -force-vector-width=1 -force-vector-interleave=4 -S | FileCheck %s -check-prefix=VF1UF4

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"

; Make sure a loop is vectorized correctly with fold-tail when the constant
; trip-count is not a multiple of -force-vector-width and/or
; -force-vector-interleave, but is a multiple of the internally computed MaxVF;
; e.g., when all types are i32 lead to MaxVF=1.

define void @pr45679(i32* %A) optsize {
; CHECK-LABEL: @pr45679(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[PRED_STORE_CONTINUE6:%.*]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[PRED_STORE_CONTINUE6]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ule <4 x i32> [[VEC_IND]], <i32 13, i32 13, i32 13, i32 13>
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <4 x i1> [[TMP0]], i32 0
; CHECK-NEXT:    br i1 [[TMP1]], label [[PRED_STORE_IF:%.*]], label [[PRED_STORE_CONTINUE:%.*]]
; CHECK:       pred.store.if:
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i32 [[TMP2]]
; CHECK-NEXT:    store i32 13, i32* [[TMP3]], align 1
; CHECK-NEXT:    br label [[PRED_STORE_CONTINUE]]
; CHECK:       pred.store.continue:
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <4 x i1> [[TMP0]], i32 1
; CHECK-NEXT:    br i1 [[TMP4]], label [[PRED_STORE_IF1:%.*]], label [[PRED_STORE_CONTINUE2:%.*]]
; CHECK:       pred.store.if1:
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[INDEX]], 1
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[TMP5]]
; CHECK-NEXT:    store i32 13, i32* [[TMP6]], align 1
; CHECK-NEXT:    br label [[PRED_STORE_CONTINUE2]]
; CHECK:       pred.store.continue2:
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <4 x i1> [[TMP0]], i32 2
; CHECK-NEXT:    br i1 [[TMP7]], label [[PRED_STORE_IF3:%.*]], label [[PRED_STORE_CONTINUE4:%.*]]
; CHECK:       pred.store.if3:
; CHECK-NEXT:    [[TMP8:%.*]] = add i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[TMP8]]
; CHECK-NEXT:    store i32 13, i32* [[TMP9]], align 1
; CHECK-NEXT:    br label [[PRED_STORE_CONTINUE4]]
; CHECK:       pred.store.continue4:
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <4 x i1> [[TMP0]], i32 3
; CHECK-NEXT:    br i1 [[TMP10]], label [[PRED_STORE_IF5:%.*]], label [[PRED_STORE_CONTINUE6]]
; CHECK:       pred.store.if5:
; CHECK-NEXT:    [[TMP11:%.*]] = add i32 [[INDEX]], 3
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[TMP11]]
; CHECK-NEXT:    store i32 13, i32* [[TMP12]], align 1
; CHECK-NEXT:    br label [[PRED_STORE_CONTINUE6]]
; CHECK:       pred.store.continue6:
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i32> [[VEC_IND]], <i32 4, i32 4, i32 4, i32 4>
; CHECK-NEXT:    [[TMP13:%.*]] = icmp eq i32 [[INDEX_NEXT]], 16
; CHECK-NEXT:    br i1 [[TMP13]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 16, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[RIV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[RIVPLUS1:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[RIV]]
; CHECK-NEXT:    store i32 13, i32* [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[RIVPLUS1]] = add nuw nsw i32 [[RIV]], 1
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[RIVPLUS1]], 14
; CHECK-NEXT:    br i1 [[COND]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
; VF2UF2-LABEL: @pr45679(
; VF2UF2-NEXT:  entry:
; VF2UF2-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; VF2UF2:       vector.ph:
; VF2UF2-NEXT:    br label [[VECTOR_BODY:%.*]]
; VF2UF2:       vector.body:
; VF2UF2-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[PRED_STORE_CONTINUE7:%.*]] ]
; VF2UF2-NEXT:    [[VEC_IND:%.*]] = phi <2 x i32> [ <i32 0, i32 1>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[PRED_STORE_CONTINUE7]] ]
; VF2UF2-NEXT:    [[STEP_ADD:%.*]] = add <2 x i32> [[VEC_IND]], <i32 2, i32 2>
; VF2UF2-NEXT:    [[TMP0:%.*]] = icmp ule <2 x i32> [[VEC_IND]], <i32 13, i32 13>
; VF2UF2-NEXT:    [[TMP1:%.*]] = icmp ule <2 x i32> [[STEP_ADD]], <i32 13, i32 13>
; VF2UF2-NEXT:    [[TMP2:%.*]] = extractelement <2 x i1> [[TMP0]], i32 0
; VF2UF2-NEXT:    br i1 [[TMP2]], label [[PRED_STORE_IF:%.*]], label [[PRED_STORE_CONTINUE:%.*]]
; VF2UF2:       pred.store.if:
; VF2UF2-NEXT:    [[TMP3:%.*]] = add i32 [[INDEX]], 0
; VF2UF2-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i32 [[TMP3]]
; VF2UF2-NEXT:    store i32 13, i32* [[TMP4]], align 1
; VF2UF2-NEXT:    br label [[PRED_STORE_CONTINUE]]
; VF2UF2:       pred.store.continue:
; VF2UF2-NEXT:    [[TMP5:%.*]] = extractelement <2 x i1> [[TMP0]], i32 1
; VF2UF2-NEXT:    br i1 [[TMP5]], label [[PRED_STORE_IF2:%.*]], label [[PRED_STORE_CONTINUE3:%.*]]
; VF2UF2:       pred.store.if2:
; VF2UF2-NEXT:    [[TMP6:%.*]] = add i32 [[INDEX]], 1
; VF2UF2-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[TMP6]]
; VF2UF2-NEXT:    store i32 13, i32* [[TMP7]], align 1
; VF2UF2-NEXT:    br label [[PRED_STORE_CONTINUE3]]
; VF2UF2:       pred.store.continue3:
; VF2UF2-NEXT:    [[TMP8:%.*]] = extractelement <2 x i1> [[TMP1]], i32 0
; VF2UF2-NEXT:    br i1 [[TMP8]], label [[PRED_STORE_IF4:%.*]], label [[PRED_STORE_CONTINUE5:%.*]]
; VF2UF2:       pred.store.if4:
; VF2UF2-NEXT:    [[TMP9:%.*]] = add i32 [[INDEX]], 2
; VF2UF2-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[TMP9]]
; VF2UF2-NEXT:    store i32 13, i32* [[TMP10]], align 1
; VF2UF2-NEXT:    br label [[PRED_STORE_CONTINUE5]]
; VF2UF2:       pred.store.continue5:
; VF2UF2-NEXT:    [[TMP11:%.*]] = extractelement <2 x i1> [[TMP1]], i32 1
; VF2UF2-NEXT:    br i1 [[TMP11]], label [[PRED_STORE_IF6:%.*]], label [[PRED_STORE_CONTINUE7]]
; VF2UF2:       pred.store.if6:
; VF2UF2-NEXT:    [[TMP12:%.*]] = add i32 [[INDEX]], 3
; VF2UF2-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[TMP12]]
; VF2UF2-NEXT:    store i32 13, i32* [[TMP13]], align 1
; VF2UF2-NEXT:    br label [[PRED_STORE_CONTINUE7]]
; VF2UF2:       pred.store.continue7:
; VF2UF2-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; VF2UF2-NEXT:    [[VEC_IND_NEXT]] = add <2 x i32> [[STEP_ADD]], <i32 2, i32 2>
; VF2UF2-NEXT:    [[TMP14:%.*]] = icmp eq i32 [[INDEX_NEXT]], 16
; VF2UF2-NEXT:    br i1 [[TMP14]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; VF2UF2:       middle.block:
; VF2UF2-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; VF2UF2:       scalar.ph:
; VF2UF2-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 16, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; VF2UF2-NEXT:    br label [[LOOP:%.*]]
; VF2UF2:       loop:
; VF2UF2-NEXT:    [[RIV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[RIVPLUS1:%.*]], [[LOOP]] ]
; VF2UF2-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[RIV]]
; VF2UF2-NEXT:    store i32 13, i32* [[ARRAYIDX]], align 1
; VF2UF2-NEXT:    [[RIVPLUS1]] = add nuw nsw i32 [[RIV]], 1
; VF2UF2-NEXT:    [[COND:%.*]] = icmp eq i32 [[RIVPLUS1]], 14
; VF2UF2-NEXT:    br i1 [[COND]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP2:![0-9]+]]
; VF2UF2:       exit:
; VF2UF2-NEXT:    ret void
;
; VF1UF4-LABEL: @pr45679(
; VF1UF4-NEXT:  entry:
; VF1UF4-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; VF1UF4:       vector.ph:
; VF1UF4-NEXT:    br label [[VECTOR_BODY:%.*]]
; VF1UF4:       vector.body:
; VF1UF4-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[PRED_STORE_CONTINUE12:%.*]] ]
; VF1UF4-NEXT:    [[VEC_IV:%.*]] = add i32 [[INDEX]], 0
; VF1UF4-NEXT:    [[VEC_IV4:%.*]] = add i32 [[INDEX]], 1
; VF1UF4-NEXT:    [[VEC_IV5:%.*]] = add i32 [[INDEX]], 2
; VF1UF4-NEXT:    [[VEC_IV6:%.*]] = add i32 [[INDEX]], 3
; VF1UF4-NEXT:    [[TMP0:%.*]] = icmp ule i32 [[VEC_IV]], 13
; VF1UF4-NEXT:    [[TMP1:%.*]] = icmp ule i32 [[VEC_IV4]], 13
; VF1UF4-NEXT:    [[TMP2:%.*]] = icmp ule i32 [[VEC_IV5]], 13
; VF1UF4-NEXT:    [[TMP3:%.*]] = icmp ule i32 [[VEC_IV6]], 13
; VF1UF4-NEXT:    br i1 [[TMP0]], label [[PRED_STORE_IF:%.*]], label [[PRED_STORE_CONTINUE:%.*]]
; VF1UF4:       pred.store.if:
; VF1UF4-NEXT:    [[INDUCTION:%.*]] = add i32 [[INDEX]], 0
; VF1UF4-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i32 [[INDUCTION]]
; VF1UF4-NEXT:    store i32 13, i32* [[TMP4]], align 1
; VF1UF4-NEXT:    br label [[PRED_STORE_CONTINUE]]
; VF1UF4:       pred.store.continue:
; VF1UF4-NEXT:    br i1 [[TMP1]], label [[PRED_STORE_IF7:%.*]], label [[PRED_STORE_CONTINUE8:%.*]]
; VF1UF4:       pred.store.if7:
; VF1UF4-NEXT:    [[INDUCTION1:%.*]] = add i32 [[INDEX]], 1
; VF1UF4-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[INDUCTION1]]
; VF1UF4-NEXT:    store i32 13, i32* [[TMP5]], align 1
; VF1UF4-NEXT:    br label [[PRED_STORE_CONTINUE8]]
; VF1UF4:       pred.store.continue8:
; VF1UF4-NEXT:    br i1 [[TMP2]], label [[PRED_STORE_IF9:%.*]], label [[PRED_STORE_CONTINUE10:%.*]]
; VF1UF4:       pred.store.if9:
; VF1UF4-NEXT:    [[INDUCTION2:%.*]] = add i32 [[INDEX]], 2
; VF1UF4-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[INDUCTION2]]
; VF1UF4-NEXT:    store i32 13, i32* [[TMP6]], align 1
; VF1UF4-NEXT:    br label [[PRED_STORE_CONTINUE10]]
; VF1UF4:       pred.store.continue10:
; VF1UF4-NEXT:    br i1 [[TMP3]], label [[PRED_STORE_IF11:%.*]], label [[PRED_STORE_CONTINUE12]]
; VF1UF4:       pred.store.if11:
; VF1UF4-NEXT:    [[INDUCTION3:%.*]] = add i32 [[INDEX]], 3
; VF1UF4-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[INDUCTION3]]
; VF1UF4-NEXT:    store i32 13, i32* [[TMP7]], align 1
; VF1UF4-NEXT:    br label [[PRED_STORE_CONTINUE12]]
; VF1UF4:       pred.store.continue12:
; VF1UF4-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; VF1UF4-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[INDEX_NEXT]], 16
; VF1UF4-NEXT:    br i1 [[TMP8]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; VF1UF4:       middle.block:
; VF1UF4-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; VF1UF4:       scalar.ph:
; VF1UF4-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 16, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; VF1UF4-NEXT:    br label [[LOOP:%.*]]
; VF1UF4:       loop:
; VF1UF4-NEXT:    [[RIV:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[RIVPLUS1:%.*]], [[LOOP]] ]
; VF1UF4-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 [[RIV]]
; VF1UF4-NEXT:    store i32 13, i32* [[ARRAYIDX]], align 1
; VF1UF4-NEXT:    [[RIVPLUS1]] = add nuw nsw i32 [[RIV]], 1
; VF1UF4-NEXT:    [[COND:%.*]] = icmp eq i32 [[RIVPLUS1]], 14
; VF1UF4-NEXT:    br i1 [[COND]], label [[EXIT]], label [[LOOP]], !llvm.loop [[LOOP2:![0-9]+]]
; VF1UF4:       exit:
; VF1UF4-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %riv = phi i32 [ 0, %entry ], [ %rivPlus1, %loop ]
  %arrayidx = getelementptr inbounds i32, i32* %A, i32 %riv
  store i32 13, i32* %arrayidx, align 1
  %rivPlus1 = add nuw nsw i32 %riv, 1
  %cond = icmp eq i32 %rivPlus1, 14
  br i1 %cond, label %exit, label %loop

exit:
  ret void
}
