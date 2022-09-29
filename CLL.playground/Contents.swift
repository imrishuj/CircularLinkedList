import UIKit

var array1 = [2,9,0,6,8,10]

public class LinkedListNode<T>  {

    public var data: T
    public var next: LinkedListNode?

    public init(data: T, next: LinkedListNode? = nil) {
        self.data = data
        self.next = next
    }
}

public struct CircularLinkedList<T>  {

    var headNode: LinkedListNode<T>?
    var tailNode: LinkedListNode<T>?

    public init() {
        self.headNode = nil
        self.tailNode = nil
    }

    // To check linked list is empty or not

    public var isEmpty: Bool {
        headNode == nil
    }
    
    // To count total number of nodes
       
    public var count: Int {
        guard var headNode = self.headNode else {
            return 0
        }
        var count = 1
        var firstIndex = 0
        while !(headNode === self.tailNode) {
            count += 1
            headNode = headNode.next!
            firstIndex += 1
        }
        return count
    }

    /* 1. display: Display the list from head to tail node. */

    public mutating func display() {
        print(self.headNode?.data as Any, terminator: " ");
        var tempNode: LinkedListNode<T>? = self.headNode?.next
        while (tempNode != nil && !(tempNode === self.headNode)) {
            print(tempNode?.data as Any, terminator: " ")
            tempNode = tempNode?.next
        }
    }

    /* 2. linearSearch: Search element in a list */

    public mutating func linearSearch(value: Int) -> LinkedListNode<T>? {
        var node = self.headNode
        while !(headNode === self.tailNode) {
            if let nnode = node, let data = nnode.data as? Int, data == value {
                return node
            }
            node = node?.next
        }
        return nil
    }

    /* 3. insert: Insert value in a list */

    public mutating func insert(value: T) {
        if self.headNode == nil {
            self.insertAtFirst(value: value)
        } else {
            self.insertAtLast(value: value)
        }
    }

    /* 4. insertAtFirst: Insert value before first position in a list */

    public mutating func insertAtFirst(value: T) {
        let newNode =  LinkedListNode(data: value, next: nil)
        if self.headNode == nil {
            headNode = newNode
            newNode.next = self.headNode
            tailNode = newNode
        } else {
            newNode.next = headNode
            headNode = newNode
            tailNode?.next = newNode
        }
    }
    
    /* 5. insert: Insert value at particular position in a list */
       
    public mutating func insert(value: T, index: Int) {
        if index == 0 {
            self.insertAtFirst(value: value)
        } else if index == self.count - 1 {
            self.insertAtLast(value: value)
        } else {
            var firstIndex = 0
            var node = self.headNode
            while (firstIndex < index) {
                node = node?.next
                firstIndex += 1
            }
            let newNode = LinkedListNode(data: value, next: node?.next)
            newNode.next = node?.next
            node?.next = newNode
        }
        
    }

    /* 6. insertAtLast: Insert value after last position in a list */

    public mutating func insertAtLast(value: T) {
        let newNode =  LinkedListNode(data: value, next: nil)
        self.tailNode?.next = newNode
        newNode.next = self.headNode
        self.tailNode = newNode
    }

    /* 7. deleteAtFirst: Delete first value */

    public mutating func deleteAtFirst() {
        guard self.headNode != nil else { return }
        if self.headNode === self.tailNode {
            self.headNode = nil
            self.tailNode = nil
        } else {
            var prevHeadNode = self.headNode
            self.tailNode?.next = prevHeadNode?.next
            self.headNode = prevHeadNode?.next
            prevHeadNode = nil
        }
    }

    /* 8. delete: Delete value at particular position in a list */

    public mutating func delete(index: Int) {
        guard self.headNode != nil else { return }
        var firstIndex = 0
        var node = self.headNode
        var tempNode: LinkedListNode<T>?
        while (firstIndex < index) {
            tempNode = node
            node = node?.next
            firstIndex += 1
        }
        tempNode?.next = node?.next
        node = nil
    }
}

/* Create and fetch linked list */

func createAndFetchLinkedList(array: inout [Int]) -> CircularLinkedList<Int> {
    var firstIndex = 0
    let lastIndex = array.count
    var list = CircularLinkedList<Int>()
    while (firstIndex < lastIndex) {
        list.insert(value: array[firstIndex])
        firstIndex += 1
    }
    return list
}

var circularlist1 = createAndFetchLinkedList(array: &array1)
print("List elements are", circularlist1.display())
print("Linear search is", circularlist1.linearSearch(value: 10) as Any)
print("Insert at first positon", circularlist1.insertAtFirst(value: 55), circularlist1.display())
print("Insert at positon", circularlist1.insert(value: 35, index: 3), circularlist1.display())
print("Insert at positon", circularlist1.insertAtLast(value: 16), circularlist1.display())
print("Delete at first positon", circularlist1.deleteAtFirst(), circularlist1.display())
print("Delete at positon", circularlist1.delete(index: 2), circularlist1.display())
