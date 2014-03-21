//
//  EKBSTree.m
//  EKAlgorithms
//
//  Created by Evgeny Karkan on 14.11.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKBSTree.h"


@implementation EKBSTree;

- (instancetype)initWithObject:(NSObject *)obj compareSelector:(SEL)selector
{
    if (self = [super init]) {
        self.root = [[EKBTreeNode alloc] init];
        self.root.object = obj;
        self.root.compareSelector = selector;
    }
    
    return self;
}

- (void)insertObject:(NSObject *)newObj
{
    EKBTreeNode *treeNode = [[EKBTreeNode alloc] init];
    treeNode.object = newObj;
    treeNode.compareSelector = self.root.compareSelector;
    
    EKBTreeNode *currentNode = self.root;
    
    while (YES) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSComparisonResult result = (NSComparisonResult)[newObj performSelector : currentNode.compareSelector withObject : currentNode.object];
#pragma clang diagnostic pop
        if (result >= 0) {
            if (!currentNode.rightChild) {
                currentNode.rightChild = treeNode;
                break;
            }
            else {
                currentNode = currentNode.rightChild;
            }
        }
        else {
            if (!currentNode.leftChild) {
                currentNode.leftChild = treeNode;
                break;
            }
            else {
                currentNode = currentNode.leftChild;
            }
        }
    }
}

- (void)printDescription
{
    [self.root printDescription];
}

    //TODO: to finish this
- (void)deleteObject:(NSObject *)obj
{
}

- (EKBTreeNode *)find:(NSObject *)obj
{
    EKBTreeNode *currentNode = self.root;
    while (YES) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSComparisonResult result = (NSComparisonResult)[obj performSelector : currentNode.compareSelector withObject : currentNode.object];
#pragma clang diagnostic pop
        if (result > 0) {
            if (currentNode.rightChild) {
                currentNode = currentNode.rightChild;
            } else
                return nil;
        } else if (result < 0) {
            if (currentNode.leftChild) {
                currentNode = currentNode.leftChild;
            } else
                return nil;
        } else {
            break;
        }
    }
    return currentNode;
}

@end
