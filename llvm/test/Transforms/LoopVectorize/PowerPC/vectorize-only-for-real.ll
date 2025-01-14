; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -loop-vectorize < %s | FileCheck %s
target datalayout = "E-m:e-i64:64-n32:64"
target triple = "powerpc64le-unknown-linux"

; Function Attrs: nounwind
define zeroext i32 @test() #0 {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca [1600 x i32], align 4
; CHECK-NEXT:    [[C:%.*]] = alloca [1600 x i32], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast [1600 x i32]* [[A]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 6400, i8* [[TMP0]]) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[INDEX]] to i32
; CHECK-NEXT:    [[INDUCTION:%.*]] = add i32 [[TMP1]], 0
; CHECK-NEXT:    [[INDUCTION1:%.*]] = add i32 [[TMP1]], 1
; CHECK-NEXT:    [[INDUCTION2:%.*]] = add i32 [[TMP1]], 2
; CHECK-NEXT:    [[INDUCTION3:%.*]] = add i32 [[TMP1]], 3
; CHECK-NEXT:    [[INDUCTION4:%.*]] = add i32 [[TMP1]], 4
; CHECK-NEXT:    [[INDUCTION5:%.*]] = add i32 [[TMP1]], 5
; CHECK-NEXT:    [[INDUCTION6:%.*]] = add i32 [[TMP1]], 6
; CHECK-NEXT:    [[INDUCTION7:%.*]] = add i32 [[TMP1]], 7
; CHECK-NEXT:    [[INDUCTION8:%.*]] = add i32 [[TMP1]], 8
; CHECK-NEXT:    [[INDUCTION9:%.*]] = add i32 [[TMP1]], 9
; CHECK-NEXT:    [[INDUCTION10:%.*]] = add i32 [[TMP1]], 10
; CHECK-NEXT:    [[INDUCTION11:%.*]] = add i32 [[TMP1]], 11
; CHECK-NEXT:    [[INDUCTION12:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[INDUCTION13:%.*]] = add i64 [[INDEX]], 1
; CHECK-NEXT:    [[INDUCTION14:%.*]] = add i64 [[INDEX]], 2
; CHECK-NEXT:    [[INDUCTION15:%.*]] = add i64 [[INDEX]], 3
; CHECK-NEXT:    [[INDUCTION16:%.*]] = add i64 [[INDEX]], 4
; CHECK-NEXT:    [[INDUCTION17:%.*]] = add i64 [[INDEX]], 5
; CHECK-NEXT:    [[INDUCTION18:%.*]] = add i64 [[INDEX]], 6
; CHECK-NEXT:    [[INDUCTION19:%.*]] = add i64 [[INDEX]], 7
; CHECK-NEXT:    [[INDUCTION20:%.*]] = add i64 [[INDEX]], 8
; CHECK-NEXT:    [[INDUCTION21:%.*]] = add i64 [[INDEX]], 9
; CHECK-NEXT:    [[INDUCTION22:%.*]] = add i64 [[INDEX]], 10
; CHECK-NEXT:    [[INDUCTION23:%.*]] = add i64 [[INDEX]], 11
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION12]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION13]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION14]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION15]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION16]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION17]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION18]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION19]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION20]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION21]]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION22]]
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDUCTION23]]
; CHECK-NEXT:    store i32 [[INDUCTION]], i32* [[TMP2]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION1]], i32* [[TMP3]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION2]], i32* [[TMP4]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION3]], i32* [[TMP5]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION4]], i32* [[TMP6]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION5]], i32* [[TMP7]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION6]], i32* [[TMP8]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION7]], i32* [[TMP9]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION8]], i32* [[TMP10]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION9]], i32* [[TMP11]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION10]], i32* [[TMP12]], align 4
; CHECK-NEXT:    store i32 [[INDUCTION11]], i32* [[TMP13]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 12
; CHECK-NEXT:    [[TMP14:%.*]] = icmp eq i64 [[INDEX_NEXT]], 1596
; CHECK-NEXT:    br i1 [[TMP14]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 1600, 1596
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 1596, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    [[TMP15:%.*]] = bitcast [1600 x i32]* [[C]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 6400, i8* [[TMP15]]) #[[ATTR3]]
; CHECK-NEXT:    [[ARRAYDECAY:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 0
; CHECK-NEXT:    [[ARRAYDECAY1:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[C]], i64 0, i64 0
; CHECK-NEXT:    [[CALL:%.*]] = call signext i32 @bar(i32* [[ARRAYDECAY]], i32* [[ARRAYDECAY1]]) #[[ATTR3]]
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH25:%.*]], label [[VECTOR_PH27:%.*]]
; CHECK:       vector.ph27:
; CHECK-NEXT:    br label [[VECTOR_BODY26:%.*]]
; CHECK:       vector.body26:
; CHECK-NEXT:    [[INDEX30:%.*]] = phi i64 [ 0, [[VECTOR_PH27]] ], [ [[INDEX_NEXT46:%.*]], [[VECTOR_BODY26]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi i32 [ 0, [[VECTOR_PH27]] ], [ [[TMP32:%.*]], [[VECTOR_BODY26]] ]
; CHECK-NEXT:    [[VEC_PHI31:%.*]] = phi i32 [ 0, [[VECTOR_PH27]] ], [ [[TMP33:%.*]], [[VECTOR_BODY26]] ]
; CHECK-NEXT:    [[VEC_PHI32:%.*]] = phi i32 [ 0, [[VECTOR_PH27]] ], [ [[TMP34:%.*]], [[VECTOR_BODY26]] ]
; CHECK-NEXT:    [[VEC_PHI33:%.*]] = phi i32 [ 0, [[VECTOR_PH27]] ], [ [[TMP35:%.*]], [[VECTOR_BODY26]] ]
; CHECK-NEXT:    [[VEC_PHI34:%.*]] = phi i32 [ 0, [[VECTOR_PH27]] ], [ [[TMP36:%.*]], [[VECTOR_BODY26]] ]
; CHECK-NEXT:    [[VEC_PHI35:%.*]] = phi i32 [ 0, [[VECTOR_PH27]] ], [ [[TMP37:%.*]], [[VECTOR_BODY26]] ]
; CHECK-NEXT:    [[VEC_PHI36:%.*]] = phi i32 [ 0, [[VECTOR_PH27]] ], [ [[TMP38:%.*]], [[VECTOR_BODY26]] ]
; CHECK-NEXT:    [[VEC_PHI37:%.*]] = phi i32 [ 0, [[VECTOR_PH27]] ], [ [[TMP39:%.*]], [[VECTOR_BODY26]] ]
; CHECK-NEXT:    [[INDUCTION38:%.*]] = add i64 [[INDEX30]], 0
; CHECK-NEXT:    [[INDUCTION39:%.*]] = add i64 [[INDEX30]], 1
; CHECK-NEXT:    [[INDUCTION40:%.*]] = add i64 [[INDEX30]], 2
; CHECK-NEXT:    [[INDUCTION41:%.*]] = add i64 [[INDEX30]], 3
; CHECK-NEXT:    [[INDUCTION42:%.*]] = add i64 [[INDEX30]], 4
; CHECK-NEXT:    [[INDUCTION43:%.*]] = add i64 [[INDEX30]], 5
; CHECK-NEXT:    [[INDUCTION44:%.*]] = add i64 [[INDEX30]], 6
; CHECK-NEXT:    [[INDUCTION45:%.*]] = add i64 [[INDEX30]], 7
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[C]], i64 0, i64 [[INDUCTION38]]
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[C]], i64 0, i64 [[INDUCTION39]]
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[C]], i64 0, i64 [[INDUCTION40]]
; CHECK-NEXT:    [[TMP19:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[C]], i64 0, i64 [[INDUCTION41]]
; CHECK-NEXT:    [[TMP20:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[C]], i64 0, i64 [[INDUCTION42]]
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[C]], i64 0, i64 [[INDUCTION43]]
; CHECK-NEXT:    [[TMP22:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[C]], i64 0, i64 [[INDUCTION44]]
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[C]], i64 0, i64 [[INDUCTION45]]
; CHECK-NEXT:    [[TMP24:%.*]] = load i32, i32* [[TMP16]], align 4
; CHECK-NEXT:    [[TMP25:%.*]] = load i32, i32* [[TMP17]], align 4
; CHECK-NEXT:    [[TMP26:%.*]] = load i32, i32* [[TMP18]], align 4
; CHECK-NEXT:    [[TMP27:%.*]] = load i32, i32* [[TMP19]], align 4
; CHECK-NEXT:    [[TMP28:%.*]] = load i32, i32* [[TMP20]], align 4
; CHECK-NEXT:    [[TMP29:%.*]] = load i32, i32* [[TMP21]], align 4
; CHECK-NEXT:    [[TMP30:%.*]] = load i32, i32* [[TMP22]], align 4
; CHECK-NEXT:    [[TMP31:%.*]] = load i32, i32* [[TMP23]], align 4
; CHECK-NEXT:    [[TMP32]] = add i32 [[TMP24]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP33]] = add i32 [[TMP25]], [[VEC_PHI31]]
; CHECK-NEXT:    [[TMP34]] = add i32 [[TMP26]], [[VEC_PHI32]]
; CHECK-NEXT:    [[TMP35]] = add i32 [[TMP27]], [[VEC_PHI33]]
; CHECK-NEXT:    [[TMP36]] = add i32 [[TMP28]], [[VEC_PHI34]]
; CHECK-NEXT:    [[TMP37]] = add i32 [[TMP29]], [[VEC_PHI35]]
; CHECK-NEXT:    [[TMP38]] = add i32 [[TMP30]], [[VEC_PHI36]]
; CHECK-NEXT:    [[TMP39]] = add i32 [[TMP31]], [[VEC_PHI37]]
; CHECK-NEXT:    [[INDEX_NEXT46]] = add nuw i64 [[INDEX30]], 8
; CHECK-NEXT:    [[TMP40:%.*]] = icmp eq i64 [[INDEX_NEXT46]], 1600
; CHECK-NEXT:    br i1 [[TMP40]], label [[MIDDLE_BLOCK24:%.*]], label [[VECTOR_BODY26]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       middle.block24:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add i32 [[TMP33]], [[TMP32]]
; CHECK-NEXT:    [[BIN_RDX47:%.*]] = add i32 [[TMP34]], [[BIN_RDX]]
; CHECK-NEXT:    [[BIN_RDX48:%.*]] = add i32 [[TMP35]], [[BIN_RDX47]]
; CHECK-NEXT:    [[BIN_RDX49:%.*]] = add i32 [[TMP36]], [[BIN_RDX48]]
; CHECK-NEXT:    [[BIN_RDX50:%.*]] = add i32 [[TMP37]], [[BIN_RDX49]]
; CHECK-NEXT:    [[BIN_RDX51:%.*]] = add i32 [[TMP38]], [[BIN_RDX50]]
; CHECK-NEXT:    [[BIN_RDX52:%.*]] = add i32 [[TMP39]], [[BIN_RDX51]]
; CHECK-NEXT:    [[CMP_N29:%.*]] = icmp eq i64 1600, 1600
; CHECK-NEXT:    br i1 [[CMP_N29]], label [[FOR_COND_CLEANUP5:%.*]], label [[SCALAR_PH25]]
; CHECK:       scalar.ph25:
; CHECK-NEXT:    [[BC_RESUME_VAL28:%.*]] = phi i64 [ 1600, [[MIDDLE_BLOCK24]] ], [ 0, [[FOR_COND_CLEANUP]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ 0, [[FOR_COND_CLEANUP]] ], [ [[BIN_RDX52]], [[MIDDLE_BLOCK24]] ]
; CHECK-NEXT:    br label [[FOR_BODY6:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV25:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT26:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[A]], i64 0, i64 [[INDVARS_IV25]]
; CHECK-NEXT:    [[TMP41:%.*]] = trunc i64 [[INDVARS_IV25]] to i32
; CHECK-NEXT:    store i32 [[TMP41]], i32* [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT26]] = add nuw nsw i64 [[INDVARS_IV25]], 1
; CHECK-NEXT:    [[EXITCOND27:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT26]], 1600
; CHECK-NEXT:    br i1 [[EXITCOND27]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       for.cond.cleanup5:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i32 [ [[ADD:%.*]], [[FOR_BODY6]] ], [ [[BIN_RDX52]], [[MIDDLE_BLOCK24]] ]
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 6400, i8* nonnull [[TMP15]]) #[[ATTR3]]
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 6400, i8* [[TMP0]]) #[[ATTR3]]
; CHECK-NEXT:    ret i32 [[ADD_LCSSA]]
; CHECK:       for.body6:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL28]], [[SCALAR_PH25]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY6]] ]
; CHECK-NEXT:    [[S_022:%.*]] = phi i32 [ [[BC_MERGE_RDX]], [[SCALAR_PH25]] ], [ [[ADD]], [[FOR_BODY6]] ]
; CHECK-NEXT:    [[ARRAYIDX8:%.*]] = getelementptr inbounds [1600 x i32], [1600 x i32]* [[C]], i64 0, i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP42:%.*]] = load i32, i32* [[ARRAYIDX8]], align 4
; CHECK-NEXT:    [[ADD]] = add i32 [[TMP42]], [[S_022]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1600
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP5]], label [[FOR_BODY6]], !llvm.loop [[LOOP4:![0-9]+]]
;

entry:
  %a = alloca [1600 x i32], align 4
  %c = alloca [1600 x i32], align 4
  %0 = bitcast [1600 x i32]* %a to i8*
  call void @llvm.lifetime.start(i64 6400, i8* %0) #3
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %1 = bitcast [1600 x i32]* %c to i8*
  call void @llvm.lifetime.start(i64 6400, i8* %1) #3
  %arraydecay = getelementptr inbounds [1600 x i32], [1600 x i32]* %a, i64 0, i64 0
  %arraydecay1 = getelementptr inbounds [1600 x i32], [1600 x i32]* %c, i64 0, i64 0
  %call = call signext i32 @bar(i32* %arraydecay, i32* %arraydecay1) #3
  br label %for.body6

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv25 = phi i64 [ 0, %entry ], [ %indvars.iv.next26, %for.body ]
  %arrayidx = getelementptr inbounds [1600 x i32], [1600 x i32]* %a, i64 0, i64 %indvars.iv25
  %2 = trunc i64 %indvars.iv25 to i32
  store i32 %2, i32* %arrayidx, align 4
  %indvars.iv.next26 = add nuw nsw i64 %indvars.iv25, 1
  %exitcond27 = icmp eq i64 %indvars.iv.next26, 1600
  br i1 %exitcond27, label %for.cond.cleanup, label %for.body

for.cond.cleanup5:                                ; preds = %for.body6
  call void @llvm.lifetime.end(i64 6400, i8* nonnull %1) #3
  call void @llvm.lifetime.end(i64 6400, i8* %0) #3
  ret i32 %add

for.body6:                                        ; preds = %for.body6, %for.cond.cleanup
  %indvars.iv = phi i64 [ 0, %for.cond.cleanup ], [ %indvars.iv.next, %for.body6 ]
  %s.022 = phi i32 [ 0, %for.cond.cleanup ], [ %add, %for.body6 ]
  %arrayidx8 = getelementptr inbounds [1600 x i32], [1600 x i32]* %c, i64 0, i64 %indvars.iv
  %3 = load i32, i32* %arrayidx8, align 4
  %add = add i32 %3, %s.022
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1600
  br i1 %exitcond, label %for.cond.cleanup5, label %for.body6
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

declare signext i32 @bar(i32*, i32*) #2

attributes #0 = { nounwind "target-features"="-altivec,-bpermd,-crypto,-direct-move,-extdiv,-power8-vector,-vsx" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "target-features"="-altivec,-bpermd,-crypto,-direct-move,-extdiv,-power8-vector,-vsx" }
attributes #3 = { nounwind }

