; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { ptr, ptr, ptr, ptr }
%struct.anon.0 = type { ptr, ptr, ptr, ptr }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.datarec = type { i64, i64 }

@src_macs = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@xdp_stats_map = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !21
@llvm.compiler.used = appending global [3 x ptr] [ptr @filter_ethernet_filter, ptr @src_macs, ptr @xdp_stats_map], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @filter_ethernet_filter(ptr nocapture noundef readonly %0) #0 section "xdp" !dbg !76 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata ptr %0, metadata !89, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.value(metadata i32 2, metadata !90, metadata !DIExpression()), !dbg !114
  %3 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 1, !dbg !115
  %4 = load i32, ptr %3, align 4, !dbg !115, !tbaa !116
  %5 = zext i32 %4 to i64, !dbg !121
  %6 = inttoptr i64 %5 to ptr, !dbg !122
  call void @llvm.dbg.value(metadata ptr %6, metadata !92, metadata !DIExpression()), !dbg !114
  %7 = load i32, ptr %0, align 4, !dbg !123, !tbaa !124
  %8 = zext i32 %7 to i64, !dbg !125
  %9 = inttoptr i64 %8 to ptr, !dbg !126
  call void @llvm.dbg.value(metadata ptr %9, metadata !93, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.value(metadata ptr %9, metadata !94, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.value(metadata ptr undef, metadata !127, metadata !DIExpression()), !dbg !136
  call void @llvm.dbg.value(metadata ptr %6, metadata !134, metadata !DIExpression()), !dbg !136
  call void @llvm.dbg.value(metadata ptr undef, metadata !135, metadata !DIExpression()), !dbg !136
  call void @llvm.dbg.value(metadata ptr undef, metadata !138, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.value(metadata ptr %6, metadata !150, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.value(metadata ptr undef, metadata !151, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.value(metadata ptr null, metadata !152, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.value(metadata ptr %9, metadata !153, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.value(metadata i32 14, metadata !154, metadata !DIExpression()), !dbg !163
  %10 = getelementptr i8, ptr %9, i64 14, !dbg !165
  %11 = icmp ugt ptr %10, %6, !dbg !167
  br i1 %11, label %31, label %12, !dbg !168

12:                                               ; preds = %1
  call void @llvm.dbg.value(metadata ptr %10, metadata !94, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.value(metadata ptr %10, metadata !155, metadata !DIExpression()), !dbg !163
  %13 = getelementptr inbounds %struct.ethhdr, ptr %9, i64 0, i32 2, !dbg !169
  call void @llvm.dbg.value(metadata i16 poison, metadata !161, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.value(metadata i32 0, metadata !162, metadata !DIExpression()), !dbg !163
  %14 = load i16, ptr %13, align 1, !dbg !163, !tbaa !170
  call void @llvm.dbg.value(metadata i16 %14, metadata !161, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.value(metadata i16 %14, metadata !172, metadata !DIExpression()), !dbg !177
  %15 = icmp eq i16 %14, 129, !dbg !183
  %16 = icmp eq i16 %14, -22392, !dbg !184
  %17 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %15)
  %18 = or i1 %16, %17, !dbg !184
  %19 = getelementptr i8, ptr %9, i64 18
  %20 = icmp ule ptr %19, %6
  %21 = select i1 %18, i1 %20, i1 false, !dbg !185
  br i1 %21, label %22, label %27, !dbg !185

22:                                               ; preds = %12
  call void @llvm.dbg.value(metadata i16 poison, metadata !161, metadata !DIExpression()), !dbg !163
  %23 = getelementptr i8, ptr %9, i64 16, !dbg !186
  call void @llvm.dbg.value(metadata ptr %19, metadata !155, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.value(metadata i32 1, metadata !162, metadata !DIExpression()), !dbg !163
  %24 = load i16, ptr %23, align 1, !dbg !163, !tbaa !170
  call void @llvm.dbg.value(metadata i16 %24, metadata !161, metadata !DIExpression()), !dbg !163
  call void @llvm.dbg.value(metadata i16 %24, metadata !172, metadata !DIExpression()), !dbg !177
  %25 = icmp eq i16 %24, 129, !dbg !183
  %26 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %25)
  br label %27, !dbg !185

27:                                               ; preds = %22, %12
  call void @llvm.dbg.value(metadata ptr poison, metadata !94, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.value(metadata i16 poison, metadata !99, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !114
  call void @llvm.dbg.value(metadata ptr %9, metadata !100, metadata !DIExpression()), !dbg !114
  %28 = getelementptr inbounds %struct.ethhdr, ptr %9, i64 0, i32 1, !dbg !187
  %29 = tail call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @src_macs, ptr noundef nonnull %28) #5, !dbg !188
  call void @llvm.dbg.value(metadata ptr %29, metadata !112, metadata !DIExpression()), !dbg !114
  %30 = icmp eq ptr %29, null, !dbg !189
  br i1 %30, label %31, label %32, !dbg !191

31:                                               ; preds = %27, %1
  call void @llvm.dbg.value(metadata i32 2, metadata !90, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.label(metadata !113), !dbg !192
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !193
  call void @llvm.dbg.value(metadata ptr %0, metadata !198, metadata !DIExpression()), !dbg !193
  call void @llvm.dbg.value(metadata i32 2, metadata !199, metadata !DIExpression()), !dbg !193
  store i32 2, ptr %2, align 4, !tbaa !205
  call void @llvm.dbg.value(metadata i32 poison, metadata !200, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !193
  call void @llvm.dbg.value(metadata i32 poison, metadata !201, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !193
  br label %35, !dbg !206

32:                                               ; preds = %27
  %33 = load i32, ptr %29, align 4, !dbg !207, !tbaa !205
  call void @llvm.dbg.value(metadata i32 %33, metadata !90, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.label(metadata !113), !dbg !192
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !193
  call void @llvm.dbg.value(metadata ptr %0, metadata !198, metadata !DIExpression()), !dbg !193
  call void @llvm.dbg.value(metadata i32 %33, metadata !199, metadata !DIExpression()), !dbg !193
  store i32 %33, ptr %2, align 4, !tbaa !205
  call void @llvm.dbg.value(metadata i32 poison, metadata !200, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !193
  call void @llvm.dbg.value(metadata i32 poison, metadata !201, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !193
  %34 = icmp ugt i32 %33, 4, !dbg !209
  br i1 %34, label %50, label %35, !dbg !206

35:                                               ; preds = %31, %32
  %36 = load i32, ptr %3, align 4, !dbg !211, !tbaa !116
  %37 = load i32, ptr %0, align 4, !dbg !212, !tbaa !124
  call void @llvm.dbg.value(metadata ptr %2, metadata !199, metadata !DIExpression(DW_OP_deref)), !dbg !193
  %38 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @xdp_stats_map, ptr noundef nonnull %2) #5, !dbg !213
  call void @llvm.dbg.value(metadata ptr %38, metadata !202, metadata !DIExpression()), !dbg !193
  %39 = icmp eq ptr %38, null, !dbg !214
  br i1 %39, label %50, label %40, !dbg !216

40:                                               ; preds = %35
  %41 = zext i32 %36 to i64, !dbg !217
  %42 = zext i32 %37 to i64, !dbg !218
  %43 = sub nsw i64 %41, %42, !dbg !219
  call void @llvm.dbg.value(metadata i64 %43, metadata !203, metadata !DIExpression()), !dbg !193
  %44 = load i64, ptr %38, align 8, !dbg !220, !tbaa !221
  %45 = add i64 %44, 1, !dbg !220
  store i64 %45, ptr %38, align 8, !dbg !220, !tbaa !221
  %46 = getelementptr inbounds %struct.datarec, ptr %38, i64 0, i32 1, !dbg !224
  %47 = load i64, ptr %46, align 8, !dbg !225, !tbaa !226
  %48 = add i64 %43, %47, !dbg !225
  store i64 %48, ptr %46, align 8, !dbg !225, !tbaa !226
  %49 = load i32, ptr %2, align 4, !dbg !227, !tbaa !205
  call void @llvm.dbg.value(metadata i32 %49, metadata !199, metadata !DIExpression()), !dbg !193
  br label %50

50:                                               ; preds = %32, %35, %40
  %51 = phi i32 [ 0, %32 ], [ %49, %40 ], [ 0, %35 ], !dbg !193
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !228
  ret i32 %51, !dbg !229
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.label(metadata) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

; Function Attrs: nounwind memory(none)
declare i1 @llvm.bpf.passthrough.i1.i1(i32, i1) #4

attributes #0 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nounwind memory(none) }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!71, !72, !73, !74}
!llvm.ident = !{!75}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "src_macs", scope: !2, file: !3, line: 30, type: !56, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 16.0.6 (15)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/a/xdp-tutorial/space-mac", checksumkind: CSK_MD5, checksum: "2d50f9056896e342f510841508cf63bd")
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
!20 = !{!21, !0, !48}
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 22, type: !23, isLocal: false, isDefinition: true)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 17, size: 256, elements: !24)
!24 = !{!25, !31, !34, !43}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !23, file: !3, line: 18, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 192, elements: !29)
!28 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!29 = !{!30}
!30 = !DISubrange(count: 6)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !23, file: !3, line: 19, baseType: !32, size: 64, offset: 64)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !18, line: 27, baseType: !7)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !23, file: !3, line: 20, baseType: !35, size: 64, offset: 128)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !36, size: 64)
!36 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !37, line: 18, size: 128, elements: !38)
!37 = !DIFile(filename: "./common_kern_user.h", directory: "/home/a/xdp-tutorial/space-mac", checksumkind: CSK_MD5, checksum: "4c22bfef7c3ec5c7532d6832627ad381")
!38 = !{!39, !42}
!39 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !36, file: !37, line: 19, baseType: !40, size: 64)
!40 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !18, line: 31, baseType: !41)
!41 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !36, file: !37, line: 20, baseType: !40, size: 64, offset: 64)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !23, file: !3, line: 21, baseType: !44, size: 64, offset: 192)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 64)
!45 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 160, elements: !46)
!46 = !{!47}
!47 = !DISubrange(count: 5)
!48 = !DIGlobalVariableExpression(var: !49, expr: !DIExpression())
!49 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !50, line: 56, type: !51, isLocal: true, isDefinition: true)
!50 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/a/xdp-tutorial/space-mac", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!52 = !DISubroutineType(types: !53)
!53 = !{!15, !15, !54}
!54 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!55 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!56 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 25, size: 256, elements: !57)
!57 = !{!58, !63, !65, !66}
!58 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !56, file: !3, line: 26, baseType: !59, size: 64)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 32, elements: !61)
!61 = !{!62}
!62 = !DISubrange(count: 1)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !56, file: !3, line: 27, baseType: !64, size: 64, offset: 64)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !56, file: !3, line: 28, baseType: !32, size: 64, offset: 128)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !56, file: !3, line: 29, baseType: !67, size: 64, offset: 192)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !68, size: 64)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 32768, elements: !69)
!69 = !{!70}
!70 = !DISubrange(count: 1024)
!71 = !{i32 7, !"Dwarf Version", i32 5}
!72 = !{i32 2, !"Debug Info Version", i32 3}
!73 = !{i32 1, !"wchar_size", i32 4}
!74 = !{i32 7, !"frame-pointer", i32 2}
!75 = !{!"Ubuntu clang version 16.0.6 (15)"}
!76 = distinct !DISubprogram(name: "filter_ethernet_filter", scope: !3, file: !3, line: 63, type: !77, scopeLine: 64, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !88)
!77 = !DISubroutineType(types: !78)
!78 = !{!28, !79}
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 6212, size: 192, elements: !81)
!81 = !{!82, !83, !84, !85, !86, !87}
!82 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !80, file: !6, line: 6213, baseType: !33, size: 32)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !80, file: !6, line: 6214, baseType: !33, size: 32, offset: 32)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !80, file: !6, line: 6215, baseType: !33, size: 32, offset: 64)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !80, file: !6, line: 6217, baseType: !33, size: 32, offset: 96)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !80, file: !6, line: 6218, baseType: !33, size: 32, offset: 128)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !80, file: !6, line: 6220, baseType: !33, size: 32, offset: 160)
!88 = !{!89, !90, !92, !93, !94, !99, !100, !112, !113}
!89 = !DILocalVariable(name: "ctx", arg: 1, scope: !76, file: !3, line: 63, type: !79)
!90 = !DILocalVariable(name: "action", scope: !76, file: !3, line: 65, type: !91)
!91 = !DIDerivedType(tag: DW_TAG_typedef, name: "xdp_act", file: !37, line: 9, baseType: !33)
!92 = !DILocalVariable(name: "data_end", scope: !76, file: !3, line: 66, type: !15)
!93 = !DILocalVariable(name: "data", scope: !76, file: !3, line: 67, type: !15)
!94 = !DILocalVariable(name: "nh", scope: !76, file: !3, line: 68, type: !95)
!95 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !96, line: 33, size: 64, elements: !97)
!96 = !DIFile(filename: "./../common/parsing_helpers.h", directory: "/home/a/xdp-tutorial/space-mac", checksumkind: CSK_MD5, checksum: "172efdd203783aed49c0ce78645261a8")
!97 = !{!98}
!98 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !95, file: !96, line: 34, baseType: !15, size: 64)
!99 = !DILocalVariable(name: "nh_type", scope: !76, file: !3, line: 69, type: !28)
!100 = !DILocalVariable(name: "eth", scope: !76, file: !3, line: 70, type: !101)
!101 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !102, size: 64)
!102 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !103, line: 173, size: 112, elements: !104)
!103 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "163f54fb1af2e21fea410f14eb18fa76")
!104 = !{!105, !108, !109}
!105 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !102, file: !103, line: 174, baseType: !106, size: 48)
!106 = !DICompositeType(tag: DW_TAG_array_type, baseType: !107, size: 48, elements: !29)
!107 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !102, file: !103, line: 175, baseType: !106, size: 48, offset: 48)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !102, file: !103, line: 176, baseType: !110, size: 16, offset: 96)
!110 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !111, line: 32, baseType: !17)
!111 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "bf9fbc0e8f60927fef9d8917535375a6")
!112 = !DILocalVariable(name: "value", scope: !76, file: !3, line: 71, type: !32)
!113 = !DILabel(scope: !76, name: "out", file: !3, line: 91)
!114 = !DILocation(line: 0, scope: !76)
!115 = !DILocation(line: 66, column: 38, scope: !76)
!116 = !{!117, !118, i64 4}
!117 = !{!"xdp_md", !118, i64 0, !118, i64 4, !118, i64 8, !118, i64 12, !118, i64 16, !118, i64 20}
!118 = !{!"int", !119, i64 0}
!119 = !{!"omnipotent char", !120, i64 0}
!120 = !{!"Simple C/C++ TBAA"}
!121 = !DILocation(line: 66, column: 27, scope: !76)
!122 = !DILocation(line: 66, column: 19, scope: !76)
!123 = !DILocation(line: 67, column: 34, scope: !76)
!124 = !{!117, !118, i64 0}
!125 = !DILocation(line: 67, column: 23, scope: !76)
!126 = !DILocation(line: 67, column: 15, scope: !76)
!127 = !DILocalVariable(name: "nh", arg: 1, scope: !128, file: !96, line: 124, type: !131)
!128 = distinct !DISubprogram(name: "parse_ethhdr", scope: !96, file: !96, line: 124, type: !129, scopeLine: 127, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !133)
!129 = !DISubroutineType(types: !130)
!130 = !{!28, !131, !15, !132}
!131 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !95, size: 64)
!132 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !101, size: 64)
!133 = !{!127, !134, !135}
!134 = !DILocalVariable(name: "data_end", arg: 2, scope: !128, file: !96, line: 125, type: !15)
!135 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !128, file: !96, line: 126, type: !132)
!136 = !DILocation(line: 0, scope: !128, inlinedAt: !137)
!137 = distinct !DILocation(line: 76, column: 12, scope: !76)
!138 = !DILocalVariable(name: "nh", arg: 1, scope: !139, file: !96, line: 79, type: !131)
!139 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !96, file: !96, line: 79, type: !140, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !149)
!140 = !DISubroutineType(types: !141)
!141 = !{!28, !131, !15, !132, !142}
!142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !143, size: 64)
!143 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !96, line: 64, size: 32, elements: !144)
!144 = !{!145}
!145 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !143, file: !96, line: 65, baseType: !146, size: 32)
!146 = !DICompositeType(tag: DW_TAG_array_type, baseType: !17, size: 32, elements: !147)
!147 = !{!148}
!148 = !DISubrange(count: 2)
!149 = !{!138, !150, !151, !152, !153, !154, !155, !161, !162}
!150 = !DILocalVariable(name: "data_end", arg: 2, scope: !139, file: !96, line: 80, type: !15)
!151 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !139, file: !96, line: 81, type: !132)
!152 = !DILocalVariable(name: "vlans", arg: 4, scope: !139, file: !96, line: 82, type: !142)
!153 = !DILocalVariable(name: "eth", scope: !139, file: !96, line: 84, type: !101)
!154 = !DILocalVariable(name: "hdrsize", scope: !139, file: !96, line: 85, type: !28)
!155 = !DILocalVariable(name: "vlh", scope: !139, file: !96, line: 86, type: !156)
!156 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !157, size: 64)
!157 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !96, line: 42, size: 32, elements: !158)
!158 = !{!159, !160}
!159 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !157, file: !96, line: 43, baseType: !110, size: 16)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !157, file: !96, line: 44, baseType: !110, size: 16, offset: 16)
!161 = !DILocalVariable(name: "h_proto", scope: !139, file: !96, line: 87, type: !17)
!162 = !DILocalVariable(name: "i", scope: !139, file: !96, line: 88, type: !28)
!163 = !DILocation(line: 0, scope: !139, inlinedAt: !164)
!164 = distinct !DILocation(line: 129, column: 9, scope: !128, inlinedAt: !137)
!165 = !DILocation(line: 93, column: 14, scope: !166, inlinedAt: !164)
!166 = distinct !DILexicalBlock(scope: !139, file: !96, line: 93, column: 6)
!167 = !DILocation(line: 93, column: 24, scope: !166, inlinedAt: !164)
!168 = !DILocation(line: 93, column: 6, scope: !139, inlinedAt: !164)
!169 = !DILocation(line: 99, column: 17, scope: !139, inlinedAt: !164)
!170 = !{!171, !171, i64 0}
!171 = !{!"short", !119, i64 0}
!172 = !DILocalVariable(name: "h_proto", arg: 1, scope: !173, file: !96, line: 68, type: !17)
!173 = distinct !DISubprogram(name: "proto_is_vlan", scope: !96, file: !96, line: 68, type: !174, scopeLine: 69, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !176)
!174 = !DISubroutineType(types: !175)
!175 = !{!28, !17}
!176 = !{!172}
!177 = !DILocation(line: 0, scope: !173, inlinedAt: !178)
!178 = distinct !DILocation(line: 106, column: 8, scope: !179, inlinedAt: !164)
!179 = distinct !DILexicalBlock(scope: !180, file: !96, line: 106, column: 7)
!180 = distinct !DILexicalBlock(scope: !181, file: !96, line: 105, column: 39)
!181 = distinct !DILexicalBlock(scope: !182, file: !96, line: 105, column: 2)
!182 = distinct !DILexicalBlock(scope: !139, file: !96, line: 105, column: 2)
!183 = !DILocation(line: 70, column: 20, scope: !173, inlinedAt: !178)
!184 = !DILocation(line: 70, column: 46, scope: !173, inlinedAt: !178)
!185 = !DILocation(line: 106, column: 7, scope: !180, inlinedAt: !164)
!186 = !DILocation(line: 112, column: 18, scope: !180, inlinedAt: !164)
!187 = !DILocation(line: 84, column: 46, scope: !76)
!188 = !DILocation(line: 84, column: 10, scope: !76)
!189 = !DILocation(line: 85, column: 6, scope: !190)
!190 = distinct !DILexicalBlock(scope: !76, file: !3, line: 85, column: 6)
!191 = !DILocation(line: 85, column: 6, scope: !76)
!192 = !DILocation(line: 91, column: 1, scope: !76)
!193 = !DILocation(line: 0, scope: !194, inlinedAt: !204)
!194 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 34, type: !195, scopeLine: 35, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !197)
!195 = !DISubroutineType(types: !196)
!196 = !{!33, !79, !33}
!197 = !{!198, !199, !200, !201, !202, !203}
!198 = !DILocalVariable(name: "ctx", arg: 1, scope: !194, file: !3, line: 34, type: !79)
!199 = !DILocalVariable(name: "action", arg: 2, scope: !194, file: !3, line: 34, type: !33)
!200 = !DILocalVariable(name: "data_end", scope: !194, file: !3, line: 36, type: !15)
!201 = !DILocalVariable(name: "data", scope: !194, file: !3, line: 37, type: !15)
!202 = !DILocalVariable(name: "rec", scope: !194, file: !3, line: 43, type: !35)
!203 = !DILocalVariable(name: "bytes", scope: !194, file: !3, line: 48, type: !40)
!204 = distinct !DILocation(line: 92, column: 9, scope: !76)
!205 = !{!118, !118, i64 0}
!206 = !DILocation(line: 39, column: 6, scope: !194, inlinedAt: !204)
!207 = !DILocation(line: 86, column: 18, scope: !208)
!208 = distinct !DILexicalBlock(scope: !190, file: !3, line: 85, column: 13)
!209 = !DILocation(line: 39, column: 13, scope: !210, inlinedAt: !204)
!210 = distinct !DILexicalBlock(scope: !194, file: !3, line: 39, column: 6)
!211 = !DILocation(line: 36, column: 38, scope: !194, inlinedAt: !204)
!212 = !DILocation(line: 37, column: 38, scope: !194, inlinedAt: !204)
!213 = !DILocation(line: 43, column: 24, scope: !194, inlinedAt: !204)
!214 = !DILocation(line: 44, column: 7, scope: !215, inlinedAt: !204)
!215 = distinct !DILexicalBlock(scope: !194, file: !3, line: 44, column: 6)
!216 = !DILocation(line: 44, column: 6, scope: !194, inlinedAt: !204)
!217 = !DILocation(line: 36, column: 27, scope: !194, inlinedAt: !204)
!218 = !DILocation(line: 37, column: 27, scope: !194, inlinedAt: !204)
!219 = !DILocation(line: 48, column: 25, scope: !194, inlinedAt: !204)
!220 = !DILocation(line: 54, column: 17, scope: !194, inlinedAt: !204)
!221 = !{!222, !223, i64 0}
!222 = !{!"datarec", !223, i64 0, !223, i64 8}
!223 = !{!"long long", !119, i64 0}
!224 = !DILocation(line: 55, column: 7, scope: !194, inlinedAt: !204)
!225 = !DILocation(line: 55, column: 16, scope: !194, inlinedAt: !204)
!226 = !{!222, !223, i64 8}
!227 = !DILocation(line: 57, column: 9, scope: !194, inlinedAt: !204)
!228 = !DILocation(line: 58, column: 1, scope: !194, inlinedAt: !204)
!229 = !DILocation(line: 92, column: 2, scope: !76)
