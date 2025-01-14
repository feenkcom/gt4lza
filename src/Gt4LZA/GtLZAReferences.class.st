Class {
	#name : #GtLZAReferences,
	#superclass : #Object,
	#instVars : [
		'references'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #'as yet unclassified' }
GtLZAReferences >> gtReferencesView: aView [
	<gtView>
	^ (self isEmpty or: [ self hasMultiple ])
		ifTrue: [ aView list
				title: 'References';
				items: [ self references ];
				itemText: [ :each | each name asRopedText ] ]
		ifFalse: [ aView forward
				title: 'References';
				object: [ (self references next then: [ :a | a value ]) wait ];
				view: #gtSourceFor: ]
]

{ #category : #testing }
GtLZAReferences >> hasMultiple [
	| refs |
	refs := self references.
	^ (refs next await then: [ :a | refs hasNext wait ] otherwise: [ :a | false ])
		wait
]

{ #category : #testing }
GtLZAReferences >> isEmpty [
	^ self references isNotEmpty wait not
]

{ #category : #accessing }
GtLZAReferences >> references [
	^ references asyncSimilarCopy
]

{ #category : #accessing }
GtLZAReferences >> references: asyncStream [
	references := asyncStream cached
]
