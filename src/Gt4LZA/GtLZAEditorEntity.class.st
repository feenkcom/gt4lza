Class {
	#name : #GtLZAEditorEntity,
	#superclass : #Object,
	#instVars : [
		'node',
		'name',
		'file'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #'instance creation' }
GtLZAEditorEntity class >> name: aString node: ast [
	^ self new
		name: aString;
		node: ast;
		yourself
]

{ #category : #accessing }
GtLZAEditorEntity >> asyncReferences [
	^ (self model asyncFiles
		collect: [ :each | each associations asAsyncStream select: [ :ref | ref toEntity == self ] ])
		flatten
]

{ #category : #accessing }
GtLZAEditorEntity >> file [
	^ file
]

{ #category : #accessing }
GtLZAEditorEntity >> file: anObject [
	file := anObject
]

{ #category : #views }
GtLZAEditorEntity >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		stencil: [ GtLZACoder new
				model: self model;
				file: self file;
				highlight: self node;
				yourself ]
]

{ #category : #testing }
GtLZAEditorEntity >> hasName [
	^ name notNil
]

{ #category : #accessing }
GtLZAEditorEntity >> model [
	^ self file model
]

{ #category : #accessing }
GtLZAEditorEntity >> name [
	^ name ifNil: [ self class name , self identityHash printString ]
]

{ #category : #accessing }
GtLZAEditorEntity >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtLZAEditorEntity >> node [
	^ node
]

{ #category : #accessing }
GtLZAEditorEntity >> node: anObject [
	node := anObject.
	node ifNotNil: [ node attributeNamed: #entity put: self ]
]

{ #category : #accessing }
GtLZAEditorEntity >> references [
	^ GtLZAReferences new references: self asyncReferences
]
