//
//  Algorithm.swift
//  Algorithm_swift
//
//  Created by Huang Yanan on 2016/11/11.
//  Copyright © 2016年 Huang Yanan. All rights reserved.
//

import Foundation


// 交换数组中i和j两个位置的数据
extension Array {
    
    fileprivate mutating func swap(i:Int,j:Int) {
        
        (self[i], self[j]) = (self[j], self[i])
    }
}

/** 快速排序的算法思想
 *  一趟快速排序的算法是：
 *   1、设置两个变量i、j，排序开始的时候：i=0，j=N-1；
 *
 *   2、以第一个数组元素作为基准数据，赋值给key，即key=A[0]；
 *
 *   3、从j开始向前搜索，即由后开始向前搜索(j减1)，找到第一个小于key的值A[j]，将A[j]和A[i]互换；
 *
 *   4、从i开始向后搜索，即由前开始向后搜索(i++)，找到第一个大于key的A[i]，将A[i]和A[j]互换；
 *
 *   5、重复第3、4步，直到i=j； (3,4步中，没找到符合条件的值，即3中A[j]不小于key,4中A[i]不大于key的时候改变j、i的值，
 *     使得j=j-1，i=i+1，直至找到为止。找到符合条件的值，进行交换的时候i， j指针位置不变。
 *     另外，i==j这一过程一定正好是i+或j-完成的时候，此时令循环结束）。
 *
 */

extension Array where Element: Comparable {

    private mutating func quickPartition(left: Int, right: Int) -> Int {
        
        var right = right
        var left = left
        
        // 记录哪个是基准数
        let base = self[left]
        // 记录基准数位置
        let baseIndex = left
        
        // 先从右边往左边扫描，找到第一个比base要小的数，但是不能与left相遇
        while left < right && self[right] >= base {
            right = right-1
        }
        
        // 再从左边往右边扫描，找到第一个比base还要大的数，但是不能与right相遇
        while left < right && self[left] <= base {
            left = left+1
        }
        
        // 交换 左边比base大的数和右边比base小的数
        swap(i: left, j: right)
        
        // 交换左边比base大的数和基准数
        swap(i: baseIndex, j: left)
        
        // 返回新的基准数
        return left
        
    }

    /// 快速排序
    ///
    /// - Parameters:
    ///   - a: 数组a
    ///   - left: 左边索引
    ///   - right: 右边索引
    private mutating func quickSort(left: Int, right: Int) -> Array {
        
        // 排序完毕，退出递归
        if left >= right {
            return self
        }
        
        // 每一趟划分，使左边的比基准小，右边的比基准大，并返回新的基准的位置
        let baseIndex = quickPartition(left: left, right: right)
        
        // 判断左边是否排完，没排完递归排左边部分
        if baseIndex - 1 > left {
            self = quickSort(left: left, right: baseIndex - 1)
        }
        // 判断右边是否排完，没排完递归排右边部分
        if baseIndex + 1 < right {
           self = quickSort(left: baseIndex + 1, right: right)
        }
        return self
    }
    
    mutating func quickSort() -> Array {
        return quickSort(left: 0, right: self.count-1)
    }
    
}



// MARK: - 选择排序
/** 选择排序算法思想
 *  每一趟从前往后查找出值最小的索引（下标），最后通过比较是否需要交换。每一趟都将最小的元素交换到最前面。
 *  大致过程
 *  6, 4, 9, 7, 5（开始）
 *  4, 6, 9, 7, 5（第一趟：将最小的4与6交换，使这一趟最小值4放到最前面）
 *  4, 5, 9, 7, 6（第二趟：将最小的5与6交换，使这一趟最小值5放到最前面）
 *  4, 5, 6, 7, 9（第三趟：将最小的6与9交换，使这一趟最小值6放到最前面）
 *  4, 5, 6, 7, 9（第四趟：不需要交换，排序完成）
 */
extension Array where Element:Comparable {
    
    mutating func selectorSort() -> Array {
        
        var min = 0
        // 只需要n-1趟即可，到最后一趟只有一个元素，一定是最小的了
        for i in 0..<self.count-1 {
            // 每一趟的开始，假设该趟的第一个元素是最小的
            min = i
            
            // 查找该趟有没有更小的，如果找到更小的，则更新最小值的下标
            for j in i+1..<self.count-1 {
                if self[j] < self[min] {
                    min = j
                }
            }
            
            // 如果该趟的第一个元素不是最小的，说明需要交换
            if min != i {
                swap(i: min, j: i)
            }
            
        }
        return self
    }
    
}

// MARK: - 冒泡排序
/**
 * 通过与相邻元素的比较和交换，把小的数交换到最前面。
 */
extension Array where Element:Comparable {
    
    mutating func bubbleSort() -> Array {
    
        
        for i in 0..<self.count-1 {
            for j in (i+1...self.count-1).reversed() {
                // 后者小于前者，交换位置，即小的往上升大的往下沉
                if self[j] < self[j-1] {
                    swap(i: j, j: j-1)
                }
            }
        }
        return self
        
    }
}


// MARK: - 优化冒泡排序
/**
 * a = [2,1,3,4,5,6,7,8,9]
 * a数组在使用传统冒泡排序时，在i=2之后的遍历都是多余的，因为剩下的数据已经是有序的了。
 */
extension Array where Element:Comparable {
    
    mutating func optimizeBubbleSort()->Array {
        
        /* 设置一个标志 若flag为true说明有过数据交换，继续排序；否则说明数组已经是有序的了，停止循环 */
        var flag = true
        for i in 0..<self.count-1 {
            guard flag else {
                return self
            }
            flag = false
            for j in (i+1...self.count-1).reversed() {
                // 后者小于前者，交换位置，即小的往上升大的往下沉
                if self[j] < self[j-1] {
                    swap(i: j, j: j-1)
                    flag = true
                }
            }
        }
        return self
        
    }
    
}

