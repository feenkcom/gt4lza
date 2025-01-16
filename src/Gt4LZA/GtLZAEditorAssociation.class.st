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

{ #category : #views }
GtLZAEditorAssociation >> coder [
	^ GtLZACoder new
		model: self model;
		file: self fromEntity file;
		highlight: self node;
		yourself
]

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

{ #category : #'instance creation' }
GtLZAEditorAssociation >> fromEntity [
	^ self from
]

{ #category : #'gt - inspector' }
GtLZAEditorAssociation >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (GtPhlowExplicitTool new
				withLabelAndIconAptitude;
				name: 'LZA';
				icon: BrGlamorousVectorIcons browse;
				stencil: [ self coder ]);
		addTool: super gtDefaultInspectorTool
]

{ #category : #views }
GtLZAEditorAssociation >> gtFromFor: aView [
	<gtView>
	self fromEntity ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'From';
		priority: 12;
		object: [ self fromEntity ];
		view: #gtSourceFor:
]

{ #category : #views }
GtLZAEditorAssociation >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		stencil: [ self coder ]
]

{ #category : #views }
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
GtLZAEditorAssociation >> model [
	^ self file model
]

{ #category : #accessing }
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

{ #category : #accessing }
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
