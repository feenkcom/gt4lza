Class {
	#name : #GtLZAGroup,
	#superclass : #Object,
	#traits : 'TGtTypedGroupWithItems',
	#classTraits : 'TGtTypedGroupWithItems classTrait',
	#category : #'Gt4LZA-Model'
}

{ #category : #'as yet unclassified' }
GtLZAGroup >> findNamed: aString [
	^ self
		detect: [ :anItem | anItem name = aString ]
		ifNone: [ | item |
			item := self itemType new name: aString.
			self add: item.
			^ item ]
]

{ #category : #'as yet unclassified' }
GtLZAGroup >> itemType [
	^ self subclassResponsibility
]
