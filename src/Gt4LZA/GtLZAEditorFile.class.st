Class {
	#name : #GtLZAEditorFile,
	#superclass : #GtLZAEditorEntity,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'entities',
		'associations',
		'model',
		'fileReference',
		'announcer',
		'originalSource',
		'currentSource'
	],
	#category : #'Gt4LZA-Editor-Model'
}

{ #category : #adding }
GtLZAEditorFile >> addAssociation: anObject [
	self associations add: anObject.
	anObject file: self
]

{ #category : #adding }
GtLZAEditorFile >> addEntity: anObject [
	self entities add: anObject.
	anObject file: self
]

{ #category : #announcer }
GtLZAEditorFile >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #conversion }
GtLZAEditorFile >> asFileReference [
	^ self fileReference
]

{ #category : #accessing }
GtLZAEditorFile >> associations [
	^ associations ifNil: [ associations := OrderedCollection new ]
]

{ #category : #accessing }
GtLZAEditorFile >> associations: anObject [
	associations := anObject
]

{ #category : #accessing }
GtLZAEditorFile >> basename [
	^ fileReference basename
]

{ #category : #accessing }
GtLZAEditorFile >> cancel [
	self currentSource: self originalSource
]

{ #category : #testing }
GtLZAEditorFile >> containsReference: aFileReference [
	^ self fileReference containsReference: aFileReference
]

{ #category : #accessing }
GtLZAEditorFile >> currentSource [
	^ currentSource ifNil: [ currentSource := self originalSource ]
]

{ #category : #accessing }
GtLZAEditorFile >> currentSource: anObject [
	| original |
	currentSource = anObject ifTrue: [ ^ self ].
	original := currentSource.
	currentSource := anObject.
	self model updateFile: self asFileReference with: self originalSource.
	self
		announce: (GtLZAFileSourceChanged new
				file: self;
				oldSource: original;
				yourself)
]

{ #category : #accessing }
GtLZAEditorFile >> entities [
	^ entities ifNil: [ entities := IdentitySet new ]
]

{ #category : #accessing }
GtLZAEditorFile >> entities: anObject [
	entities := anObject
]

{ #category : #accessing }
GtLZAEditorFile >> file [
	^ self
]

{ #category : #accessing }
GtLZAEditorFile >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtLZAEditorFile >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #testing }
GtLZAEditorFile >> isDirectory [
	^ false
]

{ #category : #testing }
GtLZAEditorFile >> isModified [
	^ currentSource notNil and: [ self originalSource ~= currentSource ]
]

{ #category : #actions }
GtLZAEditorFile >> load [
	originalSource := fileReference exists
				ifTrue: [ fileReference contents ]
				ifFalse: [ '' ].
	self currentSource: originalSource
]

{ #category : #accessing }
GtLZAEditorFile >> model [
	^ model
]

{ #category : #accessing }
GtLZAEditorFile >> model: anObject [
	model := anObject
]

{ #category : #accessing }
GtLZAEditorFile >> originalSource [
	^ originalSource
		ifNil: [ originalSource := fileReference exists
					ifTrue: [ fileReference contents ]
					ifFalse: [ '' ] ]
]

{ #category : #accessing }
GtLZAEditorFile >> originalSource: anObject [
	originalSource := anObject
]

{ #category : #actions }
GtLZAEditorFile >> resetModel [
	entities := nil.
	associations := nil
]

{ #category : #actions }
GtLZAEditorFile >> save [
	fileReference ensureDelete.
	fileReference writeStreamDo: [ :stream | stream nextPutAll: currentSource ].
	self originalSource: currentSource.
	self
		announce: (GtLZAFileSourceChanged new
				file: self;
				oldSource: nil;
				yourself)
]

{ #category : #accessing }
GtLZAEditorFile >> source [
	^ node completeSource asString
]
