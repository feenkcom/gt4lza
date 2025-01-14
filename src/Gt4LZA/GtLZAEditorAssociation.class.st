Class {
	#name : #GtLZAEditorAssociation,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'node',
		'file',
		'type'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #accessing }
GtLZAEditorAssociation >> file [
	^ file
]

{ #category : #accessing }
GtLZAEditorAssociation >> file: anObject [
	file := anObject
]

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
	^ aView explicit
		title: 'Source';
		stencil: [ GtLZACoder new
				model: self model;
				file: self fromEntity file;
				highlight: self node;
				yourself ]
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

{ #category : #'as yet unclassified' }
GtLZAEditorAssociation >> model [
	^ self file model
]

{ #category : #'as yet unclassified' }
GtLZAEditorAssociation >> name [
	^ (self fromEntity
		ifNotNil: [ :entity | entity hasName ifTrue: [ entity name ] ])
		ifNil: [ self to ]
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
	^ self model entityNamed: to ofType: type
]

{ #category : #accessing }
GtLZAEditorAssociation >> type [
	^ type
]

{ #category : #accessing }
GtLZAEditorAssociation >> type: anObject [
	type := anObject
]
