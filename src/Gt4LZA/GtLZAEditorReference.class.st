Class {
	#name : #GtLZAEditorReference,
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

{ #category : #views }
GtLZAEditorReference >> coder [
	| coder |
	coder := GtLZACoder new.
	coder model: self model.
	coder file: self fromEntity file.
	coder highlightedEntity: self.
	coder
		childNamed: #title
		ifFound: [ :each | each visibility: BlVisibility gone ].
	^ coder
]

{ #category : #accessing }
GtLZAEditorReference >> file [
	^ file
]

{ #category : #accessing }
GtLZAEditorReference >> file: anObject [
	file := anObject
]

{ #category : #accessing }
GtLZAEditorReference >> from [
	^ from
]

{ #category : #accessing }
GtLZAEditorReference >> from: anObject [
	from := anObject
]

{ #category : #'instance creation' }
GtLZAEditorReference >> fromEntity [
	^ self from
]

{ #category : #'gt - inspector' }
GtLZAEditorReference >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (GtPhlowExplicitTool new
				withLabelAndIconAptitude;
				name: 'LZA';
				icon: BrGlamorousVectorIcons browse;
				stencil: [ self coder ]);
		addTool: super gtDefaultInspectorTool
]

{ #category : #views }
GtLZAEditorReference >> gtFromFor: aView [
	<gtView>
	self fromEntity ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'From';
		priority: 12;
		object: [ self fromEntity ];
		view: #gtSourceFor:
]

{ #category : #views }
GtLZAEditorReference >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		stencil: [ self coder ]
]

{ #category : #views }
GtLZAEditorReference >> gtToFor: aView [
	<gtView>
	self toEntity ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'To';
		priority: 15;
		object: [ self toEntity ];
		view: #gtSourceFor:
]

{ #category : #accessing }
GtLZAEditorReference >> model [
	^ self file model
]

{ #category : #accessing }
GtLZAEditorReference >> name [
	^ (self fromEntity
		ifNotNil: [ :entity | entity hasName ifTrue: [ entity name ] ])
		ifNil: [ self to ]
]

{ #category : #accessing }
GtLZAEditorReference >> node [
	^ node
]

{ #category : #accessing }
GtLZAEditorReference >> node: anObject [
	node := anObject
]

{ #category : #accessing }
GtLZAEditorReference >> to [
	^ to
]

{ #category : #accessing }
GtLZAEditorReference >> to: anObject [
	to := anObject
]

{ #category : #accessing }
GtLZAEditorReference >> toEntity [
	^ self model entityNamed: to ofType: type
]

{ #category : #accessing }
GtLZAEditorReference >> type [
	^ type
]

{ #category : #accessing }
GtLZAEditorReference >> type: anObject [
	type := anObject
]
