; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -loop-vectorize -S | FileCheck %s
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.11.0"

; This test checks vector GEP before scatter.
; The code bellow crashed due to destroyed SSA while incorrect vectorization of
; the GEP.

@d = global [10 x [10 x i32]] zeroinitializer, align 16
@c = external global i32, align 4
@a = external global i32, align 4
@b = external global i64, align 8

; Function Attrs: norecurse nounwind ssp uwtable
define void @_Z3fn1v() #0 {
; CHECK-LABEL: @_Z3fn1v(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* @c, align 4
; CHECK-NEXT:    [[CMP34:%.*]] = icmp sgt i32 [[TMP0]], 8
; CHECK-NEXT:    br i1 [[CMP34]], label [[FOR_BODY_LR_PH:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = load i64, i64* @b, align 8
; CHECK-NEXT:    [[MUL:%.*]] = mul i64 [[TMP2]], 4063299859190
; CHECK-NEXT:    [[TOBOOL6:%.*]] = icmp eq i64 [[MUL]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = sext i32 [[TMP0]] to i64
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[FOR_BODY_US_PREHEADER:%.*]], label [[FOR_BODY_PREHEADER:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP4:%.*]] = add nsw i64 [[TMP3]], -9
; CHECK-NEXT:    [[TMP5:%.*]] = lshr i64 [[TMP4]], 1
; CHECK-NEXT:    [[TMP6:%.*]] = add nuw i64 [[TMP5]], 1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP6]], 16
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP6]], 16
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP6]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP7:%.*]] = mul i64 [[N_VEC]], 2
; CHECK-NEXT:    [[IND_END:%.*]] = add i64 8, [[TMP7]]
; CHECK-NEXT:    [[IND_END2:%.*]] = mul i64 [[N_VEC]], 2
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <16 x i64> [ <i64 8, i64 10, i64 12, i64 14, i64 16, i64 18, i64 20, i64 22, i64 24, i64 26, i64 28, i64 30, i64 32, i64 34, i64 36, i64 38>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND3:%.*]] = phi <16 x i64> [ <i64 0, i64 2, i64 4, i64 6, i64 8, i64 10, i64 12, i64 14, i64 16, i64 18, i64 20, i64 22, i64 24, i64 26, i64 28, i64 30>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT4:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP8:%.*]] = sub nsw <16 x i64> <i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8>, [[VEC_IND]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [10 x [10 x i32]], [10 x [10 x i32]]* @d, i64 0, <16 x i64> [[VEC_IND]]
; CHECK-NEXT:    [[TMP10:%.*]] = add nsw <16 x i64> [[TMP8]], [[VEC_IND3]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [10 x i32], <16 x [10 x i32]*> [[TMP9]], <16 x i64> [[TMP10]], i64 0
; CHECK-NEXT:    call void @llvm.masked.scatter.v16i32.v16p0i32(<16 x i32> <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>, <16 x i32*> [[TMP11]], i32 16, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>)
; CHECK-NEXT:    [[TMP12:%.*]] = or <16 x i64> [[VEC_IND3]], <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
; CHECK-NEXT:    [[TMP13:%.*]] = add nsw <16 x i64> [[TMP8]], [[TMP12]]
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds [10 x i32], <16 x [10 x i32]*> [[TMP9]], <16 x i64> [[TMP13]], i64 0
; CHECK-NEXT:    call void @llvm.masked.scatter.v16i32.v16p0i32(<16 x i32> <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>, <16 x i32*> [[TMP14]], i32 8, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>)
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <16 x i64> [[VEC_IND]], <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
; CHECK-NEXT:    [[VEC_IND_NEXT4]] = add <16 x i64> [[VEC_IND3]], <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
; CHECK-NEXT:    [[TMP15:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP15]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP6]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP_LOOPEXIT99:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ 8, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i64 [ [[IND_END2]], [[MIDDLE_BLOCK]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body.us.preheader:
; CHECK-NEXT:    [[TMP16:%.*]] = add nsw i64 [[TMP3]], -9
; CHECK-NEXT:    [[TMP17:%.*]] = lshr i64 [[TMP16]], 1
; CHECK-NEXT:    [[TMP18:%.*]] = add nuw i64 [[TMP17]], 1
; CHECK-NEXT:    [[MIN_ITERS_CHECK8:%.*]] = icmp ult i64 [[TMP18]], 16
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK8]], label [[SCALAR_PH6:%.*]], label [[VECTOR_PH9:%.*]]
; CHECK:       vector.ph9:
; CHECK-NEXT:    [[N_MOD_VF10:%.*]] = urem i64 [[TMP18]], 16
; CHECK-NEXT:    [[N_VEC11:%.*]] = sub i64 [[TMP18]], [[N_MOD_VF10]]
; CHECK-NEXT:    [[TMP19:%.*]] = mul i64 [[N_VEC11]], 2
; CHECK-NEXT:    [[IND_END13:%.*]] = add i64 8, [[TMP19]]
; CHECK-NEXT:    [[IND_END15:%.*]] = mul i64 [[N_VEC11]], 2
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <16 x i1> poison, i1 [[TOBOOL6]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <16 x i1> [[BROADCAST_SPLATINSERT]], <16 x i1> poison, <16 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY7:%.*]]
; CHECK:       vector.body7:
; CHECK-NEXT:    [[INDEX17:%.*]] = phi i64 [ 0, [[VECTOR_PH9]] ], [ [[INDEX_NEXT22:%.*]], [[VECTOR_BODY7]] ]
; CHECK-NEXT:    [[VEC_IND18:%.*]] = phi <16 x i64> [ <i64 8, i64 10, i64 12, i64 14, i64 16, i64 18, i64 20, i64 22, i64 24, i64 26, i64 28, i64 30, i64 32, i64 34, i64 36, i64 38>, [[VECTOR_PH9]] ], [ [[VEC_IND_NEXT19:%.*]], [[VECTOR_BODY7]] ]
; CHECK-NEXT:    [[VEC_IND20:%.*]] = phi <16 x i64> [ <i64 0, i64 2, i64 4, i64 6, i64 8, i64 10, i64 12, i64 14, i64 16, i64 18, i64 20, i64 22, i64 24, i64 26, i64 28, i64 30>, [[VECTOR_PH9]] ], [ [[VEC_IND_NEXT21:%.*]], [[VECTOR_BODY7]] ]
; CHECK-NEXT:    [[TMP20:%.*]] = sub nsw <16 x i64> <i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8, i64 8>, [[VEC_IND18]]
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds [10 x [10 x i32]], [10 x [10 x i32]]* @d, i64 0, <16 x i64> [[VEC_IND18]]
; CHECK-NEXT:    [[TMP22:%.*]] = add nsw <16 x i64> [[TMP20]], [[VEC_IND20]]
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds [10 x i32], <16 x [10 x i32]*> [[TMP21]], <16 x i64> [[TMP22]], i64 0
; CHECK-NEXT:    [[TMP24:%.*]] = xor <16 x i1> [[BROADCAST_SPLAT]], <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>
; CHECK-NEXT:    call void @llvm.masked.scatter.v16i32.v16p0i32(<16 x i32> <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>, <16 x i32*> [[TMP23]], i32 16, <16 x i1> [[TMP24]])
; CHECK-NEXT:    [[TMP25:%.*]] = or <16 x i64> [[VEC_IND20]], <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
; CHECK-NEXT:    [[TMP26:%.*]] = add nsw <16 x i64> [[TMP20]], [[TMP25]]
; CHECK-NEXT:    [[TMP27:%.*]] = getelementptr inbounds [10 x i32], <16 x [10 x i32]*> [[TMP21]], <16 x i64> [[TMP26]], i64 0
; CHECK-NEXT:    call void @llvm.masked.scatter.v16i32.v16p0i32(<16 x i32> <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>, <16 x i32*> [[TMP27]], i32 8, <16 x i1> [[TMP24]])
; CHECK-NEXT:    call void @llvm.masked.scatter.v16i32.v16p0i32(<16 x i32> <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>, <16 x i32*> [[TMP23]], i32 16, <16 x i1> [[BROADCAST_SPLAT]])
; CHECK-NEXT:    [[TMP28:%.*]] = or <16 x i64> [[VEC_IND20]], <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
; CHECK-NEXT:    [[TMP29:%.*]] = add nsw <16 x i64> [[TMP20]], [[TMP28]]
; CHECK-NEXT:    [[TMP30:%.*]] = getelementptr inbounds [10 x i32], <16 x [10 x i32]*> [[TMP21]], <16 x i64> [[TMP29]], i64 0
; CHECK-NEXT:    call void @llvm.masked.scatter.v16i32.v16p0i32(<16 x i32> <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>, <16 x i32*> [[TMP30]], i32 8, <16 x i1> [[BROADCAST_SPLAT]])
; CHECK-NEXT:    [[INDEX_NEXT22]] = add nuw i64 [[INDEX17]], 16
; CHECK-NEXT:    [[VEC_IND_NEXT19]] = add <16 x i64> [[VEC_IND18]], <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
; CHECK-NEXT:    [[VEC_IND_NEXT21]] = add <16 x i64> [[VEC_IND20]], <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
; CHECK-NEXT:    [[TMP31:%.*]] = icmp eq i64 [[INDEX_NEXT22]], [[N_VEC11]]
; CHECK-NEXT:    br i1 [[TMP31]], label [[MIDDLE_BLOCK5:%.*]], label [[VECTOR_BODY7]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       middle.block5:
; CHECK-NEXT:    [[CMP_N16:%.*]] = icmp eq i64 [[TMP18]], [[N_VEC11]]
; CHECK-NEXT:    br i1 [[CMP_N16]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[SCALAR_PH6]]
; CHECK:       scalar.ph6:
; CHECK-NEXT:    [[BC_RESUME_VAL12:%.*]] = phi i64 [ [[IND_END13]], [[MIDDLE_BLOCK5]] ], [ 8, [[FOR_BODY_US_PREHEADER]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL14:%.*]] = phi i64 [ [[IND_END15]], [[MIDDLE_BLOCK5]] ], [ 0, [[FOR_BODY_US_PREHEADER]] ]
; CHECK-NEXT:    br label [[FOR_BODY_US:%.*]]
; CHECK:       for.body.us:
; CHECK-NEXT:    [[INDVARS_IV78:%.*]] = phi i64 [ [[INDVARS_IV_NEXT79:%.*]], [[FOR_COND_CLEANUP4_US_LCSSA_US_US:%.*]] ], [ [[BC_RESUME_VAL12]], [[SCALAR_PH6]] ]
; CHECK-NEXT:    [[INDVARS_IV70:%.*]] = phi i64 [ [[INDVARS_IV_NEXT71:%.*]], [[FOR_COND_CLEANUP4_US_LCSSA_US_US]] ], [ [[BC_RESUME_VAL14]], [[SCALAR_PH6]] ]
; CHECK-NEXT:    [[TMP32:%.*]] = sub nsw i64 8, [[INDVARS_IV78]]
; CHECK-NEXT:    [[ADD_PTR_US:%.*]] = getelementptr inbounds [10 x [10 x i32]], [10 x [10 x i32]]* @d, i64 0, i64 [[INDVARS_IV78]]
; CHECK-NEXT:    [[TMP33:%.*]] = add nsw i64 [[TMP32]], [[INDVARS_IV70]]
; CHECK-NEXT:    [[ARRAYDECAY_US_US_US:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* [[ADD_PTR_US]], i64 [[TMP33]], i64 0
; CHECK-NEXT:    br i1 [[TOBOOL6]], label [[FOR_BODY5_US_US_US_PREHEADER:%.*]], label [[FOR_BODY5_US_US48_PREHEADER:%.*]]
; CHECK:       for.body5.us.us48.preheader:
; CHECK-NEXT:    store i32 8, i32* [[ARRAYDECAY_US_US_US]], align 16
; CHECK-NEXT:    [[INDVARS_IV_NEXT66:%.*]] = or i64 [[INDVARS_IV70]], 1
; CHECK-NEXT:    [[TMP34:%.*]] = add nsw i64 [[TMP32]], [[INDVARS_IV_NEXT66]]
; CHECK-NEXT:    [[ARRAYDECAY_US_US55_1:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* [[ADD_PTR_US]], i64 [[TMP34]], i64 0
; CHECK-NEXT:    store i32 8, i32* [[ARRAYDECAY_US_US55_1]], align 8
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP4_US_LCSSA_US_US]]
; CHECK:       for.body5.us.us.us.preheader:
; CHECK-NEXT:    store i32 7, i32* [[ARRAYDECAY_US_US_US]], align 16
; CHECK-NEXT:    [[INDVARS_IV_NEXT73:%.*]] = or i64 [[INDVARS_IV70]], 1
; CHECK-NEXT:    [[TMP35:%.*]] = add nsw i64 [[TMP32]], [[INDVARS_IV_NEXT73]]
; CHECK-NEXT:    [[ARRAYDECAY_US_US_US_1:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* [[ADD_PTR_US]], i64 [[TMP35]], i64 0
; CHECK-NEXT:    store i32 7, i32* [[ARRAYDECAY_US_US_US_1]], align 8
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP4_US_LCSSA_US_US]]
; CHECK:       for.cond.cleanup4.us-lcssa.us.us:
; CHECK-NEXT:    [[INDVARS_IV_NEXT79]] = add nuw nsw i64 [[INDVARS_IV78]], 2
; CHECK-NEXT:    [[CMP_US:%.*]] = icmp slt i64 [[INDVARS_IV_NEXT79]], [[TMP3]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT71]] = add nuw nsw i64 [[INDVARS_IV70]], 2
; CHECK-NEXT:    br i1 [[CMP_US]], label [[FOR_BODY_US]], label [[FOR_COND_CLEANUP_LOOPEXIT]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup.loopexit99:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV95:%.*]] = phi i64 [ [[INDVARS_IV_NEXT96:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[INDVARS_IV87:%.*]] = phi i64 [ [[INDVARS_IV_NEXT88:%.*]], [[FOR_BODY]] ], [ [[BC_RESUME_VAL1]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[TMP36:%.*]] = sub nsw i64 8, [[INDVARS_IV95]]
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds [10 x [10 x i32]], [10 x [10 x i32]]* @d, i64 0, i64 [[INDVARS_IV95]]
; CHECK-NEXT:    [[TMP37:%.*]] = add nsw i64 [[TMP36]], [[INDVARS_IV87]]
; CHECK-NEXT:    [[ARRAYDECAY_US31:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* [[ADD_PTR]], i64 [[TMP37]], i64 0
; CHECK-NEXT:    store i32 8, i32* [[ARRAYDECAY_US31]], align 16
; CHECK-NEXT:    [[INDVARS_IV_NEXT90:%.*]] = or i64 [[INDVARS_IV87]], 1
; CHECK-NEXT:    [[TMP38:%.*]] = add nsw i64 [[TMP36]], [[INDVARS_IV_NEXT90]]
; CHECK-NEXT:    [[ARRAYDECAY_US31_1:%.*]] = getelementptr inbounds [10 x i32], [10 x i32]* [[ADD_PTR]], i64 [[TMP38]], i64 0
; CHECK-NEXT:    store i32 8, i32* [[ARRAYDECAY_US31_1]], align 8
; CHECK-NEXT:    [[INDVARS_IV_NEXT96]] = add nuw nsw i64 [[INDVARS_IV95]], 2
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i64 [[INDVARS_IV_NEXT96]], [[TMP3]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT88]] = add nuw nsw i64 [[INDVARS_IV87]], 2
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_COND_CLEANUP_LOOPEXIT99]], !llvm.loop [[LOOP5:![0-9]+]]
;
entry:
  %0 = load i32, i32* @c, align 4
  %cmp34 = icmp sgt i32 %0, 8
  br i1 %cmp34, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %1 = load i32, i32* @a, align 4
  %tobool = icmp eq i32 %1, 0
  %2 = load i64, i64* @b, align 8
  %mul = mul i64 %2, 4063299859190
  %tobool6 = icmp eq i64 %mul, 0
  %3 = sext i32 %0 to i64
  br i1 %tobool, label %for.body.us.preheader, label %for.body.preheader

for.body.preheader:                               ; preds = %for.body.lr.ph
  br label %for.body

for.body.us.preheader:                            ; preds = %for.body.lr.ph
  br label %for.body.us

for.body.us:                                      ; preds = %for.body.us.preheader, %for.cond.cleanup4.us-lcssa.us.us
  %indvars.iv78 = phi i64 [ %indvars.iv.next79, %for.cond.cleanup4.us-lcssa.us.us ], [ 8, %for.body.us.preheader ]
  %indvars.iv70 = phi i64 [ %indvars.iv.next71, %for.cond.cleanup4.us-lcssa.us.us ], [ 0, %for.body.us.preheader ]
  %4 = sub nsw i64 8, %indvars.iv78
  %add.ptr.us = getelementptr inbounds [10 x [10 x i32]], [10 x [10 x i32]]* @d, i64 0, i64 %indvars.iv78
  %5 = add nsw i64 %4, %indvars.iv70
  %arraydecay.us.us.us = getelementptr inbounds [10 x i32], [10 x i32]* %add.ptr.us, i64 %5, i64 0
  br i1 %tobool6, label %for.body5.us.us.us.preheader, label %for.body5.us.us48.preheader

for.body5.us.us48.preheader:                      ; preds = %for.body.us
  store i32 8, i32* %arraydecay.us.us.us, align 16
  %indvars.iv.next66 = or i64 %indvars.iv70, 1
  %6 = add nsw i64 %4, %indvars.iv.next66
  %arraydecay.us.us55.1 = getelementptr inbounds [10 x i32], [10 x i32]* %add.ptr.us, i64 %6, i64 0
  store i32 8, i32* %arraydecay.us.us55.1, align 8
  br label %for.cond.cleanup4.us-lcssa.us.us

for.body5.us.us.us.preheader:                     ; preds = %for.body.us
  store i32 7, i32* %arraydecay.us.us.us, align 16
  %indvars.iv.next73 = or i64 %indvars.iv70, 1
  %7 = add nsw i64 %4, %indvars.iv.next73
  %arraydecay.us.us.us.1 = getelementptr inbounds [10 x i32], [10 x i32]* %add.ptr.us, i64 %7, i64 0
  store i32 7, i32* %arraydecay.us.us.us.1, align 8
  br label %for.cond.cleanup4.us-lcssa.us.us

for.cond.cleanup4.us-lcssa.us.us:                 ; preds = %for.body5.us.us48.preheader, %for.body5.us.us.us.preheader
  %indvars.iv.next79 = add nuw nsw i64 %indvars.iv78, 2
  %cmp.us = icmp slt i64 %indvars.iv.next79, %3
  %indvars.iv.next71 = add nuw nsw i64 %indvars.iv70, 2
  br i1 %cmp.us, label %for.body.us, label %for.cond.cleanup.loopexit

for.cond.cleanup.loopexit:                        ; preds = %for.cond.cleanup4.us-lcssa.us.us
  br label %for.cond.cleanup

for.cond.cleanup.loopexit99:                      ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit99, %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv95 = phi i64 [ %indvars.iv.next96, %for.body ], [ 8, %for.body.preheader ]
  %indvars.iv87 = phi i64 [ %indvars.iv.next88, %for.body ], [ 0, %for.body.preheader ]
  %8 = sub nsw i64 8, %indvars.iv95
  %add.ptr = getelementptr inbounds [10 x [10 x i32]], [10 x [10 x i32]]* @d, i64 0, i64 %indvars.iv95
  %9 = add nsw i64 %8, %indvars.iv87
  %arraydecay.us31 = getelementptr inbounds [10 x i32], [10 x i32]* %add.ptr, i64 %9, i64 0
  store i32 8, i32* %arraydecay.us31, align 16
  %indvars.iv.next90 = or i64 %indvars.iv87, 1
  %10 = add nsw i64 %8, %indvars.iv.next90
  %arraydecay.us31.1 = getelementptr inbounds [10 x i32], [10 x i32]* %add.ptr, i64 %10, i64 0
  store i32 8, i32* %arraydecay.us31.1, align 8
  %indvars.iv.next96 = add nuw nsw i64 %indvars.iv95, 2
  %cmp = icmp slt i64 %indvars.iv.next96, %3
  %indvars.iv.next88 = add nuw nsw i64 %indvars.iv87, 2
  br i1 %cmp, label %for.body, label %for.cond.cleanup.loopexit99
}

attributes #0 = { norecurse nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "frame-pointer"="all" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="knl" "target-features"="+adx,+aes,+avx,+avx2,+avx512cd,+avx512er,+avx512f,+avx512pf,+bmi,+bmi2,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+pclmul,+popcnt,+prefetchwt1,+rdrnd,+rdseed,+rtm,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsaveopt" "unsafe-fp-math"="false" "use-soft-float"="false" }
