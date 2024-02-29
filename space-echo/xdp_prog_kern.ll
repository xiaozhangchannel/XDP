; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon.5 = type { ptr, ptr, ptr, ptr }
%struct.icmphdr_common = type { i8, i8, i16 }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, %union.anon }
%union.anon = type { %struct.anon }
%struct.anon = type { i32, i32 }
%struct.ipv6hdr = type { i8, [3 x i8], i16, i8, i8, %union.anon.1 }
%union.anon.1 = type { %struct.anon.2 }
%struct.anon.2 = type { %struct.in6_addr, %struct.in6_addr }
%struct.in6_addr = type { %union.anon.3 }
%union.anon.3 = type { [4 x i32] }

@xdp_icmp_echo_func.____fmt = internal constant [3 x i8] c"ok\00", align 1, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !70
@xdp_stats_map = dso_local global %struct.anon.5 zeroinitializer, section ".maps", align 8, !dbg !76
@llvm.compiler.used = appending global [3 x ptr] [ptr @_license, ptr @xdp_icmp_echo_func, ptr @xdp_stats_map], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_icmp_echo_func(ptr nocapture noundef readonly %0) #0 section "xdp_icmp_echo" !dbg !2 {
  %2 = alloca [6 x i8], align 1
  %3 = alloca [4 x i32], align 4
  %4 = alloca %struct.icmphdr_common, align 4
  call void @llvm.dbg.value(metadata ptr %0, metadata !119, metadata !DIExpression()), !dbg !231
  %5 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 1, !dbg !232
  %6 = load i32, ptr %5, align 4, !dbg !232, !tbaa !233
  %7 = zext i32 %6 to i64, !dbg !238
  %8 = inttoptr i64 %7 to ptr, !dbg !239
  call void @llvm.dbg.value(metadata ptr %8, metadata !120, metadata !DIExpression()), !dbg !231
  %9 = load i32, ptr %0, align 4, !dbg !240, !tbaa !241
  %10 = zext i32 %9 to i64, !dbg !242
  %11 = inttoptr i64 %10 to ptr, !dbg !243
  call void @llvm.dbg.value(metadata ptr %11, metadata !121, metadata !DIExpression()), !dbg !231
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4) #6, !dbg !244
  call void @llvm.dbg.declare(metadata ptr %4, metadata !222, metadata !DIExpression()), !dbg !245
  call void @llvm.dbg.value(metadata i32 2, metadata !223, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.value(metadata ptr %11, metadata !122, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.value(metadata ptr undef, metadata !246, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.value(metadata ptr %8, metadata !253, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.value(metadata ptr undef, metadata !254, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.value(metadata ptr undef, metadata !257, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.value(metadata ptr %8, metadata !269, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.value(metadata ptr undef, metadata !270, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.value(metadata ptr null, metadata !271, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.value(metadata ptr %11, metadata !272, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.value(metadata i32 14, metadata !273, metadata !DIExpression()), !dbg !282
  %12 = getelementptr i8, ptr %11, i64 14, !dbg !284
  %13 = icmp ugt ptr %12, %8, !dbg !286
  br i1 %13, label %102, label %14, !dbg !287

14:                                               ; preds = %1
  call void @llvm.dbg.value(metadata ptr %12, metadata !122, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.value(metadata ptr %12, metadata !274, metadata !DIExpression()), !dbg !282
  %15 = getelementptr inbounds %struct.ethhdr, ptr %11, i64 0, i32 2, !dbg !288
  call void @llvm.dbg.value(metadata i16 poison, metadata !280, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.value(metadata i32 0, metadata !281, metadata !DIExpression()), !dbg !282
  %16 = load i16, ptr %15, align 1, !dbg !282, !tbaa !289
  call void @llvm.dbg.value(metadata i16 %16, metadata !280, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.value(metadata i16 %16, metadata !291, metadata !DIExpression()), !dbg !296
  %17 = icmp eq i16 %16, 129, !dbg !302
  %18 = icmp eq i16 %16, -22392, !dbg !303
  %19 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %17)
  %20 = or i1 %18, %19, !dbg !303
  %21 = getelementptr i8, ptr %11, i64 18
  %22 = icmp ule ptr %21, %8
  %23 = select i1 %20, i1 %22, i1 false, !dbg !304
  br i1 %23, label %24, label %37, !dbg !304

24:                                               ; preds = %14
  call void @llvm.dbg.value(metadata i16 poison, metadata !280, metadata !DIExpression()), !dbg !282
  %25 = getelementptr i8, ptr %11, i64 16, !dbg !305
  call void @llvm.dbg.value(metadata ptr %21, metadata !274, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.value(metadata i32 1, metadata !281, metadata !DIExpression()), !dbg !282
  %26 = load i16, ptr %25, align 1, !dbg !282, !tbaa !289
  call void @llvm.dbg.value(metadata i16 %26, metadata !280, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.value(metadata i16 %26, metadata !291, metadata !DIExpression()), !dbg !296
  %27 = icmp eq i16 %26, 129, !dbg !302
  %28 = icmp eq i16 %26, -22392, !dbg !303
  %29 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %27)
  %30 = or i1 %28, %29, !dbg !303
  %31 = getelementptr i8, ptr %11, i64 22
  %32 = icmp ule ptr %31, %8
  %33 = select i1 %30, i1 %32, i1 false, !dbg !304
  br i1 %33, label %34, label %37, !dbg !304

34:                                               ; preds = %24
  call void @llvm.dbg.value(metadata i16 poison, metadata !280, metadata !DIExpression()), !dbg !282
  %35 = getelementptr i8, ptr %11, i64 20, !dbg !305
  call void @llvm.dbg.value(metadata ptr %31, metadata !274, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.value(metadata i32 2, metadata !281, metadata !DIExpression()), !dbg !282
  %36 = load i16, ptr %35, align 1, !dbg !282, !tbaa !289
  call void @llvm.dbg.value(metadata i16 %36, metadata !280, metadata !DIExpression()), !dbg !282
  br label %37

37:                                               ; preds = %14, %24, %34
  %38 = phi ptr [ %12, %14 ], [ %21, %24 ], [ %31, %34 ], !dbg !282
  %39 = phi i16 [ %16, %14 ], [ %26, %24 ], [ %36, %34 ], !dbg !282
  call void @llvm.dbg.value(metadata ptr %38, metadata !122, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.value(metadata i16 %39, metadata !138, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_signed, DW_OP_LLVM_convert, 32, DW_ATE_signed, DW_OP_stack_value)), !dbg !231
  switch i16 %39, label %102 [
    i16 8, label %40
    i16 -8826, label %56
  ], !dbg !306

40:                                               ; preds = %37
  call void @llvm.dbg.value(metadata ptr undef, metadata !307, metadata !DIExpression()), !dbg !317
  call void @llvm.dbg.value(metadata ptr %8, metadata !313, metadata !DIExpression()), !dbg !317
  call void @llvm.dbg.value(metadata ptr undef, metadata !314, metadata !DIExpression()), !dbg !317
  call void @llvm.dbg.value(metadata ptr %38, metadata !315, metadata !DIExpression()), !dbg !317
  %41 = getelementptr inbounds %struct.iphdr, ptr %38, i64 1, !dbg !321
  %42 = icmp ugt ptr %41, %8, !dbg !323
  br i1 %42, label %102, label %43, !dbg !324

43:                                               ; preds = %40
  %44 = load i8, ptr %38, align 4, !dbg !325
  %45 = shl i8 %44, 2, !dbg !326
  %46 = and i8 %45, 60, !dbg !326
  call void @llvm.dbg.value(metadata i8 %46, metadata !316, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !317
  %47 = icmp ult i8 %46, 20, !dbg !327
  br i1 %47, label %102, label %48, !dbg !329

48:                                               ; preds = %43
  %49 = zext i8 %46 to i64
  call void @llvm.dbg.value(metadata i64 %49, metadata !316, metadata !DIExpression()), !dbg !317
  %50 = getelementptr i8, ptr %38, i64 %49, !dbg !330
  %51 = icmp ugt ptr %50, %8, !dbg !332
  br i1 %51, label %102, label %52, !dbg !333

52:                                               ; preds = %48
  call void @llvm.dbg.value(metadata ptr %50, metadata !122, metadata !DIExpression()), !dbg !231
  %53 = getelementptr inbounds %struct.iphdr, ptr %38, i64 0, i32 6, !dbg !334
  %54 = load i8, ptr %53, align 1, !dbg !334, !tbaa !335
  call void @llvm.dbg.value(metadata i8 %54, metadata !139, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !231
  %55 = icmp eq i8 %54, 1, !dbg !337
  br i1 %55, label %63, label %102, !dbg !339

56:                                               ; preds = %37
  call void @llvm.dbg.value(metadata ptr undef, metadata !340, metadata !DIExpression()), !dbg !349
  call void @llvm.dbg.value(metadata ptr %8, metadata !346, metadata !DIExpression()), !dbg !349
  call void @llvm.dbg.value(metadata ptr undef, metadata !347, metadata !DIExpression()), !dbg !349
  call void @llvm.dbg.value(metadata ptr %38, metadata !348, metadata !DIExpression()), !dbg !349
  %57 = getelementptr inbounds %struct.ipv6hdr, ptr %38, i64 1, !dbg !353
  %58 = icmp ugt ptr %57, %8, !dbg !355
  br i1 %58, label %102, label %59, !dbg !356

59:                                               ; preds = %56
  call void @llvm.dbg.value(metadata ptr %57, metadata !122, metadata !DIExpression()), !dbg !231
  %60 = getelementptr inbounds %struct.ipv6hdr, ptr %38, i64 0, i32 3, !dbg !357
  %61 = load i8, ptr %60, align 2, !dbg !357, !tbaa !358
  call void @llvm.dbg.value(metadata i8 %61, metadata !139, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !231
  %62 = icmp eq i8 %61, 58, !dbg !360
  br i1 %62, label %63, label %102, !dbg !362

63:                                               ; preds = %59, %52
  %64 = phi i1 [ true, %52 ], [ false, %59 ]
  %65 = phi i1 [ false, %52 ], [ true, %59 ]
  %66 = phi ptr [ %50, %52 ], [ %57, %59 ], !dbg !363
  call void @llvm.dbg.value(metadata ptr %66, metadata !122, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.value(metadata ptr undef, metadata !364, metadata !DIExpression()), !dbg !373
  call void @llvm.dbg.value(metadata ptr %8, metadata !370, metadata !DIExpression()), !dbg !373
  call void @llvm.dbg.value(metadata ptr undef, metadata !371, metadata !DIExpression()), !dbg !373
  call void @llvm.dbg.value(metadata ptr %66, metadata !372, metadata !DIExpression()), !dbg !373
  %67 = getelementptr inbounds %struct.icmphdr_common, ptr %66, i64 1, !dbg !375
  %68 = icmp ugt ptr %67, %8, !dbg !377
  br i1 %68, label %102, label %69, !dbg !378

69:                                               ; preds = %63
  call void @llvm.dbg.value(metadata ptr %67, metadata !122, metadata !DIExpression()), !dbg !231
  %70 = load i8, ptr %66, align 2, !dbg !379, !tbaa !380
  call void @llvm.dbg.value(metadata i8 %70, metadata !140, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !231
  %71 = icmp eq i8 %70, 8
  %72 = select i1 %64, i1 %71, i1 false, !dbg !382
  br i1 %72, label %73, label %78, !dbg !382

73:                                               ; preds = %69
  call void @llvm.dbg.value(metadata ptr %38, metadata !141, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.value(metadata ptr %38, metadata !384, metadata !DIExpression()), !dbg !391
  %74 = getelementptr inbounds %struct.iphdr, ptr %38, i64 0, i32 8, !dbg !394
  %75 = load i32, ptr %74, align 4, !dbg !394, !tbaa !395
  call void @llvm.dbg.value(metadata i32 %75, metadata !390, metadata !DIExpression()), !dbg !391
  %76 = getelementptr inbounds %struct.iphdr, ptr %38, i64 0, i32 8, i32 0, i32 1, !dbg !396
  %77 = load i32, ptr %76, align 4, !dbg !396, !tbaa !395
  store i32 %77, ptr %74, align 4, !dbg !397, !tbaa !395
  store i32 %75, ptr %76, align 4, !dbg !398, !tbaa !395
  call void @llvm.dbg.value(metadata i16 0, metadata !213, metadata !DIExpression()), !dbg !231
  br label %84, !dbg !399

78:                                               ; preds = %69
  call void @llvm.dbg.value(metadata i8 %70, metadata !140, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !231
  %79 = icmp eq i8 %70, -128
  %80 = select i1 %65, i1 %79, i1 false, !dbg !400
  br i1 %80, label %81, label %102, !dbg !400

81:                                               ; preds = %78
  call void @llvm.dbg.value(metadata ptr %38, metadata !170, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.declare(metadata ptr %3, metadata !402, metadata !DIExpression()), !dbg !408
  call void @llvm.dbg.value(metadata ptr %38, metadata !407, metadata !DIExpression()), !dbg !411
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %3), !dbg !412
  %82 = getelementptr inbounds %struct.ipv6hdr, ptr %38, i64 0, i32 5, !dbg !413
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 4 dereferenceable(16) %3, ptr noundef nonnull align 4 dereferenceable(16) %82, i64 16, i1 false), !dbg !413, !tbaa.struct !414
  %83 = getelementptr inbounds %struct.ipv6hdr, ptr %38, i64 0, i32 5, i32 0, i32 1, !dbg !415
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 4 dereferenceable(16) %82, ptr noundef nonnull align 4 dereferenceable(16) %83, i64 16, i1 false), !dbg !415, !tbaa.struct !414
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 4 dereferenceable(16) %83, ptr noundef nonnull align 4 dereferenceable(16) %3, i64 16, i1 false), !dbg !416, !tbaa.struct !414
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %3), !dbg !417
  call void @llvm.dbg.value(metadata i16 129, metadata !213, metadata !DIExpression()), !dbg !231
  br label %84

84:                                               ; preds = %81, %73
  %85 = phi i8 [ 0, %73 ], [ -127, %81 ]
  call void @llvm.dbg.value(metadata i16 poison, metadata !213, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.value(metadata ptr %11, metadata !127, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.value(metadata ptr %11, metadata !418, metadata !DIExpression()), !dbg !425
  call void @llvm.lifetime.start.p0(i64 6, ptr nonnull %2), !dbg !427
  call void @llvm.dbg.declare(metadata ptr %2, metadata !423, metadata !DIExpression()), !dbg !428
  %86 = getelementptr inbounds %struct.ethhdr, ptr %11, i64 0, i32 1, !dbg !429
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(6) %2, ptr noundef nonnull align 1 dereferenceable(6) %86, i64 6, i1 false), !dbg !430
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(6) %86, ptr noundef nonnull align 1 dereferenceable(6) %11, i64 6, i1 false), !dbg !431
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(6) %11, ptr noundef nonnull align 1 dereferenceable(6) %2, i64 6, i1 false), !dbg !432
  call void @llvm.lifetime.end.p0(i64 6, ptr nonnull %2), !dbg !433
  call void @llvm.dbg.value(metadata ptr %66, metadata !215, metadata !DIExpression()), !dbg !231
  %87 = getelementptr inbounds %struct.icmphdr_common, ptr %66, i64 0, i32 2, !dbg !434
  %88 = load i16, ptr %87, align 2, !dbg !434, !tbaa !435
  call void @llvm.dbg.value(metadata i16 %88, metadata !214, metadata !DIExpression()), !dbg !231
  store i16 0, ptr %87, align 2, !dbg !436, !tbaa !435
  %89 = load i32, ptr %66, align 2, !dbg !437
  store i32 %89, ptr %4, align 4, !dbg !437
  store i8 %85, ptr %66, align 2, !dbg !438, !tbaa !380
  %90 = xor i16 %88, -1, !dbg !439
  call void @llvm.dbg.value(metadata i16 %90, metadata !440, metadata !DIExpression()), !dbg !449
  call void @llvm.dbg.value(metadata ptr %66, metadata !445, metadata !DIExpression()), !dbg !449
  call void @llvm.dbg.value(metadata ptr %4, metadata !446, metadata !DIExpression()), !dbg !449
  call void @llvm.dbg.value(metadata i32 4, metadata !448, metadata !DIExpression()), !dbg !449
  %91 = zext i16 %90 to i32, !dbg !451
  %92 = call i64 inttoptr (i64 28 to ptr)(ptr noundef nonnull %4, i32 noundef 4, ptr noundef nonnull %66, i32 noundef 4, i32 noundef %91) #6, !dbg !452
  %93 = trunc i64 %92 to i32, !dbg !452
  call void @llvm.dbg.value(metadata i32 %93, metadata !447, metadata !DIExpression()), !dbg !449
  call void @llvm.dbg.value(metadata i32 %93, metadata !453, metadata !DIExpression()), !dbg !459
  %94 = lshr i32 %93, 16, !dbg !461
  %95 = and i32 %93, 65535, !dbg !462
  %96 = add nuw nsw i32 %94, %95, !dbg !463
  call void @llvm.dbg.value(metadata i32 %96, metadata !458, metadata !DIExpression()), !dbg !459
  %97 = lshr i32 %96, 16, !dbg !464
  %98 = add nuw nsw i32 %97, %96, !dbg !465
  call void @llvm.dbg.value(metadata i32 %98, metadata !458, metadata !DIExpression()), !dbg !459
  %99 = trunc i32 %98 to i16, !dbg !466
  %100 = xor i16 %99, -1, !dbg !466
  store i16 %100, ptr %87, align 2, !dbg !467, !tbaa !435
  call void @llvm.dbg.value(metadata i32 3, metadata !223, metadata !DIExpression()), !dbg !231
  %101 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @xdp_icmp_echo_func.____fmt, i32 noundef 3) #6, !dbg !468
  br label %102, !dbg !470

102:                                              ; preds = %37, %63, %56, %48, %43, %40, %1, %78, %59, %52, %84
  %103 = phi i32 [ 2, %52 ], [ 3, %84 ], [ 2, %78 ], [ 2, %59 ], [ 2, %1 ], [ 2, %40 ], [ 2, %43 ], [ 2, %48 ], [ 2, %56 ], [ 2, %63 ], [ 2, %37 ], !dbg !231
  call void @llvm.dbg.value(metadata i32 %103, metadata !223, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.label(metadata !224), !dbg !471
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4) #6, !dbg !472
  ret i32 %103, !dbg !473
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #4

; Function Attrs: nounwind memory(none)
declare i1 @llvm.bpf.passthrough.i1.i1(i32, i1) #5

attributes #0 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind memory(none) }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!20}
!llvm.module.flags = !{!226, !227, !228, !229}
!llvm.ident = !{!230}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "____fmt", scope: !2, file: !3, line: 133, type: !225, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "xdp_icmp_echo_func", scope: !3, file: !3, line: 60, type: !4, scopeLine: 61, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !118)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/a/xdp-tutorial/space-echo", checksumkind: CSK_MD5, checksum: "25cbbe55b247783c7922bde70679c744")
!4 = !DISubroutineType(types: !5)
!5 = !{!6, !7}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !9, line: 6212, size: 192, elements: !10)
!9 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "c8368d268df2d203be10308c6a67c158")
!10 = !{!11, !15, !16, !17, !18, !19}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !8, file: !9, line: 6213, baseType: !12, size: 32)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !13, line: 27, baseType: !14)
!13 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!14 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !8, file: !9, line: 6214, baseType: !12, size: 32, offset: 32)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !8, file: !9, line: 6215, baseType: !12, size: 32, offset: 64)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !8, file: !9, line: 6217, baseType: !12, size: 32, offset: 96)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !8, file: !9, line: 6218, baseType: !12, size: 32, offset: 128)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !8, file: !9, line: 6220, baseType: !12, size: 32, offset: 160)
!20 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 16.0.6 (15)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !21, retainedTypes: !61, globals: !69, splitDebugInlining: false, nameTableKind: None)
!21 = !{!22, !29}
!22 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !9, line: 6201, baseType: !14, size: 32, elements: !23)
!23 = !{!24, !25, !26, !27, !28}
!24 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!25 = !DIEnumerator(name: "XDP_DROP", value: 1)
!26 = !DIEnumerator(name: "XDP_PASS", value: 2)
!27 = !DIEnumerator(name: "XDP_TX", value: 3)
!28 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!29 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !30, line: 29, baseType: !14, size: 32, elements: !31)
!30 = !DIFile(filename: "/usr/include/linux/in.h", directory: "", checksumkind: CSK_MD5, checksum: "fcee415bb19db8acb968eeda6f02fa29")
!31 = !{!32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !53, !54, !55, !56, !57, !58, !59, !60}
!32 = !DIEnumerator(name: "IPPROTO_IP", value: 0)
!33 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1)
!34 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2)
!35 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4)
!36 = !DIEnumerator(name: "IPPROTO_TCP", value: 6)
!37 = !DIEnumerator(name: "IPPROTO_EGP", value: 8)
!38 = !DIEnumerator(name: "IPPROTO_PUP", value: 12)
!39 = !DIEnumerator(name: "IPPROTO_UDP", value: 17)
!40 = !DIEnumerator(name: "IPPROTO_IDP", value: 22)
!41 = !DIEnumerator(name: "IPPROTO_TP", value: 29)
!42 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33)
!43 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41)
!44 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46)
!45 = !DIEnumerator(name: "IPPROTO_GRE", value: 47)
!46 = !DIEnumerator(name: "IPPROTO_ESP", value: 50)
!47 = !DIEnumerator(name: "IPPROTO_AH", value: 51)
!48 = !DIEnumerator(name: "IPPROTO_MTP", value: 92)
!49 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94)
!50 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98)
!51 = !DIEnumerator(name: "IPPROTO_PIM", value: 103)
!52 = !DIEnumerator(name: "IPPROTO_COMP", value: 108)
!53 = !DIEnumerator(name: "IPPROTO_L2TP", value: 115)
!54 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132)
!55 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136)
!56 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137)
!57 = !DIEnumerator(name: "IPPROTO_ETHERNET", value: 143)
!58 = !DIEnumerator(name: "IPPROTO_RAW", value: 255)
!59 = !DIEnumerator(name: "IPPROTO_MPTCP", value: 262)
!60 = !DIEnumerator(name: "IPPROTO_MAX", value: 263)
!61 = !{!62, !63, !64, !66}
!62 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!63 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!64 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !13, line: 24, baseType: !65)
!65 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!67 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !68, line: 34, baseType: !12)
!68 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "bf9fbc0e8f60927fef9d8917535375a6")
!69 = !{!0, !70, !76, !102, !111}
!70 = !DIGlobalVariableExpression(var: !71, expr: !DIExpression())
!71 = distinct !DIGlobalVariable(name: "_license", scope: !20, file: !3, line: 138, type: !72, isLocal: false, isDefinition: true)
!72 = !DICompositeType(tag: DW_TAG_array_type, baseType: !73, size: 32, elements: !74)
!73 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!74 = !{!75}
!75 = !DISubrange(count: 4)
!76 = !DIGlobalVariableExpression(var: !77, expr: !DIExpression())
!77 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !20, file: !78, line: 21, type: !79, isLocal: false, isDefinition: true)
!78 = !DIFile(filename: "./../common/xdp_stats_kern.h", directory: "/home/a/xdp-tutorial/space-echo", checksumkind: CSK_MD5, checksum: "2ed732331d6abc83898e83bb58b37126")
!79 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !78, line: 16, size: 256, elements: !80)
!80 = !{!81, !86, !88, !97}
!81 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !79, file: !78, line: 17, baseType: !82, size: 64)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 192, elements: !84)
!84 = !{!85}
!85 = !DISubrange(count: 6)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !79, file: !78, line: 18, baseType: !87, size: 64, offset: 64)
!87 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !79, file: !78, line: 19, baseType: !89, size: 64, offset: 128)
!89 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!90 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !91, line: 10, size: 128, elements: !92)
!91 = !DIFile(filename: "./../common/xdp_stats_kern_user.h", directory: "/home/a/xdp-tutorial/space-echo", checksumkind: CSK_MD5, checksum: "96c2435685fa7da2d24f219444d8659d")
!92 = !{!93, !96}
!93 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !90, file: !91, line: 11, baseType: !94, size: 64)
!94 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !13, line: 31, baseType: !95)
!95 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !90, file: !91, line: 12, baseType: !94, size: 64, offset: 64)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !79, file: !78, line: 20, baseType: !98, size: 64, offset: 192)
!98 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!99 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 160, elements: !100)
!100 = !{!101}
!101 = !DISubrange(count: 5)
!102 = !DIGlobalVariableExpression(var: !103, expr: !DIExpression())
!103 = distinct !DIGlobalVariable(name: "bpf_csum_diff", scope: !20, file: !104, line: 794, type: !105, isLocal: true, isDefinition: true)
!104 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/a/xdp-tutorial/space-echo", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !106, size: 64)
!106 = !DISubroutineType(types: !107)
!107 = !{!108, !66, !12, !66, !12, !110}
!108 = !DIDerivedType(tag: DW_TAG_typedef, name: "__s64", file: !13, line: 30, baseType: !109)
!109 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!110 = !DIDerivedType(tag: DW_TAG_typedef, name: "__wsum", file: !68, line: 39, baseType: !12)
!111 = !DIGlobalVariableExpression(var: !112, expr: !DIExpression())
!112 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !20, file: !104, line: 177, type: !113, isLocal: true, isDefinition: true)
!113 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !114, size: 64)
!114 = !DISubroutineType(types: !115)
!115 = !{!63, !116, !12, null}
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!117 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !73)
!118 = !{!119, !120, !121, !122, !127, !138, !139, !140, !141, !170, !213, !214, !215, !222, !223, !224}
!119 = !DILocalVariable(name: "ctx", arg: 1, scope: !2, file: !3, line: 60, type: !7)
!120 = !DILocalVariable(name: "data_end", scope: !2, file: !3, line: 62, type: !62)
!121 = !DILocalVariable(name: "data", scope: !2, file: !3, line: 63, type: !62)
!122 = !DILocalVariable(name: "nh", scope: !2, file: !3, line: 64, type: !123)
!123 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !124, line: 33, size: 64, elements: !125)
!124 = !DIFile(filename: "./../common/parsing_helpers.h", directory: "/home/a/xdp-tutorial/space-echo", checksumkind: CSK_MD5, checksum: "172efdd203783aed49c0ce78645261a8")
!125 = !{!126}
!126 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !123, file: !124, line: 34, baseType: !62, size: 64)
!127 = !DILocalVariable(name: "eth", scope: !2, file: !3, line: 65, type: !128)
!128 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 64)
!129 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !130, line: 173, size: 112, elements: !131)
!130 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "163f54fb1af2e21fea410f14eb18fa76")
!131 = !{!132, !135, !136}
!132 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !129, file: !130, line: 174, baseType: !133, size: 48)
!133 = !DICompositeType(tag: DW_TAG_array_type, baseType: !134, size: 48, elements: !84)
!134 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !129, file: !130, line: 175, baseType: !133, size: 48, offset: 48)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !129, file: !130, line: 176, baseType: !137, size: 16, offset: 96)
!137 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !68, line: 32, baseType: !64)
!138 = !DILocalVariable(name: "eth_type", scope: !2, file: !3, line: 66, type: !6)
!139 = !DILocalVariable(name: "ip_type", scope: !2, file: !3, line: 67, type: !6)
!140 = !DILocalVariable(name: "icmp_type", scope: !2, file: !3, line: 68, type: !6)
!141 = !DILocalVariable(name: "iphdr", scope: !2, file: !3, line: 69, type: !142)
!142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !143, size: 64)
!143 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !144, line: 87, size: 160, elements: !145)
!144 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "149778ace30a1ff208adc8783fd04b29")
!145 = !{!146, !148, !149, !150, !151, !152, !153, !154, !155, !157}
!146 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !143, file: !144, line: 89, baseType: !147, size: 4, flags: DIFlagBitField, extraData: i64 0)
!147 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !13, line: 21, baseType: !134)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !143, file: !144, line: 90, baseType: !147, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !143, file: !144, line: 97, baseType: !147, size: 8, offset: 8)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !143, file: !144, line: 98, baseType: !137, size: 16, offset: 16)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !143, file: !144, line: 99, baseType: !137, size: 16, offset: 32)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !143, file: !144, line: 100, baseType: !137, size: 16, offset: 48)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !143, file: !144, line: 101, baseType: !147, size: 8, offset: 64)
!154 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !143, file: !144, line: 102, baseType: !147, size: 8, offset: 72)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !143, file: !144, line: 103, baseType: !156, size: 16, offset: 80)
!156 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !68, line: 38, baseType: !64)
!157 = !DIDerivedType(tag: DW_TAG_member, scope: !143, file: !144, line: 104, baseType: !158, size: 64, offset: 96)
!158 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !143, file: !144, line: 104, size: 64, elements: !159)
!159 = !{!160, !165}
!160 = !DIDerivedType(tag: DW_TAG_member, scope: !158, file: !144, line: 104, baseType: !161, size: 64)
!161 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !158, file: !144, line: 104, size: 64, elements: !162)
!162 = !{!163, !164}
!163 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !161, file: !144, line: 104, baseType: !67, size: 32)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !161, file: !144, line: 104, baseType: !67, size: 32, offset: 32)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !158, file: !144, line: 104, baseType: !166, size: 64)
!166 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !158, file: !144, line: 104, size: 64, elements: !167)
!167 = !{!168, !169}
!168 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !166, file: !144, line: 104, baseType: !67, size: 32)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !166, file: !144, line: 104, baseType: !67, size: 32, offset: 32)
!170 = !DILocalVariable(name: "ipv6hdr", scope: !2, file: !3, line: 70, type: !171)
!171 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !172, size: 64)
!172 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ipv6hdr", file: !173, line: 118, size: 320, elements: !174)
!173 = !DIFile(filename: "/usr/include/linux/ipv6.h", directory: "", checksumkind: CSK_MD5, checksum: "5119f4e1c8becf2f187fa2b4015ad457")
!174 = !{!175, !176, !177, !181, !182, !183, !184}
!175 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !172, file: !173, line: 120, baseType: !147, size: 4, flags: DIFlagBitField, extraData: i64 0)
!176 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !172, file: !173, line: 121, baseType: !147, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!177 = !DIDerivedType(tag: DW_TAG_member, name: "flow_lbl", scope: !172, file: !173, line: 128, baseType: !178, size: 24, offset: 8)
!178 = !DICompositeType(tag: DW_TAG_array_type, baseType: !147, size: 24, elements: !179)
!179 = !{!180}
!180 = !DISubrange(count: 3)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "payload_len", scope: !172, file: !173, line: 130, baseType: !137, size: 16, offset: 32)
!182 = !DIDerivedType(tag: DW_TAG_member, name: "nexthdr", scope: !172, file: !173, line: 131, baseType: !147, size: 8, offset: 48)
!183 = !DIDerivedType(tag: DW_TAG_member, name: "hop_limit", scope: !172, file: !173, line: 132, baseType: !147, size: 8, offset: 56)
!184 = !DIDerivedType(tag: DW_TAG_member, scope: !172, file: !173, line: 134, baseType: !185, size: 256, offset: 64)
!185 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !172, file: !173, line: 134, size: 256, elements: !186)
!186 = !{!187, !208}
!187 = !DIDerivedType(tag: DW_TAG_member, scope: !185, file: !173, line: 134, baseType: !188, size: 256)
!188 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !185, file: !173, line: 134, size: 256, elements: !189)
!189 = !{!190, !207}
!190 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !188, file: !173, line: 134, baseType: !191, size: 128)
!191 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "in6_addr", file: !192, line: 33, size: 128, elements: !193)
!192 = !DIFile(filename: "/usr/include/linux/in6.h", directory: "", checksumkind: CSK_MD5, checksum: "8bebb780b45d3fe932cc1d934fa5f5fe")
!193 = !{!194}
!194 = !DIDerivedType(tag: DW_TAG_member, name: "in6_u", scope: !191, file: !192, line: 40, baseType: !195, size: 128)
!195 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !191, file: !192, line: 34, size: 128, elements: !196)
!196 = !{!197, !201, !205}
!197 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr8", scope: !195, file: !192, line: 35, baseType: !198, size: 128)
!198 = !DICompositeType(tag: DW_TAG_array_type, baseType: !147, size: 128, elements: !199)
!199 = !{!200}
!200 = !DISubrange(count: 16)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr16", scope: !195, file: !192, line: 37, baseType: !202, size: 128)
!202 = !DICompositeType(tag: DW_TAG_array_type, baseType: !137, size: 128, elements: !203)
!203 = !{!204}
!204 = !DISubrange(count: 8)
!205 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr32", scope: !195, file: !192, line: 38, baseType: !206, size: 128)
!206 = !DICompositeType(tag: DW_TAG_array_type, baseType: !67, size: 128, elements: !74)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !188, file: !173, line: 134, baseType: !191, size: 128, offset: 128)
!208 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !185, file: !173, line: 134, baseType: !209, size: 256)
!209 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !185, file: !173, line: 134, size: 256, elements: !210)
!210 = !{!211, !212}
!211 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !209, file: !173, line: 134, baseType: !191, size: 128)
!212 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !209, file: !173, line: 134, baseType: !191, size: 128, offset: 128)
!213 = !DILocalVariable(name: "echo_reply", scope: !2, file: !3, line: 72, type: !64)
!214 = !DILocalVariable(name: "old_csum", scope: !2, file: !3, line: 72, type: !64)
!215 = !DILocalVariable(name: "icmphdr", scope: !2, file: !3, line: 74, type: !216)
!216 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !217, size: 64)
!217 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmphdr_common", file: !124, line: 51, size: 32, elements: !218)
!218 = !{!219, !220, !221}
!219 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !217, file: !124, line: 52, baseType: !147, size: 8)
!220 = !DIDerivedType(tag: DW_TAG_member, name: "code", scope: !217, file: !124, line: 53, baseType: !147, size: 8, offset: 8)
!221 = !DIDerivedType(tag: DW_TAG_member, name: "cksum", scope: !217, file: !124, line: 54, baseType: !156, size: 16, offset: 16)
!222 = !DILocalVariable(name: "icmphdr_old", scope: !2, file: !3, line: 75, type: !217)
!223 = !DILocalVariable(name: "action", scope: !2, file: !3, line: 76, type: !12)
!224 = !DILabel(scope: !2, name: "out", file: !3, line: 134)
!225 = !DICompositeType(tag: DW_TAG_array_type, baseType: !117, size: 24, elements: !179)
!226 = !{i32 7, !"Dwarf Version", i32 5}
!227 = !{i32 2, !"Debug Info Version", i32 3}
!228 = !{i32 1, !"wchar_size", i32 4}
!229 = !{i32 7, !"frame-pointer", i32 2}
!230 = !{!"Ubuntu clang version 16.0.6 (15)"}
!231 = !DILocation(line: 0, scope: !2)
!232 = !DILocation(line: 62, column: 38, scope: !2)
!233 = !{!234, !235, i64 4}
!234 = !{!"xdp_md", !235, i64 0, !235, i64 4, !235, i64 8, !235, i64 12, !235, i64 16, !235, i64 20}
!235 = !{!"int", !236, i64 0}
!236 = !{!"omnipotent char", !237, i64 0}
!237 = !{!"Simple C/C++ TBAA"}
!238 = !DILocation(line: 62, column: 27, scope: !2)
!239 = !DILocation(line: 62, column: 19, scope: !2)
!240 = !DILocation(line: 63, column: 34, scope: !2)
!241 = !{!234, !235, i64 0}
!242 = !DILocation(line: 63, column: 23, scope: !2)
!243 = !DILocation(line: 63, column: 15, scope: !2)
!244 = !DILocation(line: 75, column: 2, scope: !2)
!245 = !DILocation(line: 75, column: 24, scope: !2)
!246 = !DILocalVariable(name: "nh", arg: 1, scope: !247, file: !124, line: 124, type: !250)
!247 = distinct !DISubprogram(name: "parse_ethhdr", scope: !124, file: !124, line: 124, type: !248, scopeLine: 127, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !252)
!248 = !DISubroutineType(types: !249)
!249 = !{!6, !250, !62, !251}
!250 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !123, size: 64)
!251 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !128, size: 64)
!252 = !{!246, !253, !254}
!253 = !DILocalVariable(name: "data_end", arg: 2, scope: !247, file: !124, line: 125, type: !62)
!254 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !247, file: !124, line: 126, type: !251)
!255 = !DILocation(line: 0, scope: !247, inlinedAt: !256)
!256 = distinct !DILocation(line: 82, column: 13, scope: !2)
!257 = !DILocalVariable(name: "nh", arg: 1, scope: !258, file: !124, line: 79, type: !250)
!258 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !124, file: !124, line: 79, type: !259, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !268)
!259 = !DISubroutineType(types: !260)
!260 = !{!6, !250, !62, !251, !261}
!261 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !262, size: 64)
!262 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !124, line: 64, size: 32, elements: !263)
!263 = !{!264}
!264 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !262, file: !124, line: 65, baseType: !265, size: 32)
!265 = !DICompositeType(tag: DW_TAG_array_type, baseType: !64, size: 32, elements: !266)
!266 = !{!267}
!267 = !DISubrange(count: 2)
!268 = !{!257, !269, !270, !271, !272, !273, !274, !280, !281}
!269 = !DILocalVariable(name: "data_end", arg: 2, scope: !258, file: !124, line: 80, type: !62)
!270 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !258, file: !124, line: 81, type: !251)
!271 = !DILocalVariable(name: "vlans", arg: 4, scope: !258, file: !124, line: 82, type: !261)
!272 = !DILocalVariable(name: "eth", scope: !258, file: !124, line: 84, type: !128)
!273 = !DILocalVariable(name: "hdrsize", scope: !258, file: !124, line: 85, type: !6)
!274 = !DILocalVariable(name: "vlh", scope: !258, file: !124, line: 86, type: !275)
!275 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !276, size: 64)
!276 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !124, line: 42, size: 32, elements: !277)
!277 = !{!278, !279}
!278 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !276, file: !124, line: 43, baseType: !137, size: 16)
!279 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !276, file: !124, line: 44, baseType: !137, size: 16, offset: 16)
!280 = !DILocalVariable(name: "h_proto", scope: !258, file: !124, line: 87, type: !64)
!281 = !DILocalVariable(name: "i", scope: !258, file: !124, line: 88, type: !6)
!282 = !DILocation(line: 0, scope: !258, inlinedAt: !283)
!283 = distinct !DILocation(line: 129, column: 9, scope: !247, inlinedAt: !256)
!284 = !DILocation(line: 93, column: 14, scope: !285, inlinedAt: !283)
!285 = distinct !DILexicalBlock(scope: !258, file: !124, line: 93, column: 6)
!286 = !DILocation(line: 93, column: 24, scope: !285, inlinedAt: !283)
!287 = !DILocation(line: 93, column: 6, scope: !258, inlinedAt: !283)
!288 = !DILocation(line: 99, column: 17, scope: !258, inlinedAt: !283)
!289 = !{!290, !290, i64 0}
!290 = !{!"short", !236, i64 0}
!291 = !DILocalVariable(name: "h_proto", arg: 1, scope: !292, file: !124, line: 68, type: !64)
!292 = distinct !DISubprogram(name: "proto_is_vlan", scope: !124, file: !124, line: 68, type: !293, scopeLine: 69, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !295)
!293 = !DISubroutineType(types: !294)
!294 = !{!6, !64}
!295 = !{!291}
!296 = !DILocation(line: 0, scope: !292, inlinedAt: !297)
!297 = distinct !DILocation(line: 106, column: 8, scope: !298, inlinedAt: !283)
!298 = distinct !DILexicalBlock(scope: !299, file: !124, line: 106, column: 7)
!299 = distinct !DILexicalBlock(scope: !300, file: !124, line: 105, column: 39)
!300 = distinct !DILexicalBlock(scope: !301, file: !124, line: 105, column: 2)
!301 = distinct !DILexicalBlock(scope: !258, file: !124, line: 105, column: 2)
!302 = !DILocation(line: 70, column: 20, scope: !292, inlinedAt: !297)
!303 = !DILocation(line: 70, column: 46, scope: !292, inlinedAt: !297)
!304 = !DILocation(line: 106, column: 7, scope: !299, inlinedAt: !283)
!305 = !DILocation(line: 112, column: 18, scope: !299, inlinedAt: !283)
!306 = !DILocation(line: 83, column: 6, scope: !2)
!307 = !DILocalVariable(name: "nh", arg: 1, scope: !308, file: !124, line: 151, type: !250)
!308 = distinct !DISubprogram(name: "parse_iphdr", scope: !124, file: !124, line: 151, type: !309, scopeLine: 154, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !312)
!309 = !DISubroutineType(types: !310)
!310 = !{!6, !250, !62, !311}
!311 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !142, size: 64)
!312 = !{!307, !313, !314, !315, !316}
!313 = !DILocalVariable(name: "data_end", arg: 2, scope: !308, file: !124, line: 152, type: !62)
!314 = !DILocalVariable(name: "iphdr", arg: 3, scope: !308, file: !124, line: 153, type: !311)
!315 = !DILocalVariable(name: "iph", scope: !308, file: !124, line: 155, type: !142)
!316 = !DILocalVariable(name: "hdrsize", scope: !308, file: !124, line: 156, type: !6)
!317 = !DILocation(line: 0, scope: !308, inlinedAt: !318)
!318 = distinct !DILocation(line: 84, column: 13, scope: !319)
!319 = distinct !DILexicalBlock(scope: !320, file: !3, line: 83, column: 39)
!320 = distinct !DILexicalBlock(scope: !2, file: !3, line: 83, column: 6)
!321 = !DILocation(line: 158, column: 10, scope: !322, inlinedAt: !318)
!322 = distinct !DILexicalBlock(scope: !308, file: !124, line: 158, column: 6)
!323 = !DILocation(line: 158, column: 14, scope: !322, inlinedAt: !318)
!324 = !DILocation(line: 158, column: 6, scope: !308, inlinedAt: !318)
!325 = !DILocation(line: 161, column: 17, scope: !308, inlinedAt: !318)
!326 = !DILocation(line: 161, column: 21, scope: !308, inlinedAt: !318)
!327 = !DILocation(line: 163, column: 13, scope: !328, inlinedAt: !318)
!328 = distinct !DILexicalBlock(scope: !308, file: !124, line: 163, column: 5)
!329 = !DILocation(line: 163, column: 5, scope: !308, inlinedAt: !318)
!330 = !DILocation(line: 167, column: 14, scope: !331, inlinedAt: !318)
!331 = distinct !DILexicalBlock(scope: !308, file: !124, line: 167, column: 6)
!332 = !DILocation(line: 167, column: 24, scope: !331, inlinedAt: !318)
!333 = !DILocation(line: 167, column: 6, scope: !308, inlinedAt: !318)
!334 = !DILocation(line: 173, column: 14, scope: !308, inlinedAt: !318)
!335 = !{!336, !236, i64 9}
!336 = !{!"iphdr", !236, i64 0, !236, i64 0, !236, i64 1, !290, i64 2, !290, i64 4, !290, i64 6, !236, i64 8, !236, i64 9, !290, i64 10, !236, i64 12}
!337 = !DILocation(line: 85, column: 15, scope: !338)
!338 = distinct !DILexicalBlock(scope: !319, file: !3, line: 85, column: 7)
!339 = !DILocation(line: 85, column: 7, scope: !319)
!340 = !DILocalVariable(name: "nh", arg: 1, scope: !341, file: !124, line: 132, type: !250)
!341 = distinct !DISubprogram(name: "parse_ip6hdr", scope: !124, file: !124, line: 132, type: !342, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !345)
!342 = !DISubroutineType(types: !343)
!343 = !{!6, !250, !62, !344}
!344 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !171, size: 64)
!345 = !{!340, !346, !347, !348}
!346 = !DILocalVariable(name: "data_end", arg: 2, scope: !341, file: !124, line: 133, type: !62)
!347 = !DILocalVariable(name: "ip6hdr", arg: 3, scope: !341, file: !124, line: 134, type: !344)
!348 = !DILocalVariable(name: "ip6h", scope: !341, file: !124, line: 136, type: !171)
!349 = !DILocation(line: 0, scope: !341, inlinedAt: !350)
!350 = distinct !DILocation(line: 88, column: 13, scope: !351)
!351 = distinct !DILexicalBlock(scope: !352, file: !3, line: 87, column: 48)
!352 = distinct !DILexicalBlock(scope: !320, file: !3, line: 87, column: 13)
!353 = !DILocation(line: 142, column: 11, scope: !354, inlinedAt: !350)
!354 = distinct !DILexicalBlock(scope: !341, file: !124, line: 142, column: 6)
!355 = !DILocation(line: 142, column: 15, scope: !354, inlinedAt: !350)
!356 = !DILocation(line: 142, column: 6, scope: !341, inlinedAt: !350)
!357 = !DILocation(line: 148, column: 15, scope: !341, inlinedAt: !350)
!358 = !{!359, !236, i64 6}
!359 = !{!"ipv6hdr", !236, i64 0, !236, i64 0, !236, i64 1, !290, i64 4, !236, i64 6, !236, i64 7, !236, i64 8}
!360 = !DILocation(line: 89, column: 15, scope: !361)
!361 = distinct !DILexicalBlock(scope: !351, file: !3, line: 89, column: 7)
!362 = !DILocation(line: 89, column: 7, scope: !351)
!363 = !DILocation(line: 79, column: 9, scope: !2)
!364 = !DILocalVariable(name: "nh", arg: 1, scope: !365, file: !124, line: 206, type: !250)
!365 = distinct !DISubprogram(name: "parse_icmphdr_common", scope: !124, file: !124, line: 206, type: !366, scopeLine: 209, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !369)
!366 = !DISubroutineType(types: !367)
!367 = !{!6, !250, !62, !368}
!368 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !216, size: 64)
!369 = !{!364, !370, !371, !372}
!370 = !DILocalVariable(name: "data_end", arg: 2, scope: !365, file: !124, line: 207, type: !62)
!371 = !DILocalVariable(name: "icmphdr", arg: 3, scope: !365, file: !124, line: 208, type: !368)
!372 = !DILocalVariable(name: "h", scope: !365, file: !124, line: 210, type: !216)
!373 = !DILocation(line: 0, scope: !365, inlinedAt: !374)
!374 = distinct !DILocation(line: 96, column: 14, scope: !2)
!375 = !DILocation(line: 212, column: 8, scope: !376, inlinedAt: !374)
!376 = distinct !DILexicalBlock(scope: !365, file: !124, line: 212, column: 6)
!377 = !DILocation(line: 212, column: 12, scope: !376, inlinedAt: !374)
!378 = !DILocation(line: 212, column: 6, scope: !365, inlinedAt: !374)
!379 = !DILocation(line: 218, column: 12, scope: !365, inlinedAt: !374)
!380 = !{!381, !236, i64 0}
!381 = !{!"icmphdr_common", !236, i64 0, !236, i64 1, !290, i64 2}
!382 = !DILocation(line: 98, column: 38, scope: !383)
!383 = distinct !DILexicalBlock(scope: !2, file: !3, line: 98, column: 6)
!384 = !DILocalVariable(name: "iphdr", arg: 1, scope: !385, file: !386, line: 136, type: !142)
!385 = distinct !DISubprogram(name: "swap_src_dst_ipv4", scope: !386, file: !386, line: 136, type: !387, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !389)
!386 = !DIFile(filename: "./../common/rewrite_helpers.h", directory: "/home/a/xdp-tutorial/space-echo", checksumkind: CSK_MD5, checksum: "75040841dc53cbf2ffc17c0802a4440a")
!387 = !DISubroutineType(types: !388)
!388 = !{null, !142}
!389 = !{!384, !390}
!390 = !DILocalVariable(name: "tmp", scope: !385, file: !386, line: 138, type: !67)
!391 = !DILocation(line: 0, scope: !385, inlinedAt: !392)
!392 = distinct !DILocation(line: 100, column: 3, scope: !393)
!393 = distinct !DILexicalBlock(scope: !383, file: !3, line: 98, column: 65)
!394 = !DILocation(line: 138, column: 22, scope: !385, inlinedAt: !392)
!395 = !{!236, !236, i64 0}
!396 = !DILocation(line: 140, column: 24, scope: !385, inlinedAt: !392)
!397 = !DILocation(line: 140, column: 15, scope: !385, inlinedAt: !392)
!398 = !DILocation(line: 141, column: 15, scope: !385, inlinedAt: !392)
!399 = !DILocation(line: 104, column: 2, scope: !393)
!400 = !DILocation(line: 105, column: 6, scope: !401)
!401 = distinct !DILexicalBlock(scope: !383, file: !3, line: 104, column: 13)
!402 = !DILocalVariable(name: "tmp", scope: !403, file: !386, line: 127, type: !191)
!403 = distinct !DISubprogram(name: "swap_src_dst_ipv6", scope: !386, file: !386, line: 125, type: !404, scopeLine: 126, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !406)
!404 = !DISubroutineType(types: !405)
!405 = !{null, !171}
!406 = !{!407, !402}
!407 = !DILocalVariable(name: "ipv6", arg: 1, scope: !403, file: !386, line: 125, type: !171)
!408 = !DILocation(line: 127, column: 18, scope: !403, inlinedAt: !409)
!409 = distinct !DILocation(line: 107, column: 3, scope: !410)
!410 = distinct !DILexicalBlock(scope: !401, file: !3, line: 105, column: 43)
!411 = !DILocation(line: 0, scope: !403, inlinedAt: !409)
!412 = !DILocation(line: 127, column: 2, scope: !403, inlinedAt: !409)
!413 = !DILocation(line: 127, column: 30, scope: !403, inlinedAt: !409)
!414 = !{i64 0, i64 16, !395, i64 0, i64 16, !395, i64 0, i64 16, !395}
!415 = !DILocation(line: 129, column: 22, scope: !403, inlinedAt: !409)
!416 = !DILocation(line: 130, column: 16, scope: !403, inlinedAt: !409)
!417 = !DILocation(line: 131, column: 1, scope: !403, inlinedAt: !409)
!418 = !DILocalVariable(name: "eth", arg: 1, scope: !419, file: !386, line: 113, type: !128)
!419 = distinct !DISubprogram(name: "swap_src_dst_mac", scope: !386, file: !386, line: 113, type: !420, scopeLine: 114, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !422)
!420 = !DISubroutineType(types: !421)
!421 = !{null, !128}
!422 = !{!418, !423}
!423 = !DILocalVariable(name: "h_tmp", scope: !419, file: !386, line: 115, type: !424)
!424 = !DICompositeType(tag: DW_TAG_array_type, baseType: !147, size: 48, elements: !84)
!425 = !DILocation(line: 0, scope: !419, inlinedAt: !426)
!426 = distinct !DILocation(line: 116, column: 2, scope: !2)
!427 = !DILocation(line: 115, column: 2, scope: !419, inlinedAt: !426)
!428 = !DILocation(line: 115, column: 7, scope: !419, inlinedAt: !426)
!429 = !DILocation(line: 117, column: 31, scope: !419, inlinedAt: !426)
!430 = !DILocation(line: 117, column: 2, scope: !419, inlinedAt: !426)
!431 = !DILocation(line: 118, column: 2, scope: !419, inlinedAt: !426)
!432 = !DILocation(line: 119, column: 2, scope: !419, inlinedAt: !426)
!433 = !DILocation(line: 120, column: 1, scope: !419, inlinedAt: !426)
!434 = !DILocation(line: 122, column: 22, scope: !2)
!435 = !{!381, !290, i64 2}
!436 = !DILocation(line: 124, column: 17, scope: !2)
!437 = !DILocation(line: 126, column: 16, scope: !2)
!438 = !DILocation(line: 128, column: 16, scope: !2)
!439 = !DILocation(line: 130, column: 38, scope: !2)
!440 = !DILocalVariable(name: "seed", arg: 1, scope: !441, file: !3, line: 44, type: !64)
!441 = distinct !DISubprogram(name: "icmp_checksum_diff", scope: !3, file: !3, line: 43, type: !442, scopeLine: 47, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !444)
!442 = !DISubroutineType(types: !443)
!443 = !{!64, !64, !216, !216}
!444 = !{!440, !445, !446, !447, !448}
!445 = !DILocalVariable(name: "icmphdr_new", arg: 2, scope: !441, file: !3, line: 45, type: !216)
!446 = !DILocalVariable(name: "icmphdr_old", arg: 3, scope: !441, file: !3, line: 46, type: !216)
!447 = !DILocalVariable(name: "csum", scope: !441, file: !3, line: 49, type: !12)
!448 = !DILocalVariable(name: "size", scope: !441, file: !3, line: 49, type: !12)
!449 = !DILocation(line: 0, scope: !441, inlinedAt: !450)
!450 = distinct !DILocation(line: 130, column: 19, scope: !2)
!451 = !DILocation(line: 52, column: 81, scope: !441, inlinedAt: !450)
!452 = !DILocation(line: 52, column: 9, scope: !441, inlinedAt: !450)
!453 = !DILocalVariable(name: "csum", arg: 1, scope: !454, file: !3, line: 22, type: !12)
!454 = distinct !DISubprogram(name: "csum_fold_helper", scope: !3, file: !3, line: 22, type: !455, scopeLine: 23, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !457)
!455 = !DISubroutineType(types: !456)
!456 = !{!64, !12}
!457 = !{!453, !458}
!458 = !DILocalVariable(name: "sum", scope: !454, file: !3, line: 25, type: !12)
!459 = !DILocation(line: 0, scope: !454, inlinedAt: !460)
!460 = distinct !DILocation(line: 54, column: 9, scope: !441, inlinedAt: !450)
!461 = !DILocation(line: 28, column: 14, scope: !454, inlinedAt: !460)
!462 = !DILocation(line: 28, column: 29, scope: !454, inlinedAt: !460)
!463 = !DILocation(line: 28, column: 21, scope: !454, inlinedAt: !460)
!464 = !DILocation(line: 31, column: 14, scope: !454, inlinedAt: !460)
!465 = !DILocation(line: 31, column: 6, scope: !454, inlinedAt: !460)
!466 = !DILocation(line: 34, column: 9, scope: !454, inlinedAt: !460)
!467 = !DILocation(line: 130, column: 17, scope: !2)
!468 = !DILocation(line: 133, column: 2, scope: !469)
!469 = distinct !DILexicalBlock(scope: !2, file: !3, line: 133, column: 2)
!470 = !DILocation(line: 133, column: 2, scope: !2)
!471 = !DILocation(line: 134, column: 1, scope: !2)
!472 = !DILocation(line: 136, column: 1, scope: !2)
!473 = !DILocation(line: 135, column: 2, scope: !2)
