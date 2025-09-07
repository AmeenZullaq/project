// List<ValueFolderEntity> buildTree(List<ValueFolderEntity> folders) {
//   final folderMap = <String, ValueFolderEntity>{};

//   for (var f in folders) {
//     if (!folderMap.containsKey(f.id)) {
//       folderMap[f.id!] = f;
//       f.children = [];
//     } else {
//       print('Duplicate folder ID ignored: ${f.id}');
//     }
//   }

//   final addedChildIds = <String>{};

//   for (var folder in folders) {
//     if (folder.parentFolderId != null && folder.parentFolderId != '0') {
//       final parent = folderMap[folder.parentFolderId];
//       if (parent != null &&
//           folder.security?.objectType != 28 &&
//           (folder.savedFilterId == null || folder.savedFilterId!.isEmpty) &&
//           !addedChildIds.contains(folder.id!)) {
//         parent.children!.add(folder);
//         addedChildIds.add(folder.id!);
//       }
//     }
//   }

//   return folders
//       .where((f) => f.parentFolderId == '0' || f.parentFolderId == null)
//       .toList();
// }

// TreeNodeData? buildTreeNode(
//   BuildContext context,
//   ValueFolderEntity folder,
//   bool fromDeleteFolder,
//   int deleteId,
//   bool fromFolderMove,
//   Set<String> visitedIds,
// ) {
//   if (folder.id == null || visitedIds.contains(folder.id)) {
//     return null; // skip duplicates
//   }
//   visitedIds.add(folder.id!);

//   final key = ValueKey(folder.id);

//   final childrenData = folder.children!
//       .map((child) => buildTreeNode(
//             context,
//             child,
//             fromDeleteFolder,
//             deleteId,
//             fromFolderMove,
//             visitedIds,
//           ))
//       .where((child) => child != null)
//       .cast<TreeNodeData>()
//       .toList();

//   final treeNode = TreeNode(
//     key: key,
//     content: GestureDetector(
//       child: SizedBox(
//         width: 100,
//         child: CustomText(
//           folder.name ?? 'No Name',
//           ProjectFonts.largeBody(),
//         ),
//       ),
//       onTap: () {
//         var selected = folder.id;
//         var parentId = folder.parentFolderId;
//         List<String> objectId = [doc.arcDocumentId!];

//         if (fromDeleteFolder) {
//           if (AppConnectionInfoEntity
//               .temporaryCachedInstance!.withConfirmationMessage) {
//             confirmationDialog(
//               context,
//               actionName: 'Delete Folder',
//               noFunction: () => appRouter.maybePop(),
//               yesFunction: () async {
//                 await appRouter.maybePop();
//                 context.read<ActionsBloc>().add(
//                       FolderDeleteEvent(
//                         folderId: doc.arcDocumentId!,
//                         alternateFolderId: selected!,
//                         deleteOption: 1,
//                         context: context,
//                         deleteId: deleteId,
//                       ),
//                     );
//               },
//             );
//           } else {
//             context.read<ActionsBloc>().add(
//                   FolderDeleteEvent(
//                     folderId: doc.arcDocumentId!,
//                     alternateFolderId: selected!,
//                     deleteOption: 1,
//                     context: context,
//                     deleteId: deleteId,
//                   ),
//                 );
//           }
//         } else if (fromFolderMove) {
//           if (AppConnectionInfoEntity
//               .temporaryCachedInstance!.withConfirmationMessage) {
//             confirmationDialog(
//               context,
//               actionName: 'Move Folder',
//               noFunction: () => appRouter.maybePop(),
//               yesFunction: () async {
//                 await appRouter.maybePop();
//                 context.read<ActionsBloc>().add(
//                       FolderMoveEvent(
//                         NewParentFolderId: selected!,
//                         folderId: doc.arcDocumentId!,
//                         context: context,
//                       ),
//                     );
//               },
//             );
//           } else {
//             context.read<ActionsBloc>().add(
//                   FolderMoveEvent(
//                     NewParentFolderId: selected!,
//                     folderId: doc.arcDocumentId!,
//                     context: context,
//                   ),
//                 );
//           }
//         } else {
//           if (AppConnectionInfoEntity
//               .temporaryCachedInstance!.withConfirmationMessage) {
//             confirmationDialog(
//               context,
//               actionName: 'Move Document',
//               noFunction: () => appRouter.maybePop(),
//               yesFunction: () async {
//                 await appRouter.maybePop();
//                 context.read<ActionsBloc>().add(
//                       DocumentMoveEvent(
//                         toFolderId: selected!,
//                         docIds: objectId,
//                         context: context,
//                       ),
//                     );
//               },
//             );
//           } else {
//             context.read<ActionsBloc>().add(
//                   DocumentMoveEvent(
//                     toFolderId: selected!,
//                     docIds: objectId,
//                     context: context,
//                   ),
//                 );
//           }
//         }
//       },
//     ),
//     children: childrenData.map((e) => e.node).toList(),
//   );

//   return TreeNodeData(
//     key: key,
//     node: treeNode,
//     childrenKeys: childrenData.map((e) => e.key).toList(),
//   );
// }

// void collectAllKeys(TreeNodeData nodeData, Set<Key> keys) {
//   keys.add(nodeData.key);
//   for (final childKey in nodeData.childrenKeys) {
//     keys.add(childKey);
//   }
// }

// void showFolderDialog(
//   BuildContext context,
//   List<ValueFolderEntity> folders,
//   bool fromDeleteFolder,
//   int deleteId,
//   bool fromFolderMove,
// ) {
//   final visitedIds = <String>{};

//   final treeDataList = buildTree(folders)
//       .map((folder) => buildTreeNode(
//             context,
//             folder,
//             fromDeleteFolder,
//             deleteId,
//             fromFolderMove,
//             visitedIds,
//           ))
//       .where((node) => node != null)
//       .cast<TreeNodeData>()
//       .toList();

//   final treeNodes = treeDataList.map((e) => e.node).toList();

//   final treeController = TreeController(allNodesExpanded: false);

//   final allKeys = <Key>{};
//   for (final data in treeDataList) {
//     collectAllKeys(data, allKeys);
//   }

//   for (final key in allKeys) {
//     treeController.collapseNode(key);
//   }

//   for (final root in treeDataList) {
//     treeController.expandNode(root.key);
//   }

//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text(
//           AppLocalizations.of(context)?.translate('Select Folder') ??
//               'Select Folder',
//         ),
//         content: SizedBox(
//           width: 300,
//           height: 400,
//           child: treeNodes.isEmpty
//               ? Center(
//                   child: Text(
//                     AppLocalizations.of(context)?.translate(
//                           'No folders available',
//                         ) ??
//                         'No folders available',
//                   ),
//                 )
//               : Scrollbar(
//                   thickness: 5,
//                   thumbVisibility: true,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                       child: TreeView(
//                         nodes: treeNodes,
//                         indent: 30,
//                         treeController: treeController,
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text(
//               AppLocalizations.of(context)?.translate('Close') ?? 'Close',
//               style: TextStyle(color: AppTheme.appColor.primary),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

// List<Key> collectAllDescendantKeys(
//     TreeNodeData nodeData, List<TreeNodeData> allNodes) {
//   List<Key> descendantKeys = [];

//   for (var childKey in nodeData.childrenKeys) {
//     final childNode = allNodes.firstWhere(
//       (e) => e.key == childKey,
//       orElse: () => TreeNodeData(
//         key: ValueKey('not_found'),
//         node: TreeNode(key: ValueKey('not_found'), content: SizedBox()),
//         childrenKeys: [],
//       ),
//     );
//     if (childNode.key != ValueKey('not_found')) {
//       descendantKeys.add(childKey);
//       descendantKeys.addAll(collectAllDescendantKeys(childNode, allNodes));
//     }
//   }

//   return descendantKeys;
// }

// String getImagePathByType(int type) {
//   switch (type) {
//     case 1:
//       return 'document_list/document.svg';
//     case 3:
//       return 'document_list/folder.svg';
//     case 28:
//       return 'document_list/query.svg';
//     case 71:
//       return 'document_list/folder_shortcut.svg';
//     case 72:
//       return 'document_list/document_shortcut.svg';
//     default:
//       return "";
//   }
// }

// class TreeNodeData {
//   final Key key;
//   final TreeNode node;
//   final List<Key> childrenKeys;

//   TreeNodeData({
//     required this.key,
//     required this.node,
//     required this.childrenKeys,
//   });
// }
