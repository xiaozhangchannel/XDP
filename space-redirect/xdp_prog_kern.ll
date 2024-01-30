; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { ptr, ptr, ptr, ptr }
%struct.anon.0 = type { ptr, ptr, ptr, ptr }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.datarec = type { i64, i64 }

@redirect_params = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@xdp_stats_map = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !21
@llvm.compiler.used = appending global [3 x ptr] [ptr @redirect_params, ptr @xdp_redirect_map_func, ptr @xdp_stats_map], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_redirect_map_func(ptr nocapture noundef readonly %0) #0 section "xdp_redirect_map" !dbg !80 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata ptr %0, metadata !93, metadata !DIExpression()), !dbg !117
  %3 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 1, !dbg !118
  %4 = load i32, ptr %3, align 4, !dbg !118, !tbaa !119
  %5 = zext i32 %4 to i64, !dbg !124
  %6 = inttoptr i64 %5 to ptr, !dbg !125
  call void @llvm.dbg.value(metadata ptr %6, metadata !94, metadata !DIExpression()), !dbg !117
  %7 = load i32, ptr %0, align 4, !dbg !126, !tbaa !127
  %8 = zext i32 %7 to i64, !dbg !128
  %9 = inttoptr i64 %8 to ptr, !dbg !129
  call void @llvm.dbg.value(metadata ptr %9, metadata !95, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata i32 2, metadata !112, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata i32 0, metadata !115, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata ptr %9, metadata !96, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata ptr undef, metadata !130, metadata !DIExpression()), !dbg !139
  call void @llvm.dbg.value(metadata ptr %6, metadata !137, metadata !DIExpression()), !dbg !139
  call void @llvm.dbg.value(metadata ptr undef, metadata !138, metadata !DIExpression()), !dbg !139
  call void @llvm.dbg.value(metadata ptr undef, metadata !141, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.value(metadata ptr %6, metadata !153, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.value(metadata ptr undef, metadata !154, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.value(metadata ptr null, metadata !155, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.value(metadata ptr %9, metadata !156, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.value(metadata i32 14, metadata !157, metadata !DIExpression()), !dbg !166
  %10 = getelementptr i8, ptr %9, i64 14, !dbg !168
  %11 = icmp ugt ptr %10, %6, !dbg !170
  br i1 %11, label %31, label %12, !dbg !171

12:                                               ; preds = %1
  call void @llvm.dbg.value(metadata ptr %10, metadata !96, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata ptr %10, metadata !158, metadata !DIExpression()), !dbg !166
  %13 = getelementptr inbounds %struct.ethhdr, ptr %9, i64 0, i32 2, !dbg !172
  call void @llvm.dbg.value(metadata i16 poison, metadata !164, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.value(metadata i32 0, metadata !165, metadata !DIExpression()), !dbg !166
  %14 = load i16, ptr %13, align 1, !dbg !166, !tbaa !173
  call void @llvm.dbg.value(metadata i16 %14, metadata !164, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.value(metadata i16 %14, metadata !175, metadata !DIExpression()), !dbg !180
  %15 = icmp eq i16 %14, 129, !dbg !186
  %16 = icmp eq i16 %14, -22392, !dbg !187
  %17 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %15)
  %18 = or i1 %16, %17, !dbg !187
  %19 = getelementptr i8, ptr %9, i64 18
  %20 = icmp ule ptr %19, %6
  %21 = select i1 %18, i1 %20, i1 false, !dbg !188
  br i1 %21, label %22, label %27, !dbg !188

22:                                               ; preds = %12
  call void @llvm.dbg.value(metadata i16 poison, metadata !164, metadata !DIExpression()), !dbg !166
  %23 = getelementptr i8, ptr %9, i64 16, !dbg !189
  call void @llvm.dbg.value(metadata ptr %19, metadata !158, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.value(metadata i32 1, metadata !165, metadata !DIExpression()), !dbg !166
  %24 = load i16, ptr %23, align 1, !dbg !166, !tbaa !173
  call void @llvm.dbg.value(metadata i16 %24, metadata !164, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.value(metadata i16 %24, metadata !175, metadata !DIExpression()), !dbg !180
  %25 = icmp eq i16 %24, 129, !dbg !186
  %26 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %25)
  br label %27, !dbg !188

27:                                               ; preds = %22, %12
  call void @llvm.dbg.value(metadata ptr poison, metadata !96, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata i16 poison, metadata !111, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !117
  call void @llvm.dbg.value(metadata ptr %9, metadata !101, metadata !DIExpression()), !dbg !117
  %28 = getelementptr inbounds %struct.ethhdr, ptr %9, i64 0, i32 1, !dbg !190
  %29 = tail call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @redirect_params, ptr noundef nonnull %28) #6, !dbg !191
  call void @llvm.dbg.value(metadata ptr %29, metadata !113, metadata !DIExpression()), !dbg !117
  %30 = icmp eq ptr %29, null, !dbg !192
  br i1 %30, label %31, label %32, !dbg !194

31:                                               ; preds = %27, %1
  call void @llvm.dbg.value(metadata i32 2, metadata !112, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.label(metadata !116), !dbg !195
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !196
  call void @llvm.dbg.value(metadata ptr %0, metadata !201, metadata !DIExpression()), !dbg !196
  call void @llvm.dbg.value(metadata i32 2, metadata !202, metadata !DIExpression()), !dbg !196
  store i32 2, ptr %2, align 4, !tbaa !205
  br label %36, !dbg !206

32:                                               ; preds = %27
  call void @llvm.dbg.value(metadata ptr %9, metadata !101, metadata !DIExpression()), !dbg !117
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(6) %9, ptr noundef nonnull align 1 dereferenceable(6) %29, i64 6, i1 false), !dbg !207
  %33 = tail call i64 inttoptr (i64 23 to ptr)(i32 noundef 0, i64 noundef 0) #6, !dbg !208
  %34 = trunc i64 %33 to i32, !dbg !208
  call void @llvm.dbg.value(metadata i32 %34, metadata !112, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.label(metadata !116), !dbg !195
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !196
  call void @llvm.dbg.value(metadata ptr %0, metadata !201, metadata !DIExpression()), !dbg !196
  call void @llvm.dbg.value(metadata i32 %34, metadata !202, metadata !DIExpression()), !dbg !196
  store i32 %34, ptr %2, align 4, !tbaa !205
  %35 = icmp ugt i32 %34, 4, !dbg !209
  br i1 %35, label %50, label %36, !dbg !206

36:                                               ; preds = %31, %32
  call void @llvm.dbg.value(metadata ptr %2, metadata !202, metadata !DIExpression(DW_OP_deref)), !dbg !196
  %37 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @xdp_stats_map, ptr noundef nonnull %2) #6, !dbg !211
  call void @llvm.dbg.value(metadata ptr %37, metadata !203, metadata !DIExpression()), !dbg !196
  %38 = icmp eq ptr %37, null, !dbg !212
  br i1 %38, label %50, label %39, !dbg !214

39:                                               ; preds = %36
  %40 = load i64, ptr %37, align 8, !dbg !215, !tbaa !216
  %41 = add i64 %40, 1, !dbg !215
  store i64 %41, ptr %37, align 8, !dbg !215, !tbaa !216
  %42 = load i32, ptr %3, align 4, !dbg !219, !tbaa !119
  %43 = load i32, ptr %0, align 4, !dbg !220, !tbaa !127
  %44 = sub i32 %42, %43, !dbg !221
  %45 = zext i32 %44 to i64, !dbg !222
  %46 = getelementptr inbounds %struct.datarec, ptr %37, i64 0, i32 1, !dbg !223
  %47 = load i64, ptr %46, align 8, !dbg !224, !tbaa !225
  %48 = add i64 %47, %45, !dbg !224
  store i64 %48, ptr %46, align 8, !dbg !224, !tbaa !225
  %49 = load i32, ptr %2, align 4, !dbg !226, !tbaa !205
  call void @llvm.dbg.value(metadata i32 %49, metadata !202, metadata !DIExpression()), !dbg !196
  br label %50, !dbg !227

50:                                               ; preds = %32, %36, %39
  %51 = phi i32 [ 0, %32 ], [ %49, %39 ], [ 0, %36 ], !dbg !196
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !228
  ret i32 %51, !dbg !229
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.label(metadata) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #4

; Function Attrs: nounwind memory(none)
declare i1 @llvm.bpf.passthrough.i1.i1(i32, i1) #5

attributes #0 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind memory(none) }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!75, !76, !77, !78}
!llvm.ident = !{!79}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "redirect_params", scope: !2, file: !3, line: 35, type: !62, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 16.0.6 (15)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/a/xdp-tutorial/space-redirect3", checksumkind: CSK_MD5, checksum: "5b5a88c7273ff48e9a37780e4e9049d1")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 6201, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "c8368d268df2d203be10308c6a67c158")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !{!15, !16, !17}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!16 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !18, line: 24, baseType: !19)
!18 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!19 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!20 = !{!21, !0, !49, !57}
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !23, line: 21, type: !24, isLocal: false, isDefinition: true)
!23 = !DIFile(filename: "./../common/xdp_stats_kern.h", directory: "/home/a/xdp-tutorial/space-redirect3", checksumkind: CSK_MD5, checksum: "2ed732331d6abc83898e83bb58b37126")
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !23, line: 16, size: 256, elements: !25)
!25 = !{!26, !32, !35, !44}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !24, file: !23, line: 17, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 192, elements: !30)
!29 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!30 = !{!31}
!31 = !DISubrange(count: 6)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !24, file: !23, line: 18, baseType: !33, size: 64, offset: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !18, line: 27, baseType: !7)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !24, file: !23, line: 19, baseType: !36, size: 64, offset: 128)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !38, line: 10, size: 128, elements: !39)
!38 = !DIFile(filename: "./../common/xdp_stats_kern_user.h", directory: "/home/a/xdp-tutorial/space-redirect3", checksumkind: CSK_MD5, checksum: "96c2435685fa7da2d24f219444d8659d")
!39 = !{!40, !43}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !37, file: !38, line: 11, baseType: !41, size: 64)
!41 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !18, line: 31, baseType: !42)
!42 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !37, file: !38, line: 12, baseType: !41, size: 64, offset: 64)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !24, file: !23, line: 20, baseType: !45, size: 64, offset: 192)
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !46, size: 64)
!46 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 160, elements: !47)
!47 = !{!48}
!48 = !DISubrange(count: 5)
!49 = !DIGlobalVariableExpression(var: !50, expr: !DIExpression())
!50 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !51, line: 56, type: !52, isLocal: true, isDefinition: true)
!51 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/a/xdp-tutorial/space-redirect3", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DISubroutineType(types: !54)
!54 = !{!15, !15, !55}
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !56, size: 64)
!56 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!57 = !DIGlobalVariableExpression(var: !58, expr: !DIExpression())
!58 = distinct !DIGlobalVariable(name: "bpf_redirect", scope: !2, file: !51, line: 619, type: !59, isLocal: true, isDefinition: true)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = !DISubroutineType(types: !61)
!61 = !{!16, !34, !41}
!62 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 30, size: 256, elements: !63)
!63 = !{!64, !69, !73, !74}
!64 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !62, file: !3, line: 31, baseType: !65, size: 64)
!65 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !66, size: 64)
!66 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 32, elements: !67)
!67 = !{!68}
!68 = !DISubrange(count: 1)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !62, file: !3, line: 32, baseType: !70, size: 64, offset: 64)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DICompositeType(tag: DW_TAG_array_type, baseType: !72, size: 48, elements: !30)
!72 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !62, file: !3, line: 33, baseType: !70, size: 64, offset: 128)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !62, file: !3, line: 34, baseType: !65, size: 64, offset: 192)
!75 = !{i32 7, !"Dwarf Version", i32 5}
!76 = !{i32 2, !"Debug Info Version", i32 3}
!77 = !{i32 1, !"wchar_size", i32 4}
!78 = !{i32 7, !"frame-pointer", i32 2}
!79 = !{!"Ubuntu clang version 16.0.6 (15)"}
!80 = distinct !DISubprogram(name: "xdp_redirect_map_func", scope: !3, file: !3, line: 39, type: !81, scopeLine: 40, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !92)
!81 = !DISubroutineType(types: !82)
!82 = !{!29, !83}
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !84, size: 64)
!84 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 6212, size: 192, elements: !85)
!85 = !{!86, !87, !88, !89, !90, !91}
!86 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !84, file: !6, line: 6213, baseType: !34, size: 32)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !84, file: !6, line: 6214, baseType: !34, size: 32, offset: 32)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !84, file: !6, line: 6215, baseType: !34, size: 32, offset: 64)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !84, file: !6, line: 6217, baseType: !34, size: 32, offset: 96)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !84, file: !6, line: 6218, baseType: !34, size: 32, offset: 128)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !84, file: !6, line: 6220, baseType: !34, size: 32, offset: 160)
!92 = !{!93, !94, !95, !96, !101, !111, !112, !113, !115, !116}
!93 = !DILocalVariable(name: "ctx", arg: 1, scope: !80, file: !3, line: 39, type: !83)
!94 = !DILocalVariable(name: "data_end", scope: !80, file: !3, line: 41, type: !15)
!95 = !DILocalVariable(name: "data", scope: !80, file: !3, line: 42, type: !15)
!96 = !DILocalVariable(name: "nh", scope: !80, file: !3, line: 43, type: !97)
!97 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !98, line: 33, size: 64, elements: !99)
!98 = !DIFile(filename: "./../common/parsing_helpers.h", directory: "/home/a/xdp-tutorial/space-redirect3", checksumkind: CSK_MD5, checksum: "172efdd203783aed49c0ce78645261a8")
!99 = !{!100}
!100 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !97, file: !98, line: 34, baseType: !15, size: 64)
!101 = !DILocalVariable(name: "eth", scope: !80, file: !3, line: 44, type: !102)
!102 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !103, size: 64)
!103 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !104, line: 173, size: 112, elements: !105)
!104 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "163f54fb1af2e21fea410f14eb18fa76")
!105 = !{!106, !107, !108}
!106 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !103, file: !104, line: 174, baseType: !71, size: 48)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !103, file: !104, line: 175, baseType: !71, size: 48, offset: 48)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !103, file: !104, line: 176, baseType: !109, size: 16, offset: 96)
!109 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !110, line: 32, baseType: !17)
!110 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "bf9fbc0e8f60927fef9d8917535375a6")
!111 = !DILocalVariable(name: "eth_type", scope: !80, file: !3, line: 45, type: !29)
!112 = !DILocalVariable(name: "action", scope: !80, file: !3, line: 46, type: !29)
!113 = !DILocalVariable(name: "dst", scope: !80, file: !3, line: 47, type: !114)
!114 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!115 = !DILocalVariable(name: "ifindex", scope: !80, file: !3, line: 48, type: !7)
!116 = !DILabel(scope: !80, name: "out", file: !3, line: 70)
!117 = !DILocation(line: 0, scope: !80)
!118 = !DILocation(line: 41, column: 38, scope: !80)
!119 = !{!120, !121, i64 4}
!120 = !{!"xdp_md", !121, i64 0, !121, i64 4, !121, i64 8, !121, i64 12, !121, i64 16, !121, i64 20}
!121 = !{!"int", !122, i64 0}
!122 = !{!"omnipotent char", !123, i64 0}
!123 = !{!"Simple C/C++ TBAA"}
!124 = !DILocation(line: 41, column: 27, scope: !80)
!125 = !DILocation(line: 41, column: 19, scope: !80)
!126 = !DILocation(line: 42, column: 34, scope: !80)
!127 = !{!120, !121, i64 0}
!128 = !DILocation(line: 42, column: 23, scope: !80)
!129 = !DILocation(line: 42, column: 15, scope: !80)
!130 = !DILocalVariable(name: "nh", arg: 1, scope: !131, file: !98, line: 124, type: !134)
!131 = distinct !DISubprogram(name: "parse_ethhdr", scope: !98, file: !98, line: 124, type: !132, scopeLine: 127, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !136)
!132 = !DISubroutineType(types: !133)
!133 = !{!29, !134, !15, !135}
!134 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 64)
!135 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !102, size: 64)
!136 = !{!130, !137, !138}
!137 = !DILocalVariable(name: "data_end", arg: 2, scope: !131, file: !98, line: 125, type: !15)
!138 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !131, file: !98, line: 126, type: !135)
!139 = !DILocation(line: 0, scope: !131, inlinedAt: !140)
!140 = distinct !DILocation(line: 54, column: 13, scope: !80)
!141 = !DILocalVariable(name: "nh", arg: 1, scope: !142, file: !98, line: 79, type: !134)
!142 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !98, file: !98, line: 79, type: !143, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !152)
!143 = !DISubroutineType(types: !144)
!144 = !{!29, !134, !15, !135, !145}
!145 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !146, size: 64)
!146 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !98, line: 64, size: 32, elements: !147)
!147 = !{!148}
!148 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !146, file: !98, line: 65, baseType: !149, size: 32)
!149 = !DICompositeType(tag: DW_TAG_array_type, baseType: !17, size: 32, elements: !150)
!150 = !{!151}
!151 = !DISubrange(count: 2)
!152 = !{!141, !153, !154, !155, !156, !157, !158, !164, !165}
!153 = !DILocalVariable(name: "data_end", arg: 2, scope: !142, file: !98, line: 80, type: !15)
!154 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !142, file: !98, line: 81, type: !135)
!155 = !DILocalVariable(name: "vlans", arg: 4, scope: !142, file: !98, line: 82, type: !145)
!156 = !DILocalVariable(name: "eth", scope: !142, file: !98, line: 84, type: !102)
!157 = !DILocalVariable(name: "hdrsize", scope: !142, file: !98, line: 85, type: !29)
!158 = !DILocalVariable(name: "vlh", scope: !142, file: !98, line: 86, type: !159)
!159 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !160, size: 64)
!160 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !98, line: 42, size: 32, elements: !161)
!161 = !{!162, !163}
!162 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !160, file: !98, line: 43, baseType: !109, size: 16)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !160, file: !98, line: 44, baseType: !109, size: 16, offset: 16)
!164 = !DILocalVariable(name: "h_proto", scope: !142, file: !98, line: 87, type: !17)
!165 = !DILocalVariable(name: "i", scope: !142, file: !98, line: 88, type: !29)
!166 = !DILocation(line: 0, scope: !142, inlinedAt: !167)
!167 = distinct !DILocation(line: 129, column: 9, scope: !131, inlinedAt: !140)
!168 = !DILocation(line: 93, column: 14, scope: !169, inlinedAt: !167)
!169 = distinct !DILexicalBlock(scope: !142, file: !98, line: 93, column: 6)
!170 = !DILocation(line: 93, column: 24, scope: !169, inlinedAt: !167)
!171 = !DILocation(line: 93, column: 6, scope: !142, inlinedAt: !167)
!172 = !DILocation(line: 99, column: 17, scope: !142, inlinedAt: !167)
!173 = !{!174, !174, i64 0}
!174 = !{!"short", !122, i64 0}
!175 = !DILocalVariable(name: "h_proto", arg: 1, scope: !176, file: !98, line: 68, type: !17)
!176 = distinct !DISubprogram(name: "proto_is_vlan", scope: !98, file: !98, line: 68, type: !177, scopeLine: 69, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !179)
!177 = !DISubroutineType(types: !178)
!178 = !{!29, !17}
!179 = !{!175}
!180 = !DILocation(line: 0, scope: !176, inlinedAt: !181)
!181 = distinct !DILocation(line: 106, column: 8, scope: !182, inlinedAt: !167)
!182 = distinct !DILexicalBlock(scope: !183, file: !98, line: 106, column: 7)
!183 = distinct !DILexicalBlock(scope: !184, file: !98, line: 105, column: 39)
!184 = distinct !DILexicalBlock(scope: !185, file: !98, line: 105, column: 2)
!185 = distinct !DILexicalBlock(scope: !142, file: !98, line: 105, column: 2)
!186 = !DILocation(line: 70, column: 20, scope: !176, inlinedAt: !181)
!187 = !DILocation(line: 70, column: 46, scope: !176, inlinedAt: !181)
!188 = !DILocation(line: 106, column: 7, scope: !183, inlinedAt: !167)
!189 = !DILocation(line: 112, column: 18, scope: !183, inlinedAt: !167)
!190 = !DILocation(line: 59, column: 51, scope: !80)
!191 = !DILocation(line: 59, column: 8, scope: !80)
!192 = !DILocation(line: 60, column: 7, scope: !193)
!193 = distinct !DILexicalBlock(scope: !80, file: !3, line: 60, column: 6)
!194 = !DILocation(line: 60, column: 6, scope: !80)
!195 = !DILocation(line: 70, column: 1, scope: !80)
!196 = !DILocation(line: 0, scope: !197, inlinedAt: !204)
!197 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !23, file: !23, line: 24, type: !198, scopeLine: 25, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !200)
!198 = !DISubroutineType(types: !199)
!199 = !{!34, !83, !34}
!200 = !{!201, !202, !203}
!201 = !DILocalVariable(name: "ctx", arg: 1, scope: !197, file: !23, line: 24, type: !83)
!202 = !DILocalVariable(name: "action", arg: 2, scope: !197, file: !23, line: 24, type: !34)
!203 = !DILocalVariable(name: "rec", scope: !197, file: !23, line: 30, type: !36)
!204 = distinct !DILocation(line: 71, column: 9, scope: !80)
!205 = !{!121, !121, i64 0}
!206 = !DILocation(line: 26, column: 6, scope: !197, inlinedAt: !204)
!207 = !DILocation(line: 64, column: 2, scope: !80)
!208 = !DILocation(line: 67, column: 11, scope: !80)
!209 = !DILocation(line: 26, column: 13, scope: !210, inlinedAt: !204)
!210 = distinct !DILexicalBlock(scope: !197, file: !23, line: 26, column: 6)
!211 = !DILocation(line: 30, column: 24, scope: !197, inlinedAt: !204)
!212 = !DILocation(line: 31, column: 7, scope: !213, inlinedAt: !204)
!213 = distinct !DILexicalBlock(scope: !197, file: !23, line: 31, column: 6)
!214 = !DILocation(line: 31, column: 6, scope: !197, inlinedAt: !204)
!215 = !DILocation(line: 38, column: 17, scope: !197, inlinedAt: !204)
!216 = !{!217, !218, i64 0}
!217 = !{!"datarec", !218, i64 0, !218, i64 8}
!218 = !{!"long long", !122, i64 0}
!219 = !DILocation(line: 39, column: 25, scope: !197, inlinedAt: !204)
!220 = !DILocation(line: 39, column: 41, scope: !197, inlinedAt: !204)
!221 = !DILocation(line: 39, column: 34, scope: !197, inlinedAt: !204)
!222 = !DILocation(line: 39, column: 19, scope: !197, inlinedAt: !204)
!223 = !DILocation(line: 39, column: 7, scope: !197, inlinedAt: !204)
!224 = !DILocation(line: 39, column: 16, scope: !197, inlinedAt: !204)
!225 = !{!217, !218, i64 8}
!226 = !DILocation(line: 41, column: 9, scope: !197, inlinedAt: !204)
!227 = !DILocation(line: 41, column: 2, scope: !197, inlinedAt: !204)
!228 = !DILocation(line: 42, column: 1, scope: !197, inlinedAt: !204)
!229 = !DILocation(line: 71, column: 2, scope: !80)
