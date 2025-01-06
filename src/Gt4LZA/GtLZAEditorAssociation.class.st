Class {
	#name : #GtLZAEditorAssociation,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'node'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #accessing }
GtLZAEditorAssociation >> from [
	^ from
]

{ #category : #accessing }
GtLZAEditorAssociation >> from: anObject [
	from := anObject
]

{ #category : #'as yet unclassified' }
GtLZAEditorAssociation >> fromEntity [
	^ self from
]

{ #category : #'as yet unclassified' }
GtLZAEditorAssociation >> gtFromFor: aView [
	<gtView>
	self fromEntity ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'From';
		priority: 12;
		object: [ self fromEntity ];
		view: #gtSourceFor:
]

{ #category : #'as yet unclassified' }
GtLZAEditorAssociation >> gtSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		priority: 10;
		object: [ node ];
		view: #gtSourceFor:
]

{ #category : #'as yet unclassified' }
GtLZAEditorAssociation >> gtToFor: aView [
	<gtView>
	self toEntity ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'To';
		priority: 15;
		object: [ self toEntity ];
		view: #gtSourceFor:
]

{ #category : #accessing }
GtLZAEditorAssociation >> node [
	^ node
]

{ #category : #accessing }
GtLZAEditorAssociation >> node: anObject [
	node := anObject
]

{ #category : #accessing }
GtLZAEditorAssociation >> to [
	^ to
]

{ #category : #accessing }
GtLZAEditorAssociation >> to: anObject [
	to := anObject
]

{ #category : #'as yet unclassified' }
GtLZAEditorAssociation >> toEntity [
	self subclassResponsibility
]
