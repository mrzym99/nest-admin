export const deepSortTree = (tree: any[], key: string, parentId?: string) => {
  tree.sort((a, b) => a[key] - b[key]);
  tree.forEach((item) => {
    item.parentId = parentId;
    if (item.children && item.children.length > 0) {
      item.isLeaf = false;
      deepSortTree(item.children, key, item.id);
    } else {
      item.isLeaf = true;
    }
  });

  return tree;
};
